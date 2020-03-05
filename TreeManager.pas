unit
  TreeManager;

(*

Das Prinzip dieses Programms:

Die Verwaltung eines Baumes.
Dieser Baum besteht aus Knoten und Blättern.
Jeder Knoten hat eine beliebige Anzahl Unterknoten und -Blätter.
Blätter haben keine Unterknoten und -Blätter.

Knoten haben einen Namen.
Blätter haben einen Namen sowie einen Wert (beliebigen Typs).

Der Baum besteht zum einen aus Knoten- und Blattinstanzen, die baumartig
organisiert sind.
Daneben gibt es Handler-Objekte, die die eigentliche Schnittstelle nach
außen darstellen. Sie erlauben keinen direkten Zugriff auf Knoten und Blätter.
Bereitgestellt werden gängige Operationen.

Unter DOS gibt es die TreeView-Unit, die sich der TreeHandle-Objekte bedient
und den Baum grafisch darstellt.

Unter Windows gibt es eine TreeWrapper-Unit, die einen TreeHandle-Baum in
einem TreeView darstellt.

Zur Sicherstellung der Syntax gibt es eine DTD-Schnittstelle. Generell führen
nur Überschreitungen der Limits zu Fehlern; Unterschreitungen nur dann, wenn
ChechValidity ausgeführt wird.


*)

interface

uses
  StdCtrls, SysUtils, dtd, Console;

const
  // beeinflussen das Verhalten des Editors
  ST_VISIBLE=1;   // sichtbar (momentan ist alles sichtbar!)
  ST_SUBNODES_SORT_NUM=2; // Sortieren der Unterknoten nach Ziffer (im Kontext)
  ST_SUBNODES_SORT_ALP=4; // Sortieren der Unterknoten nach Alphabet (im Kontext)
  ST_ALLOW_EDIT_NAME=8; // erlaubt das Ändern des Namens

type
  tPropertyType=(tprByte,tprInt32,tprString,tprSingle,tprVoid);
  tNode=class;
  tLeaf=class;
  tTreeHandle=object
    // creates a new base node
    procedure CreateNewBase(name :string; rule :tDTDNode);
    // deletes a leaf or a node including all subnodes and subleaves
    procedure Delete;
    // adds a node to this one
    function AddNode(name :string):tTreeHandle;
    // adds a data object to this node
    function AddByte(name :string;value:byte):tTreeHandle;
    function AddInt32(name :string;value:longint):tTreeHandle;
    //There are 2 kinds of strings: a free-length one and a maximum-length one
    function AddString(name :string;value:string):tTreeHandle;
    //String is a string with maximum length
    function AddStringL(name :string;value:string;maxlen:integer):tTreeHandle;
    function AddSingle(name :string;value:single):tTreeHandle;

    function AddVoid(name :string):tTreeHandle;
    //returns the number of leaves/nodes
    function Leaves:longint; overload;
    function Nodes:longint; overload;
    function Leaves(name :string):longint; overload;
    function Nodes(name :string):longint; overload;
    // Search functions; intialize with SearchInit;
    // the main search is a loop "while searchnextleaf do"
    // within this loop the treehandle points to the subnode/subleaf
    // after the loop the treehandle points to the node on which the search
    // was performed
    procedure SearchInitLeaf;
    function SearchNextLeaf:boolean;
    procedure SearchInitNode;
    function SearchNextNode:boolean;

    function getIndexNode(n :longint):tTreeHandle;
    function getIndexLeaf(n :longint):tTreeHandle;

    function isaNode:boolean;
    function isaLeaf:boolean;

    // methods for manipulating node/leaf properties
    function getName:string;
    procedure setName(s :string);
    function getState:longint;
    procedure setState(l :longint);
    function getType:tPropertyType;
    function getByte:byte;
    function getInt32:longint;
    function getString:string;
    function getSingle:single;
    procedure setByte(n:byte);
    procedure setInt32(n:longint);
    procedure setString(n:string);
    procedure setSingle(n:single);
    function getMaxLength:longint;
    // returns the parent node
    function parent:tTreeHandle;
    // removes the link to this node => this node becomes a new base node
//    procedure unlink;
    // includes a basenode as a new node
//    procedure link(th :tTreeHandle);

    function GetNodeHandle : pointer;
    function GetLeafHandle : pointer;
    procedure SetNodeHandle(p :pointer);
    procedure SetLeafHandle(p :pointer);

    function GetHelp:string;
    procedure SetHelp(s :string);

    function GetChildNode(name :string):tTreeHandle;
    function GetChildLeaf(name :string):tTreeHandle;
    function HasChildNode(name :string):boolean;
    function HasChildLeaf(name :string):boolean;

    procedure BindEdit(edit :TEdit);
    procedure UnbindEdit;

    procedure ScanInitNode;
    function ScanNode(name :string):boolean;
    procedure ScanInitLeaf;
    function ScanLeaf(name :string):boolean;
    function ScanDone:string;
    procedure ScanDoneNoHint;
    procedure Invalidate;

    function GetAddNode(name :string):tTreeHandle;

    private
    // contains common parts for all add methods
    function Add(name :string) :tLeaf;

    private

    // points to node or leaf
    NL :pointer;
    // false=>leaf true=>node
    isNode :boolean;
    // is set to true by SearchInit... and set to false by SearchNext...
    // is neccessary for correct search behaviour
    searchinit :boolean;
    mode :integer;
    auxp :pointer;
  end;
  tSaveStrucProc = procedure(var f :file; th :tTreeHandle);
  tLeaf=class
    name :string;
    prop :tPropertyType;
    pint :longint;
    pstr :string;
    state :longint;
    empty :boolean;
    parent :tNode;
    help :string;
    edit :TEdit;
    procedure OnChange(Sender :TObject);
  end;
  tNode=class
    name :string;
    leaf :array of array of tLeaf;
    node :array of array of tNode;
    state :longint;
    parent :tNode;
    help :string;
    rule :tDTDNode; // can be nil for no rule
    constructor Create(name2 :string; rule2 :tDTDNode);
  end;


var
  MoreItems :boolean;

procedure SaveStruc(var f :file;th :tTreeHandle; ssp :tSaveStrucProc);
procedure FatalError;

implementation

uses
  TrueValue;

type
  tRGB=array[0..2] of byte;

constructor tNode.Create(name2 :string; rule2 :tDTDNode);
  begin
    name := name2;
    rule := rule2;
    if rule=nil then begin
      SetLength(node,1);
      SetLength(leaf,1);
    end
    else begin
      SetLength(node,length(rule.subnode));
      SetLength(leaf,length(rule.subleaf));
    end;
  end;



function tTreeHandle.isaNode:boolean;
  begin
    isANode := isNode;
  end;

function tTreeHandle.isaLeaf:boolean;
  begin
    isALeaf := not isNode;
  end;

// erzeugt einen neuen Baum und läßt dieses Objekt auf dessen obersten Knoten
// zeigen (dieses Objekt NICHT wegwerfen!)
procedure tTreeHandle.CreateNewBase(name :string; rule :tDTDNode);
  var
    Node :tNode;
  begin
    Node := tNode.Create(name,rule);
    Node.state := ST_VISIBLE;
    Node.parent := nil; //(=> hat keinen Vorg„nger)
    NL := Node;
    isNode := true;
    searchinit := false;
    mode := 0;
  end;

// DER Übeltäter schlechthin!!! Nirgendwo gab es so viele Bugs auf einmal!
// entfernt einen Knoten samt Unterknoten; NICHT direkt aufrufen!
procedure Node_Clear(Node:tNode);
  var
    i,j :longint;
  begin
    for i := 0 to length(node.node)-1 do
      for j := 0 to length(node.node[i])-1 do
        Node_Clear(node.node[i][j]);
    for i := 0 to length(node.leaf)-1 do
      for j := 0 to length(node.leaf[i])-1 do
        node.leaf[i][j].Destroy;
    Node.Destroy;
  end;

// entsorgt einen Knoten/Blatt ordnungsgemäß; achtung: macht dieses Objekt
// unbrauchbar!!
procedure tTreeHandle.Delete;
  var
    i,j,k,l :longint;
    node :tNode;
  begin
    j := 0;
    if not isNode then begin
      node := tLeaf(NL).parent;
      for k := 0 to length(node.leaf)-1 do
        for i := 0 to length(node.leaf[k])-1 do
          if node.leaf[k][i]=NL then begin
            for l := i+1 to length(node.leaf[k])-1 do
              node.leaf[k,l-1] := node.leaf[k,l];
            SetLength(node.leaf[k],length(node.leaf[k])-1);
            tLeaf(NL).Destroy;
            exit
          end;
    end;
    node := tNode(NL).parent;
    if node<>nil then begin
      for k := 0 to length(node.node)-1 do
        for i := 0 to length(node.node[k])-1 do
          if node.node[k][i]=NL then begin
            for l := i+1 to length(node.node[k])-1 do
              node.node[k,l-1] := node.node[k,l];
            SetLength(node.node[k],length(node.node[k])-1);
            Node_Clear(tNode(NL));
            NL := nil;
            exit
          end;
    end
    else begin
      Node_Clear(tNode(NL));
      NL := nil;
    end;
  end;

// fügt einen Knoten am Ende der aktuellen Liste ein
function tTreeHandle.AddNode(name :string):tTreeHandle;
  var
    i,j :longint;
    node :tNode;
    node2 :tNode;
  begin
    if not isNode then
      exit;
    node := NL;
    if node.rule<>nil then begin
      // first error possibility: undefined sub node
      i := -1;
      for j := 0 to length(node.rule.Subnode)-1 do
        if name=node.rule.Subnode[j].name then
          i := j;
      if i=-1 then begin
        ConsoleFrame.WriteMessage('Error: unable to create child due to missing dtd entry: '+node.name+' -> '+name);
        exit;
      end;
      // second error possibility: more entries than allowed
      j := length(node.node[i]);
      if (j>0) and (node.rule.Subnode[i].typ in [dOnce,dOptional]) then begin
        ConsoleFrame.WriteMessage('Error: unable to create child due to limited entry capacity: '+node.name+' -> '+name);
        exit;
      end;
      node2 := TNode.Create(name,node.rule.subnode[i].node);
      SetLength(node.node[i],j+1);
      node.node[i][j] := node2;
    end
    else begin
      node2 := TNode.Create(name,nil);
      j := length(node.node[0]);
      SetLength(node.node[0],j+1);
      node.node[0][j] := node2;
    end;
    node2.state := ST_VISIBLE;
    node2.parent := NL;
    AddNode.NL := node2;
    AddNode.isNode := true;
    AddNode.searchinit := false;
    AddNode.mode := 0;
  end;

function tTreeHandle.GetAddNode(name :string):tTreeHandle;
  begin
    if haschildnode(name) then
      Result := getChildNode(name)
    else
      Result := addNode(name);
  end;

// does common tasks when adding a leaf
function tTreeHandle.Add(name :string):tLeaf;
  var
    i,j :longint;
    node :tNode;
  begin
    node := NL;
    if node.rule=nil then begin
      j := length(node.leaf[0]);
      SetLength(node.leaf[0],j+1);
      node.leaf[0,j] := TLeaf.Create;
      node.leaf[0,j].name := name;
      node.leaf[0,j].parent := node;
      Add := node.leaf[0,j]
    end
    else begin
      i := -1;
      for j := 0 to length(node.rule.subleaf)-1 do
        if name=node.rule.Subleaf[j].name then
          i := j;
      if i=-1 then begin
        ConsoleFrame.WriteMessage('Error: no matching leaf found: '+node.name+' -> '+name);
        Result := nil;
        exit
      end;
      j := length(node.leaf[i]);
      if (j>=1) and (node.rule.Subleaf[i].typ in [dOnce,dOptional]) then begin
        ConsoleFrame.WriteMessage('Error: too many leaves');
        Result := nil;
        exit
      end;
      SetLength(node.leaf[i],j+1);
      node.leaf[i,j] := TLeaf.Create;
      node.leaf[i,j].name := name;
      node.leaf[i,j].parent := node;
      Add := node.leaf[i,j]
    end
  end;

function tTreeHandle.AddByte(name :string;value:byte):tTreeHandle;
  var
    i :longint;
    node :tNode;
    leaf :tLeaf;
  begin
    node := NL;
    leaf := Add(name);
    leaf.prop := tprByte;
    leaf.pint := value;
    leaf.state := ST_VISIBLE;
    AddByte.NL := leaf;
    AddByte.isNode := false;
  end;

function tTreeHandle.AddVoid(name :string):tTreeHandle;
  var
    i :longint;
    node :tNode;
    leaf :tLeaf;
  begin
    node := NL;
    leaf := Add(name);
    leaf.prop := tprVoid;
    leaf.state := ST_VISIBLE;
    AddVoid.NL := leaf;
    AddVoid.isNode := false;
  end;

function tTreeHandle.AddInt32(name :string;value:longint):tTreeHandle;
  var
    i :longint;
    node :tNode;
    leaf :tLeaf;
  begin
    node := NL;
    leaf := Add(name);
    leaf.prop := tprInt32;
    leaf.pint:= value;
    leaf.state := ST_VISIBLE;
    AddInt32.NL := leaf;
    AddInt32.isNode := false;
  end;

function tTreeHandle.AddSingle(name :string;value:single):tTreeHandle;
  var
    i :longint;
    v :longint absolute value;
    node :tNode;
    leaf :tLeaf;
  begin
    node := NL;
    leaf := Add(name);
    leaf.prop := tprSingle;
    leaf.pint:= v;
    leaf.state := ST_VISIBLE;
    AddSingle.NL := leaf;
    AddSingle.isNode := false;
  end;

function tTreeHandle.AddString(name :string;value:string):tTreeHandle;
  var
    i :longint;
    node :tNode;
    leaf :tLeaf;
  begin
    node := NL;
    leaf := Add(name);
    leaf.prop := tprString;
    leaf.pint := -1;
    leaf.pstr := value;
    leaf.state := ST_VISIBLE;
    AddString.NL := leaf;
    AddString.isNode := false;
  end;

function tTreeHandle.AddStringL(name :string;value:string;maxlen:integer):tTreeHandle;
  var
    i :longint;
    node :tNode;
    leaf :tLeaf;
  begin
    node := NL;
    leaf := Add(name);
    leaf.prop := tprString;
    leaf.pint := maxlen;
    leaf.pstr := value;
    leaf.state := ST_VISIBLE;
    AddStringL.NL := leaf;
    AddStringL.isNode := false;
  end;

function tTreeHandle.Nodes:longint;
  var
    i :integer;
  begin
    if not isNode then
      FatalError;
    Result := 0;
    for i := 0 to length(TNode(NL).node)-1 do
      inc(Result,length(TNode(NL).node[i]));
  end;

function tTreeHandle.Leaves:longint;
  var
    i :integer;
  begin
    if not isNode then
      FatalError;
    Result := 0;
    for i := 0 to length(TNode(NL).leaf)-1 do
      inc(Result,length(TNode(NL).leaf[i]));
  end;

function tTreeHandle.Nodes(name :string):longint;
  var
    i :integer;
  begin
    if not isNode then
      FatalError;
    Result := -1;
    for i := 0 to length(TNode(NL).rule.Subnode)-1 do
      if name=TNode(NL).rule.Subnode[i].name then begin
        Result := length(TNode(NL).node[i]);
        exit
      end;
    ConsoleFrame.WriteMessage('Child node "'+name+'" does not exist');
  end;

function tTreeHandle.Leaves(name :string):integer;
  var
    i :integer;
  begin
    if not isNode then
      FatalError;
    Result := -1;
    for i := 0 to length(TNode(NL).rule.Subleaf)-1 do
      if name=TNode(NL).rule.Subleaf[i].name then begin
        Result := length(TNode(NL).leaf[i]);
        exit
      end;
    ConsoleFrame.WriteMessage('Child leaf "'+name+'" does not exist');
  end;


procedure tTreeHandle.SearchInitLeaf;
  begin
    searchinit := true;
    if not(isNode) then
      FatalError;
  end;

function tTreeHandle.SearchNextLeaf:boolean;
  var
    i,j :longint;
    node :TNode;
    grab :boolean;
  begin
    if SearchInit then begin
      grab := true;
      node := TNode(NL)
    end
    else begin
      grab := false;
      node := TLeaf(NL).parent;
    end;
    SearchInit := false;
    for i := 0 to length(node.leaf)-1 do
      for j := 0 to length(node.leaf[i])-1 do
        if grab then begin
          NL := node.leaf[i][j];
          isNode := false;
          SearchNextLeaf := true;
          exit
        end
        else if node.leaf[i][j]=TLeaf(NL) then
          grab := true;
    NL := node;
    isNode := true;
    SearchNextLeaf := false;
    if not grab then
      ConsoleFrame.WriteMessage('Error: SearchLeaf was unable to complete correctly');
  end;

procedure tTreeHandle.SearchInitNode;
  begin
    searchinit := true;
    if not(isNode) then
      FatalError;
  end;

function tTreeHandle.SearchNextNode:boolean;
  var
    i,j :longint;
    node :TNode;
    grab :boolean;
  begin
    if SearchInit then begin
      grab := true;
      node := TNode(NL)
    end
    else begin
      grab := false;
      node := TNode(NL).parent;
    end;
    SearchInit := false;
    for i := 0 to length(node.node)-1 do
      for j := 0 to length(node.node[i])-1 do
        if grab then begin
          NL := node.node[i][j];
          SearchNextNode := true;
          exit
        end
        else if node.node[i][j]=TNode(NL) then
          grab := true;
    NL := node;
    SearchNextNode := false;
    if not grab then
      ConsoleFrame.WriteMessage('Error: SearchNode was unable to complete correctly');
  end;


function tTreeHandle.getName:string;
  begin
    if isNode then
      getName := TNode(NL).name
    else
      getName := TLeaf(NL).name
  end;

procedure tTreeHandle.setName(s :string);
  begin
    if isNode then
      TNode(NL).name := s
    else
      TLeaf(NL).name := s
  end;

function tTreeHandle.getState:longint;
  begin
    if isNode then
      getState := TNode(NL).state
    else
      getState := TLeaf(NL).state
  end;

procedure tTreeHandle.setState(l :longint);
  begin
    if isNode then
      TNode(NL).state := l
    else
      TLeaf(NL).state := l
  end;

function tTreeHandle.getType:tPropertyType;
  begin
    if isNode then
      FatalError;
    getType := TLeaf(NL).prop;
  end;

//tprByte,tprInt32,tprPChar,tprString

function tTreeHandle.getByte:byte;
  begin
    if isNode or (TLeaf(NL).prop<>tprByte) then
      FatalError;
    getByte := TLeaf(NL).pint;
  end;

function tTreeHandle.getInt32:longint;
  begin
    if isNode or (TLeaf(NL).prop<>tprInt32) then
      FatalError;
    getInt32 := TLeaf(NL).pint;
  end;

function tTreeHandle.getSingle:single;
  var
    l :longint;
    s :single absolute l;
  begin
    if isNode or (TLeaf(NL).prop<>tprSingle) then
      FatalError;
    l := TLeaf(NL).pint;
    getSingle := s;
  end;

function tTreeHandle.getString:string;
  begin
    if isNode or (TLeaf(NL).prop<>tprString) then
      FatalError;
    getString := TLeaf(NL).pstr;
  end;

function tTreeHandle.getMaxLength:longint;
  begin
    if isNode or (TLeaf(NL).prop<>tprString) then
      FatalError;
    getMaxLength := TLeaf(NL).pint;
  end;

procedure tTreeHandle.setByte(n:byte);
  begin
    if isNode or (TLeaf(NL).prop<>tprByte) then
      FatalError;
    TLeaf(NL).pint := n;
  end;

procedure tTreeHandle.setInt32(n:longint);
  begin
    if isNode or (TLeaf(NL).prop<>tprInt32) then
      FatalError;
    TLeaf(NL).pint := n;
  end;

procedure tTreeHandle.setSingle(n:single);
  var
    l :longint absolute n;
  begin
    if isNode or (TLeaf(NL).prop<>tprSingle) then
      FatalError;
    TLeaf(NL).pint := l;
  end;

procedure tTreeHandle.setString(n:string);
  begin
    if isNode or (TLeaf(NL).prop<>tprString) or (TLeaf(NL).pint<>-1) and (length(n)>TLeaf(NL).pint) then
      FatalError;
    TLeaf(NL).pstr := n;
    TLeaf(NL).pint := length(n)+1;
  end;

function tTreeHandle.parent:tTreeHandle;
  begin
    parent.isNode := true;
    parent.searchinit := false;
    parent.mode := 0;
    if isNode then begin
      if TNode(NL).parent=nil then
        FatalError;
      parent.NL := TNode(NL).parent;
    end
    else begin
      if TLeaf(NL).parent=nil then
        FatalError;
      parent.NL := TLeaf(NL).parent;
    end
  end;

function tTreeHandle.getIndexNode(n :longint):tTreeHandle;
  begin
    if not isNode or (n<0) or (n>=nodes) then
      FatalError;
    getIndexNode.isNode := true;
    getIndexNode.NL := TNode(NL).node[n];
  end;

function tTreeHandle.getIndexLeaf(n :longint):tTreeHandle;
  begin
    if not isNode or (n<0) or (n>=leaves)  then
      FatalError;
    getIndexLeaf.isNode := false;
    getIndexLeaf.NL := TNode(NL).leaf[n];
  end;

{procedure tTreeHandle.unlink;
  var
    node :TNode;
    i,j :longint;
  begin
    if not isNode then
      FatalError;
    node := TNode(NL).parent;
    if node=nil then
      FatalError;
    j := 0;
    for i := 0 to length(node.node)-1 do
      if node.node[i]<>NL then begin
        node.node[j] := node.node[i];
        inc(j)
      end;
    SetLength(node.node,length(node.node)-1);
    TNode(NL).parent := nil;
  end;

procedure tTreeHandle.link(th :tTreeHandle);
  var
    j :longint;
    node :TNode;
    node2 :TNode;
  begin
    if not th.isNode or not isNode then
      FatalError;
    node2 := th.NL;
    if node2.parent<>nil then
      FatalError;
    node := NL;
    node2.parent := NL;
    j := length(node.node);
    SetLength(node.node,j+1);
    node.node[j] := node2
  end;}

procedure SaveStruc(var f :file;th :tTreeHandle; ssp :tSaveStrucProc);
  begin
    if not th.isNode then
      FatalError;
    ssp(f,th);
    th.SearchInitLeaf;
    while th.SearchNextLeaf do
      ssp(f,th);
    th.SearchInitNode;
    while th.SearchNextNode do
      SaveStruc(f,th,ssp);
  end;

function tTreeHandle.GetNodeHandle : pointer;
  begin
    if not isNode then
      FatalError;
    GetNodeHandle := NL;
  end;

function tTreeHandle.GetLeafHandle : pointer;
  begin
    if isNode then
      FatalError;
    GetLeafHandle := NL;
  end;

procedure tTreeHandle.SetNodeHandle(p :pointer);
  begin
    NL := p;
    isNode := true;
    searchinit := false;
    mode := 0;
  end;

procedure tTreeHandle.SetLeafHandle(p :pointer);
  begin
    NL := p;
    isNode := false;
    searchinit := false;
    mode := 0;
  end;

function tTreeHandle.GetHelp:string;
  begin
    if isNode then
      GetHelp := TNode(NL).help
    else
      GetHelp := TLeaf(NL).help
  end;

procedure tTreeHandle.SetHelp(s :string);
  begin
    if isNode then
      TNode(NL).help := s
    else
      TLeaf(NL).help := s
  end;

function tTreeHandle.GetChildLeaf(name :string):tTreeHandle;
  var
    th :TTreeHandle;
  begin
    th := self;
    th.SearchInitLeaf;
    while th.SearchNextLeaf do
      if th.getName=name then begin
        GetChildLeaf := th;
        exit
      end;
    raise Exception.Create('Child leaf "'+name+'" does not exist');
  end;

function tTreeHandle.GetChildNode(name :string):tTreeHandle;
  var
    th :TTreeHandle;
  begin
    th := self;
    th.SearchInitNode;
    while th.SearchNextNode do
      if th.getName=name then begin
        GetChildNode := th;
        exit
      end;
    raise Exception.Create('Child node "'+name+'" does not exist');
  end;

function tTreeHandle.HasChildNode(name :string):boolean;
  var
    th :TTreeHandle;
  begin
    th := self;
    th.SearchInitNode;
    while th.SearchNextNode do
      if th.getName=name then begin
        HasChildNode := true;
        exit
      end;
    HasChildNode := false;
  end;

function tTreeHandle.HasChildLeaf(name :string):boolean;
  var
    th :TTreeHandle;
  begin
    th := self;
    th.SearchInitLeaf;
    while th.SearchNextLeaf do
      if th.getName=name then begin
        HasChildLeaf := true;
        exit
      end;
    HasChildLeaf := false;
  end;

procedure tTreeHandle.BindEdit(edit :TEdit);
  var
    si :single;
    li :longint absolute si;
  begin
    if isNode then
      FatalError;
    if TLeaf(NL).edit<>nil then
      FatalError;
    TLeaf(NL).edit := edit;
    edit.Enabled := false;
    edit.OnChange := nil;
    case TLeaf(NL).prop of
      tprVoid:begin
        edit.Text := '';
        edit.Enabled := false;
        edit.OnChange := nil;
      end;
      tprByte:begin
        edit.Text := StrInt32(TLeaf(NL).pint);
        edit.Enabled := true;
        edit.OnChange := TLeaf(NL).OnChange;
      end;
      tprInt32:begin
        edit.Text := StrInt32(TLeaf(NL).pint);
        edit.Enabled := true;
        edit.OnChange := TLeaf(NL).OnChange;
      end;
      tprString:begin
        edit.Text := TLeaf(NL).pstr;
        edit.Enabled := true;
        edit.OnChange := TLeaf(NL).OnChange;
      end;
      tprSingle:begin
        li := TLeaf(NL).pint;
        edit.Text := StrSingle(si);
        edit.Enabled := true;
        edit.OnChange := TLeaf(NL).OnChange;
      end;
    end;
  end;

procedure tTreeHandle.UnbindEdit;
  begin
    if isNode then
      FatalError;
    if TLeaf(NL).edit=nil then
      exit;
    TLeaf(NL).edit.Enabled := false;
    TLeaf(NL).edit.OnChange := nil;
    TLeaf(NL).edit := nil;
  end;

procedure TLeaf.OnChange(Sender :TObject);
  var
    l :longint;
    c :longint;
    s :single absolute l;
    st :string;
  begin
    st := TEdit(Sender).Text;
    case prop of
      tprByte:begin
        Val(st,l,c);
        if (c=0) and (l>=0) and (l<256) then begin
          pint := l;
          TEdit(Sender).Color := $FFFFFF
        end
        else
          TEdit(Sender).Color := $FF8080
      end;
      tprInt32:begin
        Val(st,l,c);
        if (c=0) then begin
          pint := l;
          TEdit(Sender).Color := $FFFFFF
        end
        else
          TEdit(Sender).Color := $FF8080
      end;
      tprString:begin
        if (pint=-1) or (length(st)<=pint) then begin
          pstr := st;
          TEdit(Sender).Color := $FFFFFF
        end
        else
          TEdit(Sender).Color := $FF8080;
      end;
      tprSingle:begin
        Val(st,s,c);
        if (c=0) then begin
          pint := l;
          TEdit(Sender).Color := $FFFFFF
        end
        else
          TEdit(Sender).Color := $FF8080
      end;
    end
  end;

procedure FatalError;
  begin
    raise Exception.Create('A fatal error was cast.'#13'You may continue but note that TreeManager has'#13'become unstable so proceed on your own risk.'#13#13'Save your work and inform the author about this problem.');
  end;

procedure tTreeHandle.ScanInitNode;
  type
    tIntList= array[0..999] of integer;
  var
    bl :^tIntList;  // Zustand: -1 nicht beachtet, ansonsten erstes unbenutztes Objekt
    i :integer;
  begin
    if not isNode then
      FatalError;
    mode := 2;
    GetMem(bl,length(TNode(NL).node)*4);
    for i := 0 to length(TNode(NL).node)-1 do
      bl^[i] := -1;
    auxp := bl;
  end;

procedure tTreeHandle.ScanInitLeaf;
  type
    tIntList= array[0..999] of integer;
  var
    bl :^tIntList;
    i :integer;
  begin
    if not isNode then
      FatalError;
    mode := 4;
    GetMem(bl,length(TNode(NL).leaf)*4);
    for i := 0 to length(TNode(NL).leaf)-1 do
      bl^[i] := -1;
    auxp := bl;
  end;

function tTreeHandle.ScanNode(name :string):boolean;
  type
    tIntList= array[0..999] of integer;
  var
    bl :^tIntList;
    i :integer;
  begin
    if not isNode then
      FatalError;
    case mode of
      2:;
      3:begin
        NL := TNode(NL).parent;
        mode := 2;
      end
      else
        FatalError
    end;
    bl := auxp;
    for i := 0 to length(TNode(NL).node)-1 do if(TNode(NL).rule.Subnode[i].name=name) then begin
      if bl^[i]=-1 then
        bl^[i] := 0;
      if (bl^[i]<length(TNode(NL).node[i])) then begin
        mode := 3;
        NL := TNode(NL).node[i][bl^[i]];
        inc(bl^[i]);
        ScanNode := true;
      end
      else
        ScanNode := false;
      exit
    end;
    ScanNode := false;
  end;

function tTreeHandle.ScanLeaf(name :string):boolean;
  type
    tIntList= array[0..999] of integer;
  var
    bl :^tIntList;
    i :integer;
  begin
    case mode of
      4:if not self.isNode then
          FatalError;
      5:begin
        if self.isNode then
          FatalError;
        NL := TLeaf(NL).parent;
        self.isNode := true;
        mode := 4;
      end
      else
        FatalError
    end;
    bl := auxp;

    for i := 0 to length(TNode(NL).leaf)-1 do if(TNode(NL).rule.Subleaf[i].name=name) then begin
      if bl^[i]=-1 then
        bl^[i] := 0;
      if (bl^[i]<length(TNode(NL).leaf[i])) then begin
        mode := 5;
        NL := TNode(NL).leaf[i][bl^[i]];
        isNode := false;
        inc(bl^[i]);
        ScanLeaf := true;
      end
      else
        ScanLeaf := false;
      exit
    end;
    ScanLeaf := false;
  end;

function tTreeHandle.ScanDone:string;
  type
    tIntList= array[0..999] of integer;
  var
    bl :^tIntList;
    i :integer;
    s :string;

  begin
    case mode of
      2:;
      3:begin
        NL := TNode(NL).parent;
        mode := 2;
      end;
      4:;
      5:begin
        NL := TLeaf(NL).parent;
        isNode := true;
        mode := 4;
      end
      else
        FatalError
    end;
    bl := auxp;
    s := '';
    if mode=2 then begin
      for i := 0 to length(TNode(NL).node)-1 do
        if bl^[i]<>length(TNode(NL).node[i]) then
          if bl^[i]=-1 then
            s := 'Untouched: '+s+TNode(NL).rule.Subnode[i].name+#13#10
          else
            s := 'Unfinished: '+s+TNode(NL).rule.Subnode[i].name+#13#10;
      if s<>'' then
        s := 'ScanNode debug report'#13#10'The following nodes were not scanned:'#13#10+s;
      FreeMem(bl,length(TNode(NL).node)*4);
    end
    else if mode=4 then begin
      for i := 0 to length(TNode(NL).leaf)-1 do
        if bl^[i]<>length(TNode(NL).leaf[i]) then
          if bl^[i]=-1 then
            s := 'Untouched: '+s+TNode(NL).rule.Subleaf[i].name+#13#10
          else
            s := 'Unfinished: '+s+TNode(NL).rule.Subleaf[i].name+#13#10;
      if s<>'' then
        s := 'ScanLeaf debug report'#13#10#13#10'The following leaves were not scanned:'#13#10#13#10+s;
      FreeMem(bl,length(TNode(NL).leaf)*4);
    end;

    ScanDone := s;
    mode := 0;
    auxp := nil;
  end;

procedure tTreeHandle.ScanDoneNoHint;
  begin
    case mode of
      2:begin
        FreeMem(auxp,length(TNode(NL).node));
      end;
      3:begin
        NL := TNode(NL).parent;
        FreeMem(auxp,length(TNode(NL).node));
      end;
      4:begin
        FreeMem(auxp,length(TNode(NL).leaf));
      end;
      5:begin
        NL := TLeaf(NL).parent;
        isNode := true;
        FreeMem(auxp,length(TNode(NL).leaf));
      end
      else
        FatalError
    end;
    mode := 0;
    auxp := nil;
  end;

procedure tTreeHandle.Invalidate;
  begin
    NL := nil
  end;

begin
end.
