unit Unit10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ExtCtrls, TreeManager, TreeWrapper;

type
  TForm10 = class(TForm)
    Splitter4: TSplitter;
    TreeView1: TTreeView;
    ScrollBox1: TScrollBox;
    StatusBar1: TStatusBar;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Delete1: TMenuItem;
    Insertchild1: TMenuItem;
    Sortchilds1: TMenuItem;
    Cut1: TMenuItem;
    Pasteasnewchild1: TMenuItem;
    procedure Splitter4Moved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;
  wmwrapper :TTreeWrapper = nil;
//  nodeclip :TTreeHandle;

implementation

uses
  Unit1;

{$R *.dfm}

procedure TForm10.Splitter4Moved(Sender: TObject);
begin
  binwmeditor.Resize;
end;

procedure TForm10.FormResize(Sender: TObject);
begin
  binwmeditor.Resize;
end;

procedure TForm10.PopupMenu1Popup(Sender: TObject);
begin
  if TreeView1.Selected<>nil then
    PopupMenu1.Items.Items[0].Caption := TreeView1.Selected.Text
  else
    PopupMenu1.Items.Items[0].Caption := '<nil>';
end;

procedure TForm10.FormHide(Sender: TObject);
begin
  wmwrapper.HideEdit;
end;

procedure TForm10.FormShow(Sender: TObject);
begin
  wmwrapper.HideEdit;
end;

end.
