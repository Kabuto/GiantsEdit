unit ABX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, TrueValue, ABX2;


type
  TABXmanager = class(TForm)
    MainMenu1: TMainMenu;
    Init1: TMenuItem;
    CollectABXdata1: TMenuItem;
    Item1: TMenuItem;
    Display1: TMenuItem;
    StatusBar1: TStatusBar;
    ListView1: TListView;
    OpenDialog1: TOpenDialog;
    procedure CollectABXdata1Click(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  tABXBox=record
    LoD :longint;
    p1,p2 :array[0..2] of single
  end;
  tABXEntry=record
    index :longint;
    boxes :array of tABXBox
  end;

var
  ABXmanager: TABXmanager;
  abxlist :array of tABXEntry;

implementation

{$R *.dfm}

uses
  Unit1;

procedure TABXmanager.CollectABXdata1Click(Sender: TObject);
  var
    fi :longint;
    f :file;
    magic :longint;
    entry :tABXEntry;
    i,j,l :longint;
    s,s2 :string;
    tli :tListItem;
  begin
    if not OpenDialog1.Execute then
      exit;
    SetLength(abxlist,0);
    for fi := 0 to OpenDialog1.Files.Count-1 do begin
      AssignFile(f,opendialog1.files.Strings[fi]);
      Reset(f,1);
      BlockRead(f,magic,4);
      while not eof(f) do begin
        BlockRead(f,entry.index,4);
        SetLength(entry.boxes,0);
        l := 0;
        repeat
          i := length(entry.boxes);
          SetLength(entry.boxes,i+1);
          entry.boxes[i].LoD := l;
          BlockRead(f,entry.boxes[i].p1,24);
          BlockRead(f,l,4);
        until l=-1;
        if entry.index>=length(abxlist) then begin
          j := length(abxlist);
          SetLength(abxlist,entry.index+1);
          for i := j to length(abxlist)-1 do
            abxlist[i].index := -1;
        end;
        if abxlist[entry.index].index =-1 then
          abxlist[entry.index] := entry
        else begin
        end;
        for i := 0 to length(abxlist)-1 do
          if abxlist[i].index=entry.index then
            j := i;
        if j=-1 then begin
          SetLength(abxlist,length(abxlist)+1);
        end;
      end;
      CloseFile(f);
    end;
    ListView1.Clear;
    for i := 0 to length(abxlist)-1 do if abxlist[i].index<>-1 then begin
      Str(abxlist[i].index,s);
      tli := ListView1.Items.Add;
      tli.Caption := s;
      tli.SubItems.Clear;
      s2 := '';
      for j := 0 to length(abxlist[i].boxes)-1 do begin
        Str(abxlist[i].boxes[j].LoD,s);
        s2 := s2+s+' ';
      end;
      tli.SubItems.Add(s2);
      s2 := '( ';
      for j := 0 to 2 do
        s2 := s2+StrSingle(abxlist[i].boxes[0].p1[j])+' ';
      s2 := s2+') ( ';
      for j := 0 to 2 do
        s2 := s2+StrSingle(abxlist[i].boxes[0].p2[j])+' ';
      s2 := s2+')';
      tli.SubItems.add(s2);
    end
  end;

procedure TABXmanager.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  lit :TListItem;
  i,j,n,c :longint;
  s,s2 :string;
begin
  if ListView1.ItemIndex=-1 then
    ShowABX := false
  else begin
    Val(Item.Caption,n,c);
    ShowABX := true;
    ABXEntry := ABXList[n];
    Form2.draww;
    ABXWhichLOD.ListView1.Clear;
    lit := ABXWhichLOD.ListView1.Items.Add;
    lit.Caption := 'All';
    for i := 0 to length(ABXEntry.boxes)-1 do begin
      lit := ABXWhichLOD.ListView1.Items.Add;
      if i=0 then
        lit.Caption := 'Main'
      else begin
        Str(ABXEntry.boxes[i].LoD,s);
        lit.Caption := s
      end;
      lit.SubItems.Clear;
      s2 := '( ';
      for j := 0 to 2 do
        s2 := s2+StrSingle(ABXEntry.boxes[i].p1[j])+' ';
      s2 := s2+') ( ';
      for j := 0 to 2 do
        s2 := s2+StrSingle(ABXEntry.boxes[i].p2[j])+' ';
      s2 := s2+')';
      lit.SubItems.add(s2);
    end
  end
end;

end.
