unit TrueValue;


interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Menus, StdCtrls, OpenGL, Grids, Unit2,
  TreeManager, Math;

(*

TrueValueListEditor allows direct editing of things stored somewhere in memory.

Instances of this class take a list editor and then provide methods for
manipulating it. The following things are possible:

-Data types: Byte, Longint, Single, fixed length string, variable length string
-Each data type can be a pointer to an area maintained by someone else
or this program can be advised to take care of it.


*)

const
  ByteValue = 1;
  LongintValue = 2;
  SingleValue = 3;
  FLStringValue = 4;
  VLStringValue = 5;


  type
  TVVariantRecord = record
    case integer of
      1:(b :byte);
      2:(l :longint);
      3:(s :single);
      4:(len :longint;p :pointer);
  end;

  TVVariant = object
    typ :byte;
    internal :boolean;
    content :TVVariantRecord;
  end;


  TTrueValueListEditor = class
    procedure AddCommon(n :integer);
    procedure AddByte(name :string; value :byte);
    procedure AddLongint(name :string; value :longint);
    procedure AddSingle(name :string; value :single);
    function FindItem(s :string):integer;
    procedure RedrawLine(n :integer);
    procedure ResizeLine(n :integer);
    procedure BindEditor(vle :TScrollBox);
    procedure UnbindEditor;
    procedure VLESetEditText(Sender: TObject; ACol, ARow: Integer; const Value: String);
    constructor Create;
    procedure Resize;
    procedure EditChange(Sender: TObject);
    procedure EditExit(Sender: TObject);
    procedure Clear;
    private
      Items :array of TVVariant;
      ItemNames :array of string;
      Editors :array of TEdit;
      Texts :array of TStaticText;
      Area :TScrollBox;
  end;

  function StrSingle(s :single):string;
  function StrInt32(i :integer):string;

implementation

constructor TTrueValueListEditor.Create;
  begin
    SetLength(Items,0);
    SetLength(ItemNames,0);
    SetLength(Editors,0);
    SetLength(Texts,0);
    Area := nil
  end;

procedure TTrueValueListEditor.EditChange(Sender: TObject);
  var
    l :longint;
    s :single;
    code :longint;
    failure :boolean;

  begin
    //item := pointer(TEdit(Sender).Tag);
    failure := false;

    case items[TEdit(Sender).Tag].typ of
      ByteValue:begin
        Val(TEdit(Sender).Text,l,code);
        failure := (code<>0) or (l<0) or (l>255);
        if not failure then
          items[TEdit(Sender).Tag].content.b := l;
      end;
      LongintValue:begin
        Val(TEdit(Sender).Text,l,code);
        failure := (code<>0);
        if not failure then
          items[TEdit(Sender).Tag].content.l := l;
      end;
      SingleValue:begin
        Val(TEdit(Sender).Text,s,code);
        failure := (code<>0) or IsInfinite(s) or IsNaN(s);
        if not failure then
          items[TEdit(Sender).Tag].content.s := s;
      end;
    end;
    if failure then
      TEdit(Sender).Color := 255
    else
      TEdit(Sender).Color := 16777215
  end;

procedure TTrueValueListEditor.EditExit(Sender: TObject);
  begin
    if TEdit(Sender).Color<>16777215 then begin
      RedrawLine(TEdit(Sender).Tag);
      TEdit(Sender).Color := 16777215
    end
  end;

procedure TTrueValueListEditor.Clear;
  var
    i :integer;
  begin
    for i := 0 to length(Editors)-1 do begin
      Editors[i].Parent := nil;
      Editors[i].Free;
    end;
    for i := 0 to length(Texts)-2 do begin
      Texts[i].Parent := nil;
      Texts[i].Free;
    end;
    SetLength(Items,0);
    SetLength(ItemNames,0);
    SetLength(Editors,0);
    SetLength(Texts,0);
  end;

procedure TTrueValueListEditor.BindEditor(vle :TScrollBox);
  begin
    Area := vle;
  end;

procedure TTrueValueListEditor.UnbindEditor;
  begin
  end;

procedure TTrueValueListEditor.ResizeLine(n :integer);
  begin
    Editors[n].Left := Area.Width div 2;
    Editors[n].Top := n*24;
    Editors[n].Width := (Area.Width+1) div 2;
    Editors[n].Height := 24;
    Texts[n].Left := 0;
    Texts[n].Top := n*24+4;
    Texts[n].Width := Area.Width div 2;
    Texts[n].Height := 24;
  end;

procedure TTrueValueListEditor.Resize;
  var
    n :integer;
  begin
    for n := 0 to length(Editors)-1 do
      ResizeLine(n);
  end;

function StrSingle(s :single):string;
  var
    st :string;
    s2 :single;
    n :longint;
  begin
    if IsInfinite(s) or IsNaN(s) or (abs(s)<0.001) or (abs(s)>=10000000) then begin
      Str(s:17,st);
      StrSingle := st;
      exit
    end;
    s2 := s;
    n := 0;
    while abs(s2)>10 do begin
      inc(n);
      s2 := s2/10
    end;
    while abs(s2)<1 do begin
      dec(n);
      s2 := s2*10
    end;
    if n>=0 then
      Str(s:9:8-n,st)
    else
      Str(s:9-n:9-n,st);
    StrSingle := st;
  end;

function StrInt32(i :integer):string;
  var
    st :string;
  begin
    Str(i,st);
    StrInt32 := st;
  end;

procedure TTrueValueListEditor.RedrawLine(n :integer);
  var
    st :string;
  begin
    case Items[n].typ of
      ByteValue : begin
        Str(Items[n].content.b,st);
      end;
      LongintValue : begin
        Str(Items[n].content.l,st);
      end;
      SingleValue : begin
        st := StrSingle(Items[n].content.s);
      end;
    end;
    Editors[n].Text := st;
  end;

procedure TTrueValueListEditor.AddCommon(n :integer);
  begin
    SetLength(Editors,n+1);
    Editors[n] := TEdit.Create(Area);
    Editors[n].Parent := Area;
    Editors[n].Tag := n;
    Editors[n].OnChange := EditChange;
    Editors[n].OnExit := EditExit;
    SetLength(Texts,n+1);
    Texts[n] := TStaticText.Create(Area);
    Texts[n].Caption := ItemNames[n];
    Texts[n].Parent := Area;
    ResizeLine(n);
    RedrawLine(n);
  end;

procedure TTrueValueListEditor.AddByte(name :string; value :byte);
  var
    n :integer;
  begin
    n := length(Items);
    SetLength(Items,n+1);
    Items[n].typ := ByteValue;
    Items[n].internal := true;
    Items[n].content.b := value;
    SetLength(ItemNames,n+1);
    ItemNames[n] := name;
    AddCommon(n);
  end;

procedure TTrueValueListEditor.AddLongint(name :string; value :longint);
  var
    n :integer;
  begin
    n := length(Items);
    SetLength(Items,n+1);
    Items[n].typ := LongintValue;
    Items[n].internal := true;
    Items[n].content.l := value;
    SetLength(ItemNames,n+1);
    ItemNames[n] := name;
    AddCommon(n);
  end;

procedure TTrueValueListEditor.AddSingle(name :string; value :single);
  var
    n :integer;
  begin
    n := length(Items);
    SetLength(Items,n+1);
    Items[n].typ := SingleValue;
    Items[n].internal := true;
    Items[n].content.s := value;
    SetLength(ItemNames,n+1);
    ItemNames[n] := name;
    AddCommon(n);
  end;

function TTrueValueListEditor.FindItem(s :string):integer;
  var
    i :integer;
  begin
    for i := 0 to length(Items)-1 do
      if ItemNames[i] = s then begin
        FindItem := i;
        exit
      end;
    FindItem := -1
  end;

procedure TTrueValueListEditor.VLESetEditText(Sender: TObject; ACol, ARow: Integer; const Value: String);
  var
    l :longint;
    s :single;
    code :integer;
  begin
    code := 1;
    case Items[ARow].typ of
      ByteValue:begin
        Val(value,l,code);
        if (l<0) or (l>255) or (code<>0) then
          code := 1
        else
          Items[ARow].content.b := l;
      end;
      LongintValue:begin
        Val(value,l,code);
        if (code<>0) then
          code := 1
        else
          Items[ARow].content.l := l;
      end;
      SingleValue:begin
        Val(value,s,code);
        if (code<>0) then
          code := 1
        else
          Items[ARow].content.s := s;
      end;
    end
  end;



end.
