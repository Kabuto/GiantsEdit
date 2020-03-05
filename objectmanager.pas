unit objectmanager;

interface

uses
  SysUtils,OpenGL,ComCtrls;

const
  AVM_NOWRAP_X  = $00000001;
  AVM_NOWRAP_Y  = $00000002;
  AVM_ALPHAMIPS = $00000004;
  AVM_NOMIPS    = $00000008;
  AVM_CALLBACK  = $00000010;

var
  bounds :array[0..2047,0..1] of TGLArrayF3;
  boundrad :array[0..2047] of single;

function DrawModel(n :integer):boolean;
function ShowModelDetail(n :integer; lv :TListView):boolean;
function LoadTexture(filename :string):integer;
function getTextureHandle(n :integer):integer;
function Generate2DTexture(xl,yl :integer; format :GLEnum; buffer :pointer; flags :integer = 0):GLuint;
function Load2DTexture(name :string; flags :integer = 0):GLuint;

implementation

uses
  inclist,console,Unit1;

procedure glGenTextures(n: GLsizei; var textures: GLuint); stdcall; external 'opengl32.dll';
procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external 'opengl32.dll';

type
  tModelItem=packed record
    objname : array[0..31] of char;
    objindex : integer;
    refs : integer;
    wordz : integer;
    refs_ : word;

    refstart : integer;
    refnum : integer;
    texture : array[0..31] of char;
    bumptexture : array[0..31] of char;
    falloff,blend :single;
    flags :integer;
    emissive,ambient,diffuse,specular :integer;
    power :single;

    triangle :array of array[0..2] of word;
  end;
  tModel=class
    magic :integer;
    u1 :integer;
    basepoints :integer;
    basepoint :array of TGLArrayf3;
    texpos,
    vertexrefs :integer;
    vertexref :array of word;
    points :integer;
    point_1,point_2 :array of word;
    point_uv :array of array[0..1] of single;
    point_c :array of byte;
    ref1 :array of array[0..4] of integer;
    u2,u3,u4,u5,u6,u7 :integer;
    part :array of tModelItem;
    tex :array of integer;
    parts :integer;

    bounds1,bounds2 :TGLArrayf3;
    maxbound :single; 
  end;
  tTexGenProc=procedure(xl,yl,bpp :integer;buf :pointer); stdcall;

var
  texture :array of string;
  texturehandle :array of GLuint;
  textureparam :array of integer; // (bit 0=1 => transparent)
  giantsobject :array[0..2047] of tModel;
  texturepath :string;
  notexistingmodel :tModel;

function getTextureHandle(n :integer):integer;
  begin
    Result := texturehandle[n];
  end;

function LoadTextureImage(filename :string):integer;
  var
    i,l,loop,x,y,xl,yl,bpp :integer;
    f :file;
    tgaheader :array[0..8] of word;
    buf,buf1 :tMemFile;
    b :byte;
  begin
    l := length(texture);
    SetLength(texture,l+1);
    SetLength(texturehandle,l+1);
    SetLength(textureparam,l+1);

    texture[l] := filename;

    if filename[1]=':' then begin
      AssignFile(f,copy(filename,2,length(filename)));
      Reset(f,1);
      SetLength(buf,FileSize(f)-18);
      BlockRead(f,tgaheader,18);
      BlockRead(f,buf[0],length(buf));
      CloseFile(f);
    end
    else begin
      buf1 := Form2.LoadGZPFile(filename+'.tga');
      Move(buf1[0],tgaheader,18);
      SetLength(buf,length(buf1)-18);
      Move(buf1[18],buf[0],length(buf1)-18);
      SetLength(buf1,0);
    end;

    xl := tgaheader[6];
    yl := tgaheader[7];
    bpp := tgaheader[8] and $3F;

    if (bpp=16) or (bpp=32) then
      textureparam[l] := 1
    else
      textureparam[l] := 0;

    SetLength(buf1,length(buf));
    case bpp of
      24: begin
        for y := 0 to yl-1 do
          for x := 0 to xl-1 do begin
            buf1[(yl-1-y)*xl*3+x*3+2] := buf[y*xl*3+x*3+0];
            buf1[(yl-1-y)*xl*3+x*3+1] := buf[y*xl*3+x*3+1];
            buf1[(yl-1-y)*xl*3+x*3+0] := buf[y*xl*3+x*3+2];
          end;
      end;
      32: begin
        for y := 0 to yl-1 do
          for x := 0 to xl-1 do begin
            buf1[(yl-1-y)*xl*4+x*4+2] := buf[y*xl*4+x*4+0];
            buf1[(yl-1-y)*xl*4+x*4+1] := buf[y*xl*4+x*4+1];
            buf1[(yl-1-y)*xl*4+x*4+0] := buf[y*xl*4+x*4+2];
            buf1[(yl-1-y)*xl*4+x*4+3] := buf[y*xl*4+x*4+3];
          end;
       end;
      8:begin
        for y := 0 to yl-1 do
          for x := 0 to xl-1 do
            buf1[(yl-1-y)*xl+x] := buf[y*xl+x];
      end;
    end;
    // now the image is ready to be used.
    case bpp div 8*256+bpp div 8 of
        $303: begin
          texturehandle[l] := Generate2DTexture(xl,yl,GL_RGB,@buf1[0],0);
        end;
        $404: begin
           texturehandle[l] := Generate2DTexture(xl,yl,GL_RGBA,@buf1[0],0);
         end;
        $101:
          texturehandle[l] := Generate2DTexture(xl,yl,GL_LUMINANCE,@buf1[0],0);
        else
          ConsoleFrame.WriteMessage('Error loading texture: no handler for '+filename);
      end;
    SetLength(buf,0);
    SetLength(buf1,0);
    Result := l;
  end;

function LoadTexture(filename :string):integer;
  var
    i :integer;
  begin
    if filename='' then begin
      Result := -1;
      exit
    end;
    filename := AnsiUpperCase(filename);
    for i := 0 to length(texture)-1 do
      if texture[i]=filename then begin
        Result := i;
        exit
      end;
    Result := LoadTextureImage(filename);
  end;

{procedure TForm2.LoadBitmap(name :string);
const
  filenames :array[0..4] of string=(
  'gold.bmp','gold2.bmp','gold.bmp','gold2.bmp','gold.bmp');

var
  x, y, loop: Integer;
  bitmap :TBitmap;
begin
  halt(1);
(*  SetLength(texture,5);		                                // Set The Pointer To NULL
  for loop := 0 to 4 do
    texture[loop] := 0;

  glGenTextures(5, texture[0]);				// Create Five Textures

  for loop := 0 to 4 do begin				// Loop Through All 5 Textures

    bitmap := TBitmap.Create;
    bitmap.LoadFromFile(filenames[loop]);
    SetLength(bits,bitmap.Width*bitmap.Height);
    for y := 0 to bitmap.Height-1 do
      for x := 0 to bitmap.Width-1 do
        bits[y*bitmap.Width+x] := bitmap.Canvas.Pixels[x,y] or -$1000000;

    glBindTexture(GL_TEXTURE_2D, texture[loop]);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, 3, bitmap.Width, bitmap.Height,
				0, GL_RGBA, GL_UNSIGNED_BYTE, @bits[0]);
    Bitmap.Free;
  end;*)
end;}


function LoadModel(filename :string) :tModel;
var
  i,j,k,l,n : integer;
  f : file;
  part : integer;
  w :word;
  model :tModel;
  buf :tMemFile;
  bufpos :integer;
  r :single;

begin
  model := tModel.Create;
  result := nil;

  buf := Form2.LoadGZPFile(filename+'.gbs');
  if length(buf)=0 then
    exit;

  bufpos := 0;

  Move(buf[bufpos],model.magic,4); inc(bufpos,4);
  Move(buf[bufpos],model.u1,4); inc(bufpos,4);
  Move(buf[bufpos],model.basepoints,4); inc(bufpos,4);
  SetLength(model.basepoint,model.basepoints);
  Move(buf[bufpos],model.basepoint[0],model.basepoints*12); inc(bufpos,model.basepoints*12);

  if model.u1=7 then begin
    Move(buf[bufpos],model.texpos,4); inc(bufpos,4);
    Move(buf[bufpos],model.vertexrefs,4); inc(bufpos,4);
    SetLength(model.vertexref,model.vertexrefs);
    Move(buf[bufpos],model.vertexref[0],model.vertexrefs*2); inc(bufpos,model.vertexrefs*2);
  end;
  Move(buf[bufpos],i,4); inc(bufpos,4);
  model.points := i;
  SetLength(model.point_1,i);
  if model.u1=7 then SetLength(model.point_2,i);
  SetLength(model.point_uv,i);
  SetLength(model.point_c,i*3);
  Move(buf[bufpos],model.point_1[0],i*2); inc(bufpos,i*2);
  if model.u1=7 then begin
    Move(buf[bufpos],model.point_2[0],i*2); inc(bufpos,i*2);
  end;
  Move(buf[bufpos],model.point_uv[0],i*8); inc(bufpos,i*8);
  Move(buf[bufpos],model.point_c[0],i*3); inc(bufpos,i*3);
  Move(buf[bufpos],i,4); inc(bufpos,4);
  SetLength(model.ref1,i);
  Move(buf[bufpos],model.ref1[0],i*20); inc(bufpos,i*20);
  Move(buf[bufpos],model.parts,4); inc(bufpos,4);
  SetLength(model.part,model.parts);

  for part := 0 to model.parts-1 do begin
    Move(buf[bufpos],model.part[part].objname,46); inc(bufpos,46);
    SetLength(model.part[part].triangle,model.part[part].refs);
    Move(buf[bufpos],model.part[part].triangle[0],model.part[part].refs*6); inc(bufpos,model.part[part].refs*6);
    Move(buf[bufpos],model.part[part].refstart,104); inc(bufpos,104);
  end;
  while (filename<>'') and (filename[length(filename)]<>'\') do
    filename := copy(filename,1,length(filename)-1);
  SetLength(model.tex,model.parts);
  for part := 0 to model.parts-1 do
    model.tex[part] := LoadTexture(model.part[part].texture);

  // generate bounding box
  model.bounds1 := model.basepoint[0];
  model.bounds2 := model.basepoint[0];
  model.maxbound := 0;
  for i := 0 to length(model.basepoint)-1 do begin
    r := sqrt(sqr(model.basepoint[i][0])+sqr(model.basepoint[i][1])+sqr(model.basepoint[i][2]));
    if r>model.maxbound then
      model.maxbound := r;
  end;

  for i := 1 to length(model.basepoint)-1 do
    for j := 0 to 2 do begin
      if model.basepoint[i][j]<model.bounds1[j] then
        model.bounds1[j] := model.basepoint[i][j];
      if model.basepoint[i][j]>model.bounds2[j] then
        model.bounds2[j] := model.basepoint[i][j];
    end;

  result := model;
  SetLength(buf,0);
end;

function GetModel(n :integer):tModel;
  var
    i,j :integer;
    s,s2 :string;
  begin
    Result := nil;
    // object ID out of range -> break
    if (n<0) or (n>=2048) or (giantsobject[n]=notexistingmodel) then
      exit;
    // object already in database -> return it
    if (giantsobject[n]<>nil) then begin
      Result := giantsobject[n];
      exit
    end;
    // object not in database -> try to load it
    for i := 0 to length(includelist)-1 do
      if includelist[i].n = n then begin
        s := includelist[i].model;
        if s='' then begin
          Str(n,s);
          ConsoleFrame.WriteMessage('Error: Object '+s+' has empty model');
          exit
        end;
        j := pos('(',s);
        if j<>0 then begin
          s2 := copy(s,j+1,length(s)-j-1);
          s := copy(s,1,j-2);
          j := pos(',',s2);
          if j<>0 then s2 := copy(s2,1,j-1);
          j := pos('.',s2);
          if j<>0 then s2 := copy(s2,1,j-1);
          if s2='_' then
          else if (length(s2)=1) and (s2[1] in ['0'..'9']) then
            s := s+'_L'+s2
          else
            s := s2;
        end;
        giantsobject[n] := LoadModel(s);
        Result := giantsobject[n];
        if Result=nil then begin
          Str(n,s);
          ConsoleFrame.WriteMessage('Error: Object '+s+' has model '+s+' but model was not found.');
          giantsobject[n] := notexistingmodel;
        end;
      end;
    bounds[n][0] := giantsobject[n].bounds1;
    bounds[n][1] := giantsobject[n].bounds2;
    boundrad[n] := giantsobject[n].maxbound;
  end;

function DrawModel(n :integer):boolean;
var
  i,j,k,l :integer;
  model :tModel;
begin
  DrawModel := false;
  model := GetModel(n);
  if model=nil then
    exit;
  DrawModel := true;
  for i := 0 to length(model.part)-1 do begin
    if model.part[i].texture<>'' then begin
      if textureparam[model.tex[i]] and 1>0 then begin
        glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
        glEnable(GL_BLEND)
      end
      else begin
        glDisable(GL_BLEND)
      end;
      glEnable(GL_TEXTURE_2D);
      glBindTexture(GL_TEXTURE_2D,texturehandle[model.tex[i]]);
    end
    else
      glDisable(GL_TEXTURE_2D);

    glBegin(GL_TRIANGLES);
    for j := 0 to length(model.part[i].triangle)-1 do begin
      for k := 0 to 2 do begin
        l := model.part[i].triangle[j,k];
        glTexCoord2f(model.point_uv[l,0],model.point_uv[l,1]);
        glColor3f(
          model.point_c[l*3+0]/255+model.part[i].diffuse and 255/255,
          model.point_c[l*3+1]/255+model.part[i].diffuse shr 8 and 255/255,
          model.point_c[l*3+2]/255+model.part[i].diffuse shr 16 and 255/255);
        l := model.point_1[l];
        glVertex3f(model.basepoint[l,0],model.basepoint[l,1],model.basepoint[l,2]);
      end
    end;
    glEnd;
  end;
  glDisable(GL_TEXTURE_2D);
  glDisable(GL_BLEND);
end;




function Generate2DTexture(xl,yl :integer; format :GLEnum; buffer :pointer; flags :integer = 0):GLuint;
  var
    texture :GLuint;
    buffer2,buffer3 :array of byte;
    bpp :integer;
    x,y,i,n,xlo,ylo :integer;
    s :string;
    mipdivf :integer;
    callback :tTexGenProc;
  begin
(*    i := glGetError;
    if i<>0 then
      MessageBox(0,gluErrorString(cardinal(i)),'OpenGL Error',MB_OK or MB_ICONERROR);*)

    case format of
      GL_RGB:bpp := 3;
      GL_RGBA:bpp := 4;
      GL_LUMINANCE:bpp := 1
    end;

    glGenTextures(1, texture);				// Create one texture
    glBindTexture(GL_TEXTURE_2D, texture);
    if (flags and AVM_NOWRAP_X)<>0 then
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP)
    else
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_REPEAT);
    if (flags and AVM_NOWRAP_Y)<>0 then
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP)
    else
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
    if (flags and AVM_CALLBACK)<>0 then begin
      callback := buffer;

      if (flags and AVM_NOMIPS)<>0 then begin
        GetMem(buffer,xl*yl*bpp);
        Callback(xl,yl,bpp,buffer);
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
        glTexImage2D(GL_TEXTURE_2D, 0, format, xl,yl,
            0, format, GL_UNSIGNED_BYTE, buffer);
        FreeMem(buffer,xl*yl*bpp);
      end
      else begin
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_LINEAR);
        n := 0;
        if (flags and AVM_ALPHAMIPS)<>0 then
          mipdivf := 7
        else
          mipdivf := 4;
        repeat
          GetMem(buffer,xl*yl*bpp);
          Callback(xl,yl,bpp,buffer);
          glTexImage2D(GL_TEXTURE_2D, n, format, xl,yl,
            0, format, GL_UNSIGNED_BYTE, buffer);
          FreeMem(buffer,xl*yl*bpp);
          inc(n);
          xlo := xl;
          ylo := yl;
          xl := xl div 2;
          yl := yl div 2;
          if (xl=0) and (yl=0) then
            break;
          if xl=0 then xl := 1;
          if yl=0 then yl := 1;
        until false;
      end;
    end
    else begin
      if (flags and AVM_NOMIPS)<>0 then begin
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
        glTexImage2D(GL_TEXTURE_2D, 0, format, xl,yl,
            0, format, GL_UNSIGNED_BYTE, buffer);
      end
      else begin
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_LINEAR);
        case format of
          GL_RGB:bpp := 3;
          GL_RGBA:bpp := 4;
          GL_LUMINANCE:bpp := 1
        end;
        SetLength(buffer2,xl*yl*bpp);
        Move(buffer^,buffer2[0],xl*yl*bpp);
        n := 0;
        if (flags and AVM_ALPHAMIPS)<>0 then
          mipdivf := 7
        else
          mipdivf := 4;
        repeat
          glTexImage2D(GL_TEXTURE_2D, n, format, xl,yl,
            0, format, GL_UNSIGNED_BYTE, @buffer2[0]);
          inc(n);
          xlo := xl;
          ylo := yl;
          xl := xl div 2;
          yl := yl div 2;
          if (xl=0) and (yl=0) then
            break;
          if xl=0 then xl := 1;
          if yl=0 then yl := 1;
          SetLength(buffer3,xl*yl*bpp);
          for y := 0 to yl-1 do
            for x := 0 to xl-1 do begin
              for i := 0 to bpp-1 do
                buffer3[(y*xl+x)*bpp+i] :=
                 (integer(buffer2[((y*2) mod ylo*(xl*2)+(x*2) mod xlo)*bpp+i])
                 +integer(buffer2[((y*2) mod ylo*(xl*2)+(x*2+1) mod xlo)*bpp+i])
                 +integer(buffer2[((y*2+1) mod ylo*(xl*2)+(x*2) mod xlo)*bpp+i])
                 +integer(buffer2[((y*2+1) mod ylo*(xl*2)+(x*2+1) mod xlo)*bpp+i])
                 +1) div mipdivf;
            end;
          SetLength(buffer2,length(buffer3));
          Move(buffer3[0],buffer2[0],length(buffer2));
        until false;
        SetLength(buffer2,0);
        SetLength(buffer3,0);
      end;
    end;
    Result := texture;
  end;

function Load2DTexture(name :string; flags :integer = 0):GLuint;
  var
    i,l,loop,x,y,xl,yl,bpp,bppnew :integer;
    f :file;
    tgaheader :array[0..8] of word;
    buf :array of byte;
    alphabuf :^tByteArray;
    b :byte;
  begin
    AssignFile(f,name);
    Reset(f,1);
    SetLength(buf,FileSize(f)-18);
    BlockRead(f,tgaheader,18);
    BlockRead(f,buf[0],length(buf));
    CloseFile(f);

    xl := tgaheader[6];
    yl := tgaheader[7];
    bpp := tgaheader[8] and $3F;

    case bpp of
      24: begin
        for y := 0 to yl-1 do
          for x := 0 to xl-1 do begin
            b := buf[y*xl*3+x*3+0];
            buf[y*xl*3+x*3+0] := buf[y*xl*3+x*3+2];
            buf[y*xl*3+x*3+2] := b;
          end;
      end;
      32: begin
        for y := 0 to yl-1 do
          for x := 0 to xl-1 do begin
            b := buf[y*xl*4+x*4+0];
            buf[y*xl*4+x*4+0] := buf[y*xl*4+x*4+2];
            buf[y*xl*4+x*4+2] := b;
          end;
       end;
      8:
    end;



    bppnew := bpp;
    // now the image is ready to be used.
    case bpp div 8*256+bppnew div 8 of
        $303: begin
          Result := Generate2DTexture(xl,yl,GL_RGB,@buf[0],flags);
        end;
        $404: begin
           Result := Generate2DTexture(xl,yl,GL_RGBA,@buf[0],flags);
         end;
        $101:
          Result := Generate2DTexture(xl,yl,GL_LUMINANCE,@buf[0],flags);
        else
          ConsoleFrame.WriteMessage('Error loading texture: no handler for '+name);
      end;
    SetLength(buf,0);
//    SetLength(buf2,0);
  end;

function rgbastring(c :cardinal):string;
  var
    s,s2 :string;
  begin
    Str(c and 255,s);  s2 := s;  c := c div 256;
    Str(c and 255,s);  s2 := s2+','+s; c := c div 256;
    Str(c and 255,s);  s2 := s2+','+s; c := c div 256;
    Str(c and 255,s);  s2 := s2+','+s; c := c div 256;
    Result := s2;
  end;

function ShowModelDetail(n :integer; lv :TListView):boolean;
var
  i,j,k,l :integer;
  c :cardinal;
  model :tModel;
  li :TListItem;
  s,s2 :string;
begin
  Result := false;
  model := GetModel(n);
  if model=nil then
    exit;
  Result := true;
  for i := 0 to length(model.part)-1 do begin
    li := lv.Items.Add;
    li.Caption := model.part[i].objname;
    Str(model.part[i].objindex,s);  li.SubItems.Add(s);
    li.SubItems.Add(model.part[i].texture);
    li.SubItems.Add(model.part[i].bumptexture);
    Str(model.part[i].falloff:7:5,s);  li.SubItems.Add(s);
    Str(model.part[i].blend:7:5,s);  li.SubItems.Add(s);
    s := '';
    c := model.part[i].flags;
    for j := 0 to 31 do begin
      if (c and 1)=1 then begin
        Str(j,s2);
        s := s+s2+' ';
      end;
      c := c div 2;
    end;
    if s<>'' then s := copy(s,1,length(s)-1);
    li.SubItems.Add(s);
    li.SubItems.Add(rgbastring(model.part[i].emissive));
    li.SubItems.Add(rgbastring(model.part[i].ambient));
    li.SubItems.Add(rgbastring(model.part[i].diffuse));
    li.SubItems.Add(rgbastring(model.part[i].specular));
    Str(model.part[i].power:7:5,s);  li.SubItems.Add(s);
  end;
end;

var
  i :integer;

begin
  for i := 0 to 2047 do
    giantsobject[i] := nil;
  notexistingmodel := tModel.Create;
  notexistingmodel.bounds1[0] := 0;
  notexistingmodel.bounds1[1] := 0;
  notexistingmodel.bounds1[2] := 0;
  notexistingmodel.bounds2[0] := 0;
  notexistingmodel.bounds2[1] := 0;
  notexistingmodel.bounds2[2] := 0;
end.
