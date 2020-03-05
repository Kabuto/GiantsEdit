unit MapNamesDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TMapNamesDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    RadioGroup2: TRadioGroup;
    Edit3: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MapNamesDlg: TMapNamesDlg;

implementation

uses
  Unit1;

{$R *.dfm}

procedure TMapNamesDlg.Button1Click(Sender: TObject);
begin
  Application.MessageBox(
    'In-game map name:'
   +'This is the name that will show up in Giants'' map selection dialog'#13
   +'and in Gamespy.'#13
   +'In Game/Gamespy it will be preceded by WN, there''s no way around that'#13#13
   +'Message:'#13
   +'This is the text GMM shows when launching a map.'#13
   +'Place your credits here and don''t to forget to credit the ones'#13
   +'who made the maps on which your one is based (e.g. Planet Moon Studios)'#13#13
   +'Map type:'#13
   +'This is a number Giants uses to recognize the type of the map.'#13
   +'It''s a sum of the following numbers:'#13
   +' 1 => multiplayer map'#13
   +' 2 => no meccs allowed'#13
   +' 4 => no reaper allowed'#13
   +' 8 => no kabuto allowed'#13
   +'16 => no meccs vs meccs allowed'#13
   +'32 => no reaper vs reaper allowed'#13
   +'64 => no hosting, joining only (don''t use yourself, was used by PMS for blocking Lost World maps'#13
   +'Use on your own risk, better use one of the predefined possibilities :) '#13#13
   +'Map shareable:'#13
   +'When not checked this prevents other users from downloading the map.'#13
   +'Only users who have a copy of your map can join.'#13
   +'But keep in mind that anyone who got your map can check this :)'#13
   ,'');
end;

procedure TMapNamesDlg.FormShow(Sender: TObject);
var
  s :string;
  i :integer;
begin
  if AnsiUpperCase(copy(map.wbinname,1,11))='W_M_REAPER_' then
    Edit1.Text := copy(map.wbinname,12,length(map.wbinname)-15)
  else if AnsiUpperCase(copy(map.wbinname,1,9))='W_M_MECC_' then
    Edit1.Text := copy(map.wbinname,10,length(map.wbinname)-13)
  else if AnsiUpperCase(copy(map.wbinname,1,9))='W_M_3WAY_' then
    Edit1.Text := copy(map.wbinname,10,length(map.wbinname)-13)
  else if AnsiUpperCase(copy(map.wbinname,1,2))='W_' then
    Edit1.Text := copy(map.wbinname,3,length(map.wbinname)-6)
  else
    Edit1.Text := copy(map.wbinname,1,length(map.wbinname)-4);

  i := 1;
  s := '';
  while i<=length(map.usermessage) do begin
    if map.usermessage[i]='\' then begin
      if i<>length(map.usermessage) then begin
        case map.usermessage[i+1] of
          'n','N':s := s+#13#10;
          '\':s := s+'\'
        end;
        inc(i)
      end
    end
    else
      s := s+map.usermessage[i];
    inc(i)
  end;
  Memo1.Text := s;
  RadioGroup2Click(nil);
  Checkbox1.Checked := map.shareable;
  case map.maptype of
    0:RadioGroup2.ItemIndex := 0;
    $31:RadioGroup2.ItemIndex := 1;
    $D:RadioGroup2.ItemIndex := 2;
    $B:RadioGroup2.ItemIndex := 3;
    else begin
      RadioGroup2.ItemIndex := 4;
      Str(map.maptype,s);
      Edit3.Text := s
    end;
  end;
end;

procedure TMapNamesDlg.OKBtnClick(Sender: TObject);
var
  i :integer;
  s :string;
  maptype :integer;
  code :integer;
begin
  // get map type
  case RadioGroup2.ItemIndex of
    0:MapType := 0;
    1:MapType := $31;
    2:MapType := $0D;
    3:MapType := $0B;
    4:begin
      Val(Edit3.Text,maptype,code);
      if (code<>0) then begin
        Application.MessageBox('The custom map type is invalid!','Invalid data');
        exit
      end;
    end
    else begin
      Application.MessageBox('???','Error');
      exit
    end
  end;

  // check text for validity
  s := Edit1.Text;
  if s='' then begin
    Application.MessageBox('You must enter something for map name!','Error');
    exit
  end;
  for i := 1 to length(s) do
    if not (s[i] in [' ','!','#','$','%','&','''','(',')','+',',','-','.',
    '0'..'9',';','=','@','A'..'Z','[',']','^','_','`','a'..'z','{','}','~',
    #128..#254]) then begin
    Application.MessageBox('Invalid character in map name','Error');
    exit
  end;
  case RadioGroup2.ItemIndex of
    0,4:map.wbinname := 'w_'+s+'.bin';
    1:map.wbinname := 'w_M_3Way_'+s+'.bin';
    2:map.wbinname := 'w_M_Mecc_'+s+'.bin';
    3:map.wbinname := 'w_M_Reaper_'+s+'.bin'
  end;

  i := 1;
  s := memo1.Text;
  map.usermessage := '';
  while i<=length(s) do begin
    if s[i]=#13 then begin
      if (i<length(s)) and (s[i+1]=#10) then
        inc(i);
      map.usermessage := map.usermessage+'\n'
    end
    else if s[i]='\' then
      map.usermessage := map.usermessage+'\\'
    else
      map.usermessage := map.usermessage+s[i];
    inc(i)
  end;

  map.maptype := maptype;

  map.shareable := CheckBox1.Checked;

  ModalResult := mrOk;
end;

procedure TMapNamesDlg.RadioGroup2Click(Sender: TObject);
var
  s :string;
  i :integer;
  code :integer;
begin
  Edit3.Enabled := (RadioGroup2.ItemIndex=4);
  case RadioGroup2.ItemIndex of
    0:Edit3.Text := '0';
    1:Edit3.Text := '49';
    2:Edit3.Text := '13';
    3:Edit3.Text := '11';
  end;
  Val(Edit3.Text,i,code);
  if code<>0 then begin
    i := 0;
    Edit3.Text := ''
  end;
  s := '';
  if (i and 1)<>0 then
    s := s+'Multiplayer'#13
  else
    s := s+'Singleplayer'#13;
  case (i and 18) of
    0:s := s+'2 Mecc bases'#13;
    2:s := s+'0 Mecc bases'#13;
    16:s := s+'1 Mecc base'#13;
    18:s := s+'? Mecc bases'#13;
  end;
  case (i and 36) of
    0:s := s+'2 Reaper bases'#13;
    4:s := s+'0 Reaper bases'#13;
    32:s := s+'1 Reaper base'#13;
    36:s := s+'? Reaper bases'#13;
  end;
  if (i and 8)<>0 then
    s := s+'0 Kabutos'#13
  else
    s := s+'1 Kabuto'#13;
  if (i and 64)<>0 then
    s := s+'No hosting allowed'
  else
    s := s+'Hosting allowed';
  StaticText1.Caption := s;
  Edit1Change(nil);
end;

procedure TMapNamesDlg.Edit3Change(Sender: TObject);
begin
  RadioGroup2Click(nil);
end;

procedure TMapNamesDlg.Edit1Change(Sender: TObject);
begin
  case RadioGroup2.ItemIndex of
    0,4:Edit2.Text := 'w_'+Edit1.Text+'.bin';
    1:Edit2.Text := 'w_M_3Way_'+Edit1.Text+'.bin';
    2:Edit2.Text := 'w_M_Mecc_'+Edit1.Text+'.bin';
    3:Edit2.Text := 'w_M_Reaper_'+Edit1.Text+'.bin';
  end;
end;

end.
