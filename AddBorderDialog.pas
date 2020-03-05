unit AddBorderDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAddBorderDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Top: TEdit;
    Left: TEdit;
    Right: TEdit;
    Bottom: TEdit;
    CurrentMapSize: TStaticText;
    NewMapSize: TStaticText;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    procedure UpdateImage;
    procedure FormShow(Sender: TObject);
    procedure ValueChange(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddBorderDlg: TAddBorderDlg;

implementation

uses Unit1,Unit5;

procedure TAddBorderDlg.UpdateImage;
  var
    code :longint;
    value :longint;
    vTop,vLeft,vBottom,vRight :integer;
    s1,s2 :string;
  begin
    Val(Top.Text,value,code);
    vTop := value;
    Val(Left.Text,value,code);
    vLeft := value;
    Val(Bottom.Text,value,code);
    vBottom := value;
    Val(Right.Text,value,code);
    vRight := value;

    Str(terrain.xl,s1);
    Str(terrain.yl,s2);
    CurrentMapSize.Caption := 'Current map size: '+s1+' x '+s2+' vertices';
    Str(terrain.xl+vLeft+vRight,s1);
    Str(terrain.yl+vTop+vBottom,s2);
    NewMapSize.Caption := 'New map size: '+s1+' x '+s2+' vertices';
  end;

procedure TAddBorderDlg.FormShow(Sender: TObject);
  begin
    Left.Text := '0';
    Right.Text := '0';
    Top.Text := '0';
    Bottom.Text := '0';
    UpdateImage;
  end;

procedure TAddBorderDlg.ValueChange(Sender: TObject);
begin
  UpdateImage;
end;

procedure TAddBorderDlg.OKBtnClick(Sender: TObject);
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
    if (vTop+vBottom>16384) or (vLeft+vRight>16384) or ((vTop+vBottom)*(vLeft+vRight)>40000000) then begin
      Application.MessageBox('Your values are a bit too large...','Error');
      exit
    end;
    // apply the changes
    terrain2 := tMap.Create;
    terrain2.SetSize(terrain.xl+vLeft+vRight,terrain.yl+vTop+vBottom);
    terrain2.Clear;
    if RadioButton1.Checked then
      for y := 0 to terrain2.yl-2 do
        for x := 0 to terrain2.xl-2 do
          terrain2.triangle[y*terrain2.xl+x] := 5
    else
      for y := 0 to terrain2.yl-2 do
        for x := 0 to terrain2.xl-2 do
          terrain2.triangle[y*terrain2.xl+x] := 0;
    terrain2.stretch := terrain.stretch;
    terrain2.xoffset := terrain.xoffset-terrain.stretch*vLeft;
    terrain2.yoffset := terrain.yoffset-terrain.stretch*vTop;
    for y := 0 to terrain.yl-1 do
      for x := 0 to terrain.xl-1 do begin
        terrain2.light[(y+vTop)*terrain2.xl+(x+vLeft)] := terrain.light[y*terrain.xl+x];
        terrain2.height[(y+vTop)*terrain2.xl+(x+vLeft)] := terrain.height[y*terrain.xl+x];
      end;

    for y := 0 to terrain.yl-2 do
      for x := 0 to terrain.xl-2 do
        terrain2.triangle[(y+vTop)*terrain2.xl+(x+vLeft)] := terrain.triangle[y*terrain.xl+x];
        
    terrain.Destroy;
    terrain := terrain2;

    ModalResult := mrOk;
  end;


{$R *.dfm}


end.
