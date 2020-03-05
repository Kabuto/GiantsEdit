unit ABX2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls;

type
  TABXWhichLOD = class(TForm)
    ListView1: TListView;
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ABXWhichLOD: TABXWhichLOD;

implementation

uses
  Unit1;

{$R *.dfm}

procedure TABXWhichLOD.ListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if ListView1.ItemIndex=-1 then
    exit;
  ABXDrawWhat := ListView1.ItemIndex-1;
  Form2.Draww;
end;

end.
