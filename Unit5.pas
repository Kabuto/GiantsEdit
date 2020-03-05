unit Unit5;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, Dialogs;

type
  tColor4=array[0..3] of byte;
  TMap=class
    light : array of tColor4;
    height : array of single;
    triangle : array of byte;
    xoffset,yoffset,stretch :single;
    xl : longint;
    yl : longint;
    procedure SetSize(newxl,newyl :integer);
    procedure Clear;
    function getTriangle(x,y :integer):integer;
  end;
  TImportWizard = class(TForm)
    Image1: TImage;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    Label1: TLabel;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    BitBtn4: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    TabSheet2: TTabSheet;
    PreviousButton: TButton;
    NextButton: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    Label3: TLabel;
    Label4: TLabel;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    TabSheet3: TTabSheet;
    CheckBox5: TCheckBox;
    Panel1: TPanel;
    Label5: TLabel;
    RadioGroup3: TRadioGroup;
    Panel2: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit2: TEdit;
    Edit1: TEdit;
    TabSheet4: TTabSheet;
    Label10: TLabel;
    Panel3: TPanel;
    CheckBox6: TCheckBox;
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
    procedure PreviousButtonClick(Sender: TObject);
  private
    procedure Error(msg :PChar);
    function PageHasContent(page :integer):boolean;
    function PageAccepted(page :integer):boolean;
    procedure WizardFinished;
  public
    Map :TMap;
    { Public declarations }
  end;

var
  ImportWizard: TImportWizard;
  LightMap, HeightMap, MaskMap, TriangleMap :string;
  LightBitmap,HeightBitmap,MaskBitmap,TriangleBitmap :TBitmap;
  minheight,maxheight :single;
  xl,yl :integer;

implementation

{$R *.dfm}




procedure TMap.SetSize(newxl,newyl :integer);
  begin
    xl := newxl;
    yl := newyl;
    SetLength(light,xl*yl);
    SetLength(height,xl*yl);
    SetLength(triangle,xl*yl);
  end;

procedure TMap.Clear;
  var
    i :integer;
    color :tColor4;
  begin
    color[0] := 128; color[1] := 128; color[2] := 128; color[3] := 0;
    for i := 0 to xl*yl-1 do begin
      light[i] := color;
      height[i] := -40;
      triangle[i] := 5;
    end;
    stretch := 40;
    xoffset := -xl*20;
    yoffset := -yl*20;
  end;


function TMap.getTriangle(x,y :integer):integer;
  begin
    if (x<0) or (y<0) or (x>=xl-1) or (y>=yl-1) then
      Result := 0
    else
      Result := triangle[y*xl+x];
  end;

procedure TImportWizard.BitBtn8Click(Sender: TObject);
begin
   Application.MessageBox('A light map contains the luminance information for each terrain edge.'#13
    +'If it contains an alpha channel I will ask you what to do.'#13
    +'Light maps can have any format.'#13
    ,'Help');

end;

procedure TImportWizard.BitBtn5Click(Sender: TObject);
begin
   Application.MessageBox('Terrain maps contain the height of each terrain edge.'#13
    +'There are several ways for storing a terrain in a file; the next page will ask you for this.'#13
    +'If it contains an alpha channel a window will open asking you what to do.'#13
    +'Height maps must have either 8 or 24 bits per pixel.'
    ,'Help');
end;

procedure TImportWizard.BitBtn6Click(Sender: TObject);
begin
   Application.MessageBox('Mask maps are an alternative way to express which triangles should be drawn'#13
    +'and which should not. When you use a mask map it is converted to a triangle map.'#13
    +'Mask maps can have any color depth but must not contain other colors than pure black and pure white.'#13
    ,'Help');
end;

procedure TImportWizard.BitBtn7Click(Sender: TObject);
begin
   Application.MessageBox('Triangle maps contain information for each pair of triangles about which should be drawn.'#13
   +'The alpha channel of light map or height map can contain a triangle map.'#13
   +'A triangle map can also be built from the mask map (may need further manual corrections).'#13
   +'If there is no triangle map all triangles are drawn making the map look rectangular.'#13
   +'Triangle maps must have 8 bits per pixel; they can only use the following color indices:'#13
   +'      0 (no triangle)'#13'      3 (triangle which covers the (x,y+1) point)'#13'      5 (both triangles)'#13'      7 (triangle which covers the (x+1,y) point)','Help');
end;

procedure TImportWizard.CheckBox1Click(Sender: TObject);
begin
  if (CheckBox1.Checked) and (LightMap = '') then
    BitBtn1Click(nil);
end;

procedure TImportWizard.BitBtn1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then begin
    if LightMap = '' then
      CheckBox1.Checked := false;
    exit;
  end;
  LightMap := OpenDialog1.FileName;
  CheckBox1.Checked := true;
end;

procedure TImportWizard.FormShow(Sender: TObject);
begin
  LightMap := '';
  HeightMap := '';
  MaskMap := '';
  TriangleMap := '';
  CheckBox1.Checked := false;
  CheckBox2.Checked := false;
  CheckBox3.Checked := false;
  CheckBox4.Checked := false;
  CheckBox5.Checked := false;
  CheckBox6.Checked := false;
  LightBitmap := nil;
  HeightBitmap := nil;
  TriangleBitmap := nil;
  MaskBitmap := nil;
  PageControl1.ActivePageIndex := 0;
  PageHasContent(0);
  PageControl1.Top := -24;
end;

procedure TImportWizard.BitBtn2Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then begin
    if HeightMap = '' then
      CheckBox2.Checked := false;
    exit;
  end;
  HeightMap := OpenDialog1.FileName;
  CheckBox2.Checked := true;
end;

procedure TImportWizard.BitBtn3Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then begin
    if MaskMap = '' then
      CheckBox3.Checked := false;
    exit;
  end;
  MaskMap := OpenDialog1.FileName;
  CheckBox3.Checked := true;
end;

procedure TImportWizard.BitBtn4Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then begin
    if TriangleMap = '' then
      CheckBox4.Checked := false;
    exit;
  end;
  TriangleMap := OpenDialog1.FileName;
  CheckBox4.Checked := true;
end;

procedure TImportWizard.CheckBox2Click(Sender: TObject);
begin
  if (CheckBox2.Checked) and (HeightMap = '') then
    BitBtn2Click(nil);
end;

procedure TImportWizard.CheckBox4Click(Sender: TObject);
begin
  if (CheckBox4.Checked) and (TriangleMap = '') then
    BitBtn4Click(nil);
end;

procedure TImportWizard.CheckBox3Click(Sender: TObject);
begin
  if (CheckBox3.Checked) and (MaskMap = '') then
    BitBtn3Click(nil);
end;

procedure TImportWizard.Error(msg :PChar);
  begin
    Application.MessageBox(msg,'Error');
  end;

procedure TImportWizard.WizardFinished;
  type
    tByteList=array[0..313513] of bytE;
    tTripleByteList=array[0..313513,0..2] of bytE;
  const
    TriaMapTab :array[false..true,false..true] of byte=((0,3),(7,5));
    ConvTab :array[0..1,0..1,0..1,0..1] of byte=
    ((((0,0),(0,0)),((0,0),(0,0))),(((0,0),(0,3)),((0,7),(0,5))));
  var
    x,y :integer;
    c :longint;
    bl :^tByteList;
    tbl :^tTripleByteList;
  begin
    // this is the place where the real map creation process takes place
    // resize map if neccessary
    if Checkbox5.Checked then begin
      Map.SetSize(xl,yl);
      Map.Clear;
    end;
    // load the light map if there's one
    if CheckBox1.Checked then begin
      for y := 0 to yl-1 do
        for x := 0 to xl-1 do begin
          c := LightBitMap.Canvas.Pixels[x,y];
          Map.Light[(yl-1-y)*xl+x,0] := c and 255;
          Map.Light[(yl-1-y)*xl+x,1] := c shr 8 and 255;
          Map.Light[(yl-1-y)*xl+x,2] := c shr 16 and 255;
          Map.Light[(yl-1-y)*xl+x,3] := 0;
        end;
    end;

    // load the height map if there's one
    if CheckBox2.Checked then begin
      if HeightBitmap.PixelFormat = pf8bit then
        for y := 0 to yl-1 do begin
          bl := HeightBitmap.ScanLine[y];
          for x := 0 to xl-1 do
            Map.Height[(yl-1-y)*xl+x] := MinHeight+bl^[x]/255*(MaxHeight-MinHeight);
        end
      else if RadioGroup3.ItemIndex=1 then // blue is MSB
        for y := 0 to yl-1 do begin
          tbl := HeightBitmap.ScanLine[y];
          for x := 0 to xl-1 do
            Map.Height[(yl-1-y)*xl+x] := MinHeight+
             (tbl^[x,0]*65536+tbl^[x,1]*256+tbl^[x,2])/16777215*(MaxHeight-MinHeight);
        end
      else
        for y := 0 to yl-1 do begin
          tbl := HeightBitmap.ScanLine[y];
          for x := 0 to xl-1 do
            Map.Height[(yl-1-y)*xl+x] := MinHeight+
             (tbl^[x,2]*65536+tbl^[x,1]*256+tbl^[x,0])/16777215*(MaxHeight-MinHeight);
        end;
    end;

    // load the mask map if there's one
    if CheckBox3.Checked then begin
      for y := 0 to yl-2 do
        for x := 0 to xl-2 do
          Map.Triangle[(yl-1-y)*xl+x] :=
            convtab[
              MaskBitMap.Canvas.Pixels[x,y] and 1,
              MaskBitMap.Canvas.Pixels[x+1,y] and 1,
              MaskBitMap.Canvas.Pixels[x,y+1] and 1,
              MaskBitMap.Canvas.Pixels[x+1,y+1] and 1];
    end;

    // load the triangle map if there's one
    if CheckBox4.Checked then begin
      if TriangleBitmap.PixelFormat = pf8bit then
        for y := 0 to yl-1 do begin
          bl := HeightBitmap.ScanLine[y];
          for x := 0 to xl-1 do
            Map.Triangle[(yl-1-y)*xl+x] := bl^[x];
        end
{      else
        for y := 0 to yl-1 do begin
          tbl := TriangleBitmap.ScanLine[y];
          for x := 0 to xl-1 do begin // blue => triangles, green -> unknown
            Map.Triangle[(yl-1-y)*xl+x] := tbl^[x,0];
          end
        end;}
    end;

    // remove ground level triangles when asked for
    if CheckBox6.Checked then begin
      for y := 0 to yl-2 do
        for x := 0 to xl-2 do
          Map.triangle[y*xl+x] :=
            TriaMapTab[
              (Map.Height[(y  )*xl+(x  )]<>MinHeight)
           or (Map.Height[(y+1)*xl+(x  )]<>MinHeight)
           or (Map.Height[(y+1)*xl+(x+1)]<>MinHeight),
              (Map.Height[(y  )*xl+(x  )]<>MinHeight)
           or (Map.Height[(y  )*xl+(x+1)]<>MinHeight)
           or (Map.Height[(y+1)*xl+(x+1)]<>MinHeight)];
    end;


    //Application.MessageBox('The new map was built successfully','Finished');
    Close;
  end;

procedure TImportWizard.NextButtonClick(Sender: TObject);
  var
    i :integer;
  begin
    i := PageControl1.ActivePageIndex;
    if PageAccepted(i) then begin
      repeat
        inc(i);
        if i=PageControl1.PageCount then begin
          WizardFinished;
          exit
        end
      until PageHasContent(i);
      PageControl1.ActivePageIndex := i;
    end
  end;

procedure TImportWizard.PreviousButtonClick(Sender: TObject);
  var
    i :integer;
  begin
    i := PageControl1.ActivePageIndex;
    repeat
      dec(i)
    until PageHasContent(i);
    PageControl1.ActivePageIndex := i;
  end;


function TImportWizard.PageHasContent(page :integer):boolean;
  begin
    PreviousButton.Visible := (page<>0);
    if page<PageControl1.PageCount-1 then
      NextButton.Caption := 'Next >'
    else
      NextButton.Caption := 'Finish';
    NextButton.Visible := true;
    case page of
      1:PageHasContent := false;
      2:begin
        Panel1.Visible := (HeightBitmap <> nil) and (HeightBitmap.PixelFormat in
        [pf24Bit,pf32Bit]);
        Panel2.Visible := (HeightBitmap <> nil);
        PageHasContent := Panel1.Visible or Panel2.Visible;
        Panel3.Visible := (TriangleBitmap = nil);
      end
      else
        PageHasContent := true;
    end;
  end;

function TImportWizard.PageAccepted(page :integer):boolean;
type
  tByteList=array[0..313513] of bytE;
var
  Image :TBitmap;
  i :integer;
  x,y,c :integer;
  bo :boolean;
  p :^tByteList;
  code :integer;
begin
  PageAccepted := false;
//  Map := TMap.Create;
  case page of
    0:begin
      // nach Fehlern suchen
      if not (CheckBox1.Checked or CheckBox2.Checked or CheckBox3.Checked or CheckBox4.Checked) then begin
        Application.MessageBox('There is nothing to do!','Error');
        exit
      end;
      if (CheckBox3.Checked) and (CheckBox4.Checked) then begin
        Application.MessageBox('Mask map and triangle map must not be selected both at once','Error');
        exit
      end;
      // Bilder laden
      if (Checkbox1.Checked) then begin
        LightBitmap := TBitmap.Create;
        LightBitmap.LoadFromFile(lightmap)
      end
      else
        LightBitmap := nil;
      if (Checkbox2.Checked) then begin
        HeightBitmap := TBitmap.Create;
        HeightBitmap.LoadFromFile(heightmap);
        if not (HeightBitmap.PixelFormat in [pf8bit,pf24bit,pf32bit]) then begin
          Error('Heightmap must be either 8 bit or 24 bit (alpha channel optional)');
          exit
        end
      end
      else
        HeightBitmap := nil;
      if (Checkbox3.Checked) then begin
        MaskBitmap := TBitmap.Create;
        MaskBitmap.LoadFromFile(maskmap);
        bo := false;
        for y := 0 to yl-1 do
          for x := 0 to xl-1 do begin
            c := MaskBitmap.Canvas.Pixels[x,y];
            if (c<>0) and (c<>16777215) then
              bo := true;
          end;
        if bo then begin
          Error('Mask bitmap contains other colors than pure black and pure white. If you continue now the mask pixels will be clamped to either black or white depending on their color.');
          exit
        end
      end
      else
        MaskBitmap := nil;
      if (Checkbox4.Checked) then begin
        TriangleBitmap := TBitmap.Create;
        TriangleBitmap.LoadFromFile(Trianglemap);
        if not (TriangleBitmap.PixelFormat = pf8bit) then begin
          Error('Triangle map must be 8 bit');
          exit
        end;
{        bo := false;
        for y := 0 to yl-1 do begin
          p := TriangleBitmap.ScanLine[y];
          for x := 0 to xl-1 do begin
            c := p^[x];
            if (c<>0) and (c<>3) and (c<>5) and (c<>7) then
              bo := true;
          end;
        end;}
{        if bo then begin
          Error('Triangle list must not contain other values than'#13'0 (no triangle)'#13'3 (triangle which covers the (x,y+1) point)'#13'5 (both triangles)'#13'7 (triangle which covers the (x+1,y) point');
          exit
        end;}
      end
      else
        TriangleBitmap := nil;
      xl := Map.xl;
      yl := Map.yl;
      // Verschiedene Dimensionen? -> Fehler
      if CheckBox5.Checked then
        for i := 0 to 3 do begin
          Image := nil;
          case i of 0:Image := LightBitmap; 1:Image := HeightBitmap; 2:Image := MaskBitmap; 3:Image := TriangleBitmap; end;
          if (Image<>nil) then begin
            xl := Image.Width;
            yl := Image.Height;
            break
          end;
        end;
      for i := 0 to 3 do begin
        Image := nil;
        case i of
          0:Image := LightBitmap;
          1:Image := HeightBitmap;
          2:Image := MaskBitmap;
          3:Image := TriangleBitmap;
        end;
        if (Image<>nil) then
          if ((Image.Width<>xl) or (Image.Height<>yl)) then begin
            Error('Image dimensions are different from existing map');
            exit
          end
      end;
      PageAccepted := true;
    end;
    2:begin
      if Panel2.Visible then begin
        Val(Edit1.Text,minheight,code);
        if code<>0 then begin
          Error('Please enter a real number for minimum height');
          exit;
        end;
        Val(Edit2.Text,maxheight,code);
        if code<>0 then begin
          Error('Please enter a real number for maximum height');
          exit;
        end;
      end;
      PageAccepted := true;
    end;
    3:begin
      PageAccepted := true;
    end;
  end;
end;

end.
