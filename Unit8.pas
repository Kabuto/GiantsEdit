unit Unit8;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Mask;

type
  TNewMapDialog = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label5: TLabel;
    Label4: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    xl,yl :longint;
    filltype :longint;
  end;

var
  NewMapDialog: TNewMapDialog;

implementation

{$R *.dfm}

procedure TNewMapDialog.OKBtnClick(Sender: TObject);
var
  i,code :longint;
begin
  Val(Edit1.Text,xl,code);
  if (code<>0) or (xl<2) then begin
    Application.MessageBox('The width value is invalid!','Invalid data');
    exit
  end;
  if (xl>4096) then begin
    Application.MessageBox('The width value is by far too large!','Invalid data');
    exit
  end;
  Val(Edit2.Text,yl,code);
  if (code<>0) or (yl<2) then begin
    Application.MessageBox('The height value is invalid!','Invalid data');
    exit
  end;
  if (yl>4096) then begin
    Application.MessageBox('The height value is by far too large!','Invalid data');
    exit
  end;
  filltype := RadioGroup1.ItemIndex;
  ModalResult := mrOK;
end;

procedure TNewMapDialog.Button1Click(Sender: TObject);
begin
  Application.MessageBox('Make sure your terrain does not get too large!'#13'The product of width and height should not exceed 100000 for average graphic cards','Help')
end;

end.
