unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Menus, TreeManager, bin_w_read, TreeWrapper;

type
  TForm3 = class(TForm)
    TreeView1: TTreeView;
    ScrollBox1: TScrollBox;
    Splitter4: TSplitter;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Delete1: TMenuItem;
    Insertchild1: TMenuItem;
    Sortchilds1: TMenuItem;
    StatusBar1: TStatusBar;
    Cut1: TMenuItem;
    Pasteasnewchild1: TMenuItem;
    procedure Splitter4Moved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Pasteasnewchild1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  wrapper :TTreeWrapper = nil;
  nodeclip :TTreeHandle;

implementation

uses
  Unit1;

{$R *.dfm}

procedure TForm3.Splitter4Moved(Sender: TObject);
begin
  binweditor.Resize;
end;

procedure TForm3.FormResize(Sender: TObject);
begin
  binweditor.Resize;
end;


procedure TForm3.PopupMenu1Popup(Sender: TObject);
begin
  if TreeView1.Selected<>nil then
    PopupMenu1.Items.Items[0].Caption := TreeView1.Selected.Text
  else
    PopupMenu1.Items.Items[0].Caption := '<nil>';
end;

procedure TForm3.FormHide(Sender: TObject);
begin
  wrapper.HideEdit;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  wrapper.ShowEdit;
end;

procedure TForm3.Cut1Click(Sender: TObject);
begin
  Application.MessageBox('This feature was disabled due to major changes.','Error');
{  if wrapper.isnodeselected then begin
    nodeclip := wrapper.selectednode;
    nodeclip.unlink;
  end;
  wrapper.Reload;}
end;

procedure TForm3.Pasteasnewchild1Click(Sender: TObject);
begin
  Application.MessageBox('This feature was disabled due to major changes.','Error');
{  if wrapper.isnodeselected then begin
    wrapper.selectednode.link(nodeclip);
  end;
  wrapper.Reload;}
end;

end.
