unit CropDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TCropDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    CurrentMapSize: TStaticText;
    NewMapSize: TStaticText;
    Left: TEdit;
    Bottom: TEdit;
    Top: TEdit;
    Right: TEdit;
    Label1: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure UpdateImage;
    procedure ValueChange(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CropDlg: TCropDlg;
  HiddenImage :TPicture;

implementation

uses
  Unit1,Unit5;

{$R *.dfm}

procedure TCropDlg.UpdateImage;
  var
    FullRect :TRect;
    Brush :TBrush;
    Rect2 :TRect;
    code :longint;
    value :longint;
    vTop,vLeft,vBottom,vRight :integer;
    s1,s2 :string;
  begin
    FullRect.Left := 0;
    FullRect.Top := 0;
    FullRect.Right := HiddenImage.Bitmap.Width;
    FullRect.Bottom := HiddenImage.Bitmap.Height;
    Brush := TBrush.Create;
    Brush.Color := 16777215;
    Brush.Style := bsSolid;

    Image1.Picture.Bitmap.Canvas.CopyRect(FullRect,HiddenImage.Bitmap.Canvas,FullRect);
    Image1.Picture.Bitmap.Canvas.Brush := Brush;
    Val(Top.Text,value,code);
    vTop := value;
    if code=0 then begin
      Rect2.Left := 0; Rect2.Top := 0;
      Rect2.Right := HiddenImage.Width;
      Rect2.Bottom := value;
      Image1.Picture.Bitmap.Canvas.FillRect(Rect2);
    end;
    Val(Left.Text,value,code);
    vLeft := value;
    if code=0 then begin
      Rect2.Left := 0; Rect2.Top := 0;
      Rect2.Bottom := HiddenImage.Height;
      Rect2.Right := value;
      Image1.Picture.Bitmap.Canvas.FillRect(Rect2);
    end;
    Val(Bottom.Text,value,code);
    vBottom := value;
    if code=0 then begin
      Rect2.Left := 0; Rect2.Top := HiddenImage.Height-value;
      Rect2.Bottom := HiddenImage.Height;
      Rect2.Right := HiddenImage.Width;
      Image1.Picture.Bitmap.Canvas.FillRect(Rect2);
    end;
    Val(Right.Text,value,code);
    vRight := value;
    if code=0 then begin
      Rect2.Left := HiddenImage.Width-value; Rect2.Top := 0;
      Rect2.Bottom := HiddenImage.Height;
      Rect2.Right := HiddenImage.Width;
      Image1.Picture.Bitmap.Canvas.FillRect(Rect2);
    end;
    Str(HiddenImage.Width,s1);
    Str(HiddenImage.Height,s2);
    CurrentMapSize.Caption := 'Current map size: '+s1+' x '+s2+' vertices';
    Str(HiddenImage.Width-vLeft-vRight,s1);
    Str(HiddenImage.Height-vTop-vBottom,s2);
    NewMapSize.Caption := 'New map size: '+s1+' x '+s2+' vertices';
  end;

procedure TCropDlg.FormShow(Sender: TObject);
  var
    x,y,xl :longint;
  begin
    Left.Text := '0';
    Right.Text := '0';
    Top.Text := '0';
    Bottom.Text := '0';
    HiddenImage := TPicture.Create;
    HiddenImage.Bitmap.Width := terrain.xl;
    HiddenImage.Bitmap.Height := terrain.yl;
    HiddenImage.Bitmap.PixelFormat := pf32Bit;
    Image1.Picture.Bitmap.Width := terrain.xl;
    Image1.Picture.Bitmap.Height := terrain.yl;
    Image1.Picture.Bitmap.PixelFormat := pf32Bit;
    xl := terrain.xl;
    for y := 0 to terrain.yl-1 do
      for x := 0 to terrain.xl-1 do
        HiddenImage.Bitmap.Canvas.Pixels[x,y] :=
          terrain.light[y*xl+x,0]
         +terrain.light[y*xl+x,1]*256
         +terrain.light[y*xl+x,2]*65536;
    UpdateImage;
    Width := 224+Image1.Width;
    if Image1.Height+image1.Top+5<250 then
      Height := 250
    else
      Height := Image1.Height+image1.Top+5;
  end;

procedure TCropDlg.ValueChange(Sender: TObject);
begin
  UpdateImage;
end;

procedure TCropDlg.OKBtnClick(Sender: TObject);
  var
    vTop,vLeft,vBottom,vRight,code :integer;
    terrain2 :tMap;
    x,y :longint;
  begin
    Val(Top.Text,vTop,code);
    if (code<>0) or (vTop<0) then begin
      Application.MessageBox('Top value is invalid','Error');
      exit
    end;
    Val(Bottom.Text,vBottom,code);
    if (code<>0) or (vBottom<0) then begin
      Application.MessageBox('Bottom value is invalid','Error');
      exit
    end;
    Val(Left.Text,vLeft,code);
    if (code<>0) or (vLeft<0) then begin
      Application.MessageBox('Left value is invalid','Error');
      exit
    end;
    Val(Right.Text,vRight,code);
    if (code<>0) or (vRight<0) then begin
      Application.MessageBox('Right value is invalid','Error');
      exit
    end;
    if (vTop+vBottom+1>=HiddenImage.Height) or (vLeft+vRight+1>=HiddenImage.Width) then begin
      Application.MessageBox('At least 2x2 vertices must be left over','Error');
      exit
    end;
    // apply the changes
    terrain2 := tMap.Create;
    terrain2.SetSize(terrain.xl-vLeft-vRight,terrain.yl-vTop-vBottom);
    terrain2.Clear;
    terrain2.stretch := terrain.stretch;
    terrain2.xoffset := terrain.xoffset+terrain.stretch*vLeft;
    terrain2.yoffset := terrain.yoffset+terrain.stretch*vTop;
    for y := 0 to terrain2.yl-1 do
      for x := 0 to terrain2.xl-1 do begin
        terrain2.light[y*terrain2.xl+x] := terrain.light[(y+vTop)*terrain.xl+(x+vLeft)];
        terrain2.height[y*terrain2.xl+x] := terrain.height[(y+vTop)*terrain.xl+(x+vLeft)];
        terrain2.triangle[y*terrain2.xl+x] := terrain.triangle[(y+vTop)*terrain.xl+(x+vLeft)];
      end;
    // remove rightmost and bottommost triangles
    for y := 0 to terrain2.yl-1 do
      terrain2.triangle[y*terrain2.xl+terrain2.xl-1] := 0;
    for x := 0 to terrain2.xl-1 do
      terrain2.triangle[(terrain2.yl-1)*terrain2.xl+x] := 0;

    terrain.Destroy;
    terrain := terrain2;

    ModalResult := mrOk;
  end;

end.
