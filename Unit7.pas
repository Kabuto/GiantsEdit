unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm4 = class(TForm)
    ScrollBox2: TScrollBox;
    procedure ScrollBox2Resize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses
  Unit1;

procedure TForm4.ScrollBox2Resize(Sender: TObject);
begin
  gtieditor.resize;
end;

end.
