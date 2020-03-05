unit EasyGTI;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls;

type
  TEasyGTIDialog = class(TForm)
    ListView1: TListView;
    Panel1: TPanel;
    CancelBtn: TButton;
    OKBtn: TButton;
    Browse: TButton;
    procedure ListView1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EasyGTIDialog: TEasyGTIDialog;

implementation

{$R *.dfm}

procedure TEasyGTIDialog.ListView1DblClick(Sender: TObject);
  begin
    ModalResult := mrOk;
  end;

end.
