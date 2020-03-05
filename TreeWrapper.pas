unit TreeWrapper;

interface
  uses
    TreeManager,ComCtrls,Forms,StdCtrls,Math;

type
  TTreeWrapper = class
    constructor Create(th_ :tTreeHandle; tv_ :TTreeView; sb_ :TScrollBox);
    procedure OnChange(Sender: TObject; Node: TTreeNode);
    procedure OnChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure HideEdit;
    procedure ShowEdit;
    procedure Reload;
    function isnodeselected :boolean;
    function selectednode :TTreeHandle;
    private
    th :TTreeHandle;
    sb :TScrollBox;
    tv :TTreeView;
    public
    property Tree :TTreehandle read th;
  end;

implementation

uses
  Unit6;

constructor TTreeWrapper.Create(th_ :tTreeHandle; tv_ :TTreeView; sb_ :TScrollBox);
    begin
      th := th_;
      tv := tv_;
      sb := sb_;
      Reload;
    end;

procedure TTreeWrapper.Reload;
  procedure RecurseTree(th2 :tTreeHandle; ti :TTreeNode);
    var
      ti2 :TTreeNode;
    begin
      ti2 := tv.Items.AddChild(ti,th2.getName);
      ti2.Data := th2.GetNodeHandle;
      th2.SearchInitNode;
      while th2.SearchNextNode do
        RecurseTree(th2,ti2);
    end;

  begin
    HideEdit;
    tv.Items.Clear;
    RecurseTree(th,nil);
    tv.OnChange := self.OnChange;
    tv.OnChanging := self.OnChanging;
  end;

function StrSingle(s :single):string;
  var
    st :string;
    s2 :single;
    n :longint;
  begin
    if (IsInfinite(1/s)) then begin
      if Sign(1/s)=1 then
        StrSingle := '0.0'
      else
        StrSingle := '-0.0';
      exit
    end;
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

procedure TTreeWrapper.OnChange(Sender: TObject; Node: TTreeNode);
  var
    i :integer;
    th2 :TTreeHandle;
    edit :TEdit;
    text :TStaticText;
  begin
    th2.SetNodeHandle(Node.Data);
    Form3.statusbar1.SimpleText := th2.getHelp;
    th2.SearchInitLeaf;
    i := 0;
    while th2.SearchNextLeaf do begin
      edit := TEdit.Create(sb);
      edit.Parent := sb;
      edit.tag := i;
      edit.Left := 80;
      edit.Top := i*20;
      edit.Width := sb.Width-100;
      edit.Height := 19;
      th2.BindEdit(edit);
(*      case th2.getType of
        tprByte: begin Str(th2.getByte,s); edit.Text := s end;
        tprInt32: begin Str(th2.getInt32,s); edit.Text := s end;
        tprSingle : edit.Text := StrSingle(th2.getSingle);
        tprPChar : edit.Text := th2.getPChar;
        tprString :edit.Text := th2.getString;
        tprBLString: edit.Text := th2.getBLString;
      end; *)
      text := TStaticText.Create(sb);
      text.Parent := sb;
      text.Tag := i;
      text.Left := 3;
      text.Top := i*20;
      text.Width := 75;
      text.Height := 19;
      if th2.GetHelp<>'' then
        text.Caption := th2.getName+' ('+th2.GetHelp+')'
      else
        text.Caption := th2.getName;
      inc(i)
    end;
  end;

procedure TTreeWrapper.OnChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
  var
    th2 :tTreeHandle;
  begin
    if (node<>nil) and (node.Data<>nil) then begin
      th2.SetNodeHandle(node.Data);
      th2.SearchInitLeaf;
      while th2.SearchNextLeaf do
        th2.UnbindEdit;
    end;
    while sb.ControlCount>0 do
      sb.RemoveControl(sb.Controls[0]);
  end;

procedure TTreeWrapper.HideEdit;
  var
    b :boolean;
  begin
    if (self=nil) or (tv=nil) then
      exit;
    b := true;
    if tv.Selected<>nil then
      self.OnChanging(nil,tv.Selected,b);
  end;

procedure TTreeWrapper.ShowEdit;
  begin
    if (self=nil) or (tv=nil) then
      exit;
    if tv.Selected<>nil then
      OnChange(nil,tv.Selected);
  end;


function TTreeWrapper.isnodeselected :boolean;
  begin
    isnodeselected := tv.Selected<>nil;
  end;

function TTreeWrapper.selectednode :TTreeHandle;
  var
    th :TTreeHandle;
  begin
    th.SetNodeHandle(tv.Selected.data);
    selectednode := th;
  end;


end.

