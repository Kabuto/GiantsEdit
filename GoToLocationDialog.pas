unit GoToLocationDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TGotoLocationDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GotoLocationDlg: TGotoLocationDlg;

implementation

uses
  Unit1;

{$R *.dfm}

procedure TGotoLocationDlg.OKBtnClick(Sender: TObject);
  var
    x,y,z :single;
    code :integer;
  begin
    Val(Edit1.Text,x,code);
    if code<>0 then begin
      Application.MessageBox('X is invalid!','Error');
      exit
    end;
    Val(Edit2.Text,y,code);
    if code<>0 then begin
      Application.MessageBox('Y is invalid!','Error');
      exit
    end;
    Val(Edit3.Text,z,code);
    if code<>0 then begin
      Application.MessageBox('Z is invalid!','Error');
      exit
    end;
    eye[0] := x;
    eye[1] := y;
    eye[2] := z;
    ModalResult := mrOk;
  end;

end.
