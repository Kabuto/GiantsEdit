unit Unit11;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, TreeWrapper;
  
type
  TForm11 = class(TForm)
    ListBox1: TListBox;
    PopupMenu1: TPopupMenu;
    Newmission1: TMenuItem;
    Importmission1: TMenuItem;
    N1: TMenuItem;
    Exportmission1: TMenuItem;
    Deletemission1: TMenuItem;
    OpenMissionDlg: TOpenDialog;
    SaveMissionDlg: TSaveDialog;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Newmission1Click(Sender: TObject);
    procedure RefreshListbox;
    procedure RefreshViews;
    procedure Deletemission1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Importmission1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

{$R *.dfm}

uses
  Unit1,bin_w_read,Unit10;

procedure TForm11.PopupMenu1Popup(Sender: TObject);
  begin
    if (ListBox1.ItemIndex>0) then begin
      N1.Visible := true;
      Exportmission1.Visible := true;
      Deletemission1.Visible := true
    end
    else begin
      N1.Visible := false;
      Exportmission1.Visible := false;
      Deletemission1.Visible := false
    end;
  end;

procedure TForm11.RefreshListbox;
  var
    i :integer;
  begin
    ListBox1.ItemIndex := 0;
    RefreshViews;
    ListBox1.Items.Clear;
    ListBox1.Items.Add('- none -');
    for i := 0 to length(wmbase)-1 do
      Listbox1.Items.Add(wmbase[i].getName);
  end;

procedure TForm11.RefreshViews;
  begin
    if ListBox1.ItemIndex=-1 then
      ListBox1.ItemIndex := 0;
    if wmwrapper<>nil then begin
      wmwrapper.Destroy;
      wmwrapper := nil
    end;
    if Listbox1.ItemIndex>0 then
      wmwrapper := TTreeWrapper.Create(wmbase[Listbox1.ItemIndex-1],Form10.TreeView1,Form10.ScrollBox1);
    if (Form10.Visible) and (wmwrapper=nil) then
      Form10.Hide;
    wmbaseidx := ListBox1.ItemIndex-1;
  end;

procedure TForm11.Newmission1Click(Sender: TObject);
  var
    i,l :integer;
  begin
    l := ListBox1.ItemIndex;
    if l=-1 then l := length(wmbase);
    SetLength(wmbase,length(wmbase)+1);
    for i := length(wmbase)-2 downto l do
      wmbase[i+1] := wmbase[i];
    wmbase[l].CreateNewBase('wm_defaultmission_'+chr(random(26)+97)+chr(random(26)+97)+chr(random(26)+97)+chr(random(26)+97),rMissionData);
    wmbase[l].AddNode('<Objects>');
    wmbase[l].AddNode('<Options>');
    wmbase[l].GetChildNode('<Options>').addInt32('NoJetpack',0);
    wmbase[l].GetChildNode('<Options>').addInt32('NoNitro',0);
    wmbase[l].GetChildNode('<Options>').addInt32('Character 0',0);
    wmbase[l].GetChildNode('<Options>').addInt32('Character 1',0);
    wmbase[l].GetChildNode('<Options>').addInt32('Character 2',0);
    wmbase[l].GetChildNode('<Options>').addInt32('Character 3',0);
    wmbase[l].GetChildNode('<Options>').addInt32('Icons',0);
    RefreshListbox;
  end;

procedure TForm11.Deletemission1Click(Sender: TObject);
  var
    i,l :integer;
  begin
    l := ListBox1.ItemIndex;
    if l<1 then exit;
    dec(l);
    wmbase[l].Delete;
    for i := l to length(wmbase)-2 do
      wmbase[i] := wmbase[i+1];
    SetLength(wmbase,length(wmbase)-1);
    RefreshListBox;
  end;

procedure TForm11.ListBox1Click(Sender: TObject);
  begin
    if ListBox1.ItemIndex=-1 then
      ListBox1.ItemIndex := 0;
    RefreshViews;
  end;

procedure TForm11.ListBox1DblClick(Sender: TObject);
  begin
    Form2.Missionobjectstreeview1Click(nil);
  end;

procedure TForm11.Importmission1Click(Sender: TObject);
  var
    i,l :integer;
    b :tByteList;
    f :file;
    s :string;
  begin
    if not OpenMissionDlg.Execute then
      exit;

    l := ListBox1.ItemIndex;
    if l=-1 then l := length(wmbase);
    SetLength(wmbase,length(wmbase)+1);
    for i := length(wmbase)-2 downto l do
      wmbase[i+1] := wmbase[i];
    wmbaseidx := l;

    s := OpenMissionDlg.FileName;
    AssignFile(f,s);
    Reset(f,1);
    SetLength(b,FileSize(f));
    BlockRead(f,b[0],length(b));
    CloseFile(f);
    LoadBinWM(b);

    SetLength(b,0);

    RefreshListbox;
  end;

end.
