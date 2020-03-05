unit Includefiles;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TIncludefilesDlg = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IncludefilesDlg: TIncludefilesDlg;

implementation

{$R *.dfm}

uses bin_w_read,Unit1;

procedure TIncludefilesDlg.FormCreate(Sender: TObject);
begin
  Edit1.Text := '';
end;

procedure TIncludefilesDlg.Button1Click(Sender: TObject);
begin
  if Edit1.Text='' then
    exit;
  fbase.GetChildNode('[includefiles]').AddStringL('String',Edit1.Text,32);
  ModalResult := mrOk;
end;

end.
