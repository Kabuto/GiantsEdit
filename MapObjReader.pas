unit MapObjReader;

interface

uses
  Forms,SysUtils;

type
  tMapObjVertex=record
    p :array[0..2] of single;
    c :array[0..2] of byte
  end;
  tMapObjTria=record
    vert: array[0..2] of tMapObjVertex;
  end;
  tMapObj=array of tMapObjTria;

var
  MapObj : array of tMapObj;
  ObjWrap : array[-256..4095] of longint;

procedure ReadMapFile(s :string;App :TApplication);

implementation

uses
  Unit1;

var
  Application :TApplication;

procedure ReadMapFile(s :string;App :TApplication);
  type
    tColor3=array[0..2] of byte;
    tInt3 = array[0..2] of longint;
  var
    t :text;
    colors :array of tColor3;
    vertex :array of tMapObjVertex;
    triangle :array of tInt3;
    section :integer;
    blockname :string;
    blockindex :integer;
    i,j,k,code :integer;

  function ValPart(var s :string):single;
    var
      s2 :string;
      code :integer;
      si :single;
    begin
      while (s<>'') and (s[1]<>',') do begin
        s2 := s2+s[1];
        s := copy(s,2,length(s)-1)
      end;
      if s<>'' then
        s := copy(s,2,length(s)-1);
      Val(s2,si,code);
      if code<>0 then
        Application.MessageBox(PChar(s2),'Number expected');
      ValPart := si;
    end;

  procedure CreateObject;
    var
      i,j,n :integer;
    begin
      n := length(MapObj);
      SetLength(MapObj,n+1);
      SetLength(MapObj[n],length(triangle));
      for i := 0 to length(triangle)-1 do
        for j := 0 to 2 do
          MapObj[n][i].vert[j] := vertex[triangle[i][j]];
      SetLength(colors,0);
      SetLength(vertex,0);
      SetLength(triangle,0);
    end;

  begin
    Application := App;
    AssignFile(t,s);
    Reset(t);
    section := 0;
    blockindex := -1;

    while not eof(t) do begin
      Readln(t,s);
      s := Trim(s);
      if s='' then continue;
      if s[1]=';' then continue;
      if s[1]='[' then begin
        if blockindex<>-1 then
          CreateObject;
        inc(blockindex);
        blockname := copy(s,2,length(s)-2);
        section := 0;
        continue;
      end;
      if s[1]='<' then begin
        if s='<Objects>' then
          Section := 1
        else if s='<Colors>' then
          Section := 2
        else if s='<Vertices>' then
          Section := 3
        else if s='<Triangles>' then
          Section := 4
        else
          Application.MessageBox(PChar(s),'Invalid section');
        continue;
      end;
      case Section of
        0:Application.MessageBox(PChar(s),'Null section error');
        1:begin // Objects
          if s='All' then
            for i := -256 to 4095 do
              ObjWrap[i] := blockindex
          else begin
            Val(s,i,code);
            if code=0 then
              ObjWrap[i] := blockindex
            else
              Application.MessageBox(PChar(s),'Number expected');
          end;
        end;
        2:begin // Colors
          j := length(colors);
          SetLength(colors,j+1);
          colors[j,0] := round(ValPart(s));
          colors[j,1] := round(ValPart(s));
          colors[j,2] := round(ValPart(s));
        end;
        3:begin // Vertices
          j := length(vertex);
          SetLength(vertex,j+1);
          vertex[j].p[0] := ValPart(s);
          vertex[j].p[1] := ValPart(s);
          vertex[j].p[2] := ValPart(s);
          k := round(ValPart(s));
          vertex[j].c[0] := colors[k,0];
          vertex[j].c[1] := colors[k,1];
          vertex[j].c[2] := colors[k,2];
        end;
        4:begin // Triangles
          j := length(triangle);
          SetLength(triangle,j+1);
          triangle[j][0] := round(ValPart(s));
          triangle[j][1] := round(ValPart(s));
          triangle[j][2] := round(ValPart(s));
        end;
      end;
    end;
    if length(triangle)<>0 then
      CreateObject;
    CloseFile(t);
  end;




end.
