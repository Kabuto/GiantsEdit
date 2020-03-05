unit ModelDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls,objectmanager;

type
  TForm12 = class(TForm)
    Panel1: TPanel;
    ListView1: TListView;
    Label1: TLabel;
    Edit1: TEdit;
    StatusBar1: TStatusBar;
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

{$R *.dfm}

procedure TForm12.Button1Click(Sender: TObject);
  var
    p,code :integer;
  begin
    Val(Edit1.Text,p,code);
    if (p<=0) or (p>=2048) or (code<>0) then begin
      Application.MessageBox('Invalid ID. Valid IDs range from 1 through 2048.','Error');
      exit
    end;
    if Checkbox1.Checked then begin
      ListView1.Clear;
    end;
    if not ShowModelDetail(p,ListView1) then
      Application.MessageBox('Object does not exist.','Error');
  end;

end.
