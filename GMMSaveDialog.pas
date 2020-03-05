unit GMMSaveDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TGMMSaveDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    StaticText1: TStaticText;
    procedure OKBtnClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    path :string;
    filename :string;
  end;

var
  GMMSaveDlg: TGMMSaveDlg;

implementation

{$R *.dfm}

procedure TGMMSaveDlg.OKBtnClick(Sender: TObject);
begin
  if RadioGroup1.ItemIndex=-1 then begin
    Application.MessageBox('You must select an option','Error');
    exit
  end;
  if Edit1.Text='' then begin
    Application.MessageBox('Specify a file name','Error');
    exit
  end;
  filename := path+radiogroup1.Items.Strings[radiogroup1.ItemIndex]+'_'+edit1.Text+'.gti';
  if fileexists(filename) then
    if Application.MessageBox('Do you want to overwrite it?','File exists.',MB_YESNO)=idno then
      exit;
  modalresult := mrOk;
end;

procedure TGMMSaveDlg.Edit1Change(Sender: TObject);
begin
  if radiogroup1.ItemIndex<>-1 then
    statictext1.Caption := 'File name:'#13+path+radiogroup1.Items.Strings[radiogroup1.ItemIndex]+'_'+edit1.Text+'.gti';
end;

end.
