unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, ComCtrls;

type
  TForm3 = class(TForm)
    StatusBar1: TStatusBar;
    ValueListEditor1: TValueListEditor;
    procedure FormCreate(Sender: TObject);
    procedure ValueListEditor1Exit(Sender: TObject);
    procedure ValueListEditor1KeyPress(Sender: TObject; var Key: Char);
    procedure ValueListEditor1SelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}


procedure TForm3.FormCreate(Sender: TObject);
begin
  ValueListEditor1.InsertRow('signature','',true);
  ValueListEditor1.InsertRow('unknown0','',true);
  ValueListEditor1.InsertRow('x offset','',true);
  ValueListEditor1.InsertRow('y offset','',true);
  ValueListEditor1.InsertRow('minimum height','',true);
  ValueListEditor1.InsertRow('maximum height','',true);
  ValueListEditor1.InsertRow('x length (vertex cols)','',true);
  ValueListEditor1.InsertRow('y length (vertex rows)','',true);
  ValueListEditor1.InsertRow('horizontal streching','',true);
  ValueListEditor1.InsertRow('unknown1','',true);
  ValueListEditor1.InsertRow('unknown2','',true);
  ValueListEditor1.InsertRow('unknown3','',true);
  ValueListEditor1.InsertRow('unknown4','',true);
  ValueListEditor1.InsertRow('unknown5','',true);
  ValueListEditor1.InsertRow('unknown6','',true);
  ValueListEditor1.InsertRow('unknown7','',true);
  ValueListEditor1.InsertRow('unknown8','',true);
  ValueListEditor1.InsertRow('unknown9','',true);
end;

procedure TForm3.ValueListEditor1Exit(Sender: TObject);
begin
  StatusBar1.SimpleText := chr(random(26)+65)+chr(random(26)+65)+chr(random(26)+65);
end;

procedure TForm3.ValueListEditor1KeyPress(Sender: TObject; var Key: Char);
begin
  Key := chr(ord(Key) xor 1);

end;

procedure TForm3.ValueListEditor1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
  var
    s1,s2 :string;
  begin
    if ACol=1 then case ARow of
      1:StatusBar1.SimpleText := 'Do not change this one!';
      2:StatusBar1.SimpleText := 'unknown';
      3:StatusBar1.SimpleText := 'this value is added to the terrain x position';
      4:StatusBar1.SimpleText := 'this value is added to the terrain y position';
      5:StatusBar1.SimpleText := 'does not affect gameplay';
      6:StatusBar1.SimpleText := 'does not affect gameplay';
      7:StatusBar1.SimpleText := 'should not exceed 255';
      8:StatusBar1.SimpleText := 'should not exceed 255';
      9:StatusBar1.SimpleText := 'all x and y coordinates are multiplied with this value (before offset is added)';
      10..18:StatusBar1.SimpleText := 'this one is absolutely meaningless';
    end;
  end;

end.
