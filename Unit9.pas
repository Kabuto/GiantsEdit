unit Unit9;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, TrueValue;

type
  TStretchDialog = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    XOffset: TEdit;
    YOffset: TEdit;
    Stretch: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    procedure OKBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StretchDialog: TStretchDialog;

implementation
uses
  Unit1;

{$R *.dfm}

procedure TStretchDialog.OKBtnClick(Sender: TObject);
  var
    xo,yo,st :single;
    code :longint;
  begin
    Val(Stretch.Text,st,code);
    if code<>0 then begin
      Application.MessageBox('Invalid value in field "Stretch"','Error');
      exit
    end;
    if (st<0) or (st>40000) then begin
      Application.MessageBox('Out of range value in field "Stretch"','Error');
      exit
    end;
    Val(XOffset.Text,xo,code);
    if code<>0 then begin
      Application.MessageBox('Invalid value in field "XOffset"','Error');
      exit
    end;
    if (xo<-40000) or (xo>40000) then begin
      Application.MessageBox('Out of range value in field "XOffset"','Error');
      exit
    end;
    Val(YOffset.Text,yo,code);
    if code<>0 then begin
      Application.MessageBox('Invalid value in field "YOffset"','Error');
      exit
    end;
    if (yo<-40000) or (yo>40000) then begin
      Application.MessageBox('Out of range value in field "XOffset"','Error');
      exit
    end;
    terrain.stretch := st;
    terrain.xoffset := xo;
    terrain.yoffset := yo;
    modalresult := mrOk;
  end;

procedure TStretchDialog.FormShow(Sender: TObject);
begin
  stretch.Text := StrSingle(terrain.stretch);
  xoffset.Text := StrSingle(terrain.xoffset);
  yoffset.Text := StrSingle(terrain.yoffset);
end;

procedure TStretchDialog.Button1Click(Sender: TObject);
  var
    st :single;
    code :longint;
  begin
    Val(Stretch.Text,st,code);
    if code=0 then begin
      xoffset.Text := StrSingle(st*terrain.xl*-0.5);
      yoffset.Text := StrSingle(st*terrain.yl*-0.5);
    end
  end;

end.
