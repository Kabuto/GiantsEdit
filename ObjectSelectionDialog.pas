unit ObjectSelectionDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TNewObjectDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Edit1: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ComboBox1: TComboBox;
    procedure OKBtnClick(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    objectid,aiid :integer;
    { Public declarations }
  end;

var
  NewObjectDlg: TNewObjectDlg;

implementation

{$R *.dfm}

procedure TNewObjectDlg.OKBtnClick(Sender: TObject);
  var
    i,code :integer;
  begin
    objectid := -1;
    aiid := -1;
    if RadioButton2.Checked then begin
      case ComboBox1.ItemIndex of
        0:objectid := 981;
        1:objectid := 985;
        2:objectid := 1334;
        3..9:begin
          objectid := 679;
          case ComboBox1.ItemIndex of
            3:aiid := 1;
            4:aiid := 2;
            5:aiid := 3;
            6:aiid := 4;
            7:aiid := 27;
            8:aiid := 22;
            9:aiid := 23;
          end
        end
        else
          Application.MessageBox('Object not found in list - contact author','Error');
      end;
    end
    else begin
      Val(Edit1.Text,i,code);
      if code<>0 then
        Application.MessageBox('This is not a number!','Error')
      else
        if (i<0) or (i>4096) then
          Application.MessageBox('Object ID out of range!','Error')
        else
          objectid := i;
    end;
    if objectid<>-1 then
      ModalResult := mrOk;
  end;

procedure TNewObjectDlg.RadioButton2Click(Sender: TObject);
begin
  Edit1.Enabled := false;
  ComboBox1.Enabled := true
end;

procedure TNewObjectDlg.RadioButton1Click(Sender: TObject);
begin
  Edit1.Enabled := true;
  ComboBox1.Enabled := false
end;

end.


