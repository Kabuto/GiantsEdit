unit Console;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TConsoleFrame = class(TForm)
    Panel1: TPanel;
    RichEdit1: TRichEdit;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure WriteMessage(s :string);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConsoleFrame: TConsoleFrame;

implementation

var
  LogDebug :boolean=true;

{$R *.dfm}


procedure TConsoleFrame.FormCreate(Sender: TObject);
  begin
    RichEdit1.DefAttributes.Color := $6080FF;
  end;

procedure TConsoleFrame.WriteMessage(s :string);
  begin
    if not LogDebug then exit;
    if s='' then
      exit;
    Show;
//    RichEdit1.ReadOnly := false;
    RichEdit1.SelStart := 1000000000;
    if not (s[length(s)] in [#13,#10]) then
      s := s+#13#10;
    RichEdit1.SelText := s+#13#10;
    Richedit1.SelAttributes.Color := $FFA080;
    RichEdit1.SelStart := 1000000000;
    self.Paint;
//    RichEdit1.ReadOnly := true;
  end;

procedure TConsoleFrame.FormResize(Sender: TObject);
begin
  if Width<251 then
    Width := 251;
  if Height<100 then
    Height := 100;
end;


procedure TConsoleFrame.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TConsoleFrame.Button2Click(Sender: TObject);
var
  f :file;
  s :string;
begin
  if not SaveDialog1.Execute then exit;
  AssignFile(f,SaveDialog1.FileName);
  Rewrite(f);
  s := RichEdit1.Text;
  BlockWrite(f,s[1],length(s));
  CloseFile(f);
end;

procedure TConsoleFrame.Button1Click(Sender: TObject);
begin
  RichEdit1.SelectAll;
  RichEdit1.CopyToClipboard;
end;

procedure TConsoleFrame.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Hide;
  CanClose := false;
end;

procedure TConsoleFrame.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key<>VK_Execute) or (Edit1.Text='') then exit;
  WriteMessage(Edit1.Text+#13+'Error: Unknown command');
end;

procedure TConsoleFrame.Button3Click(Sender: TObject);
  begin
    LogDebug := not LogDebug;
    if LogDebug then
      Button3.Caption := 'Pause'
    else
      Button3.Caption := 'Continue'
  end;

end.
