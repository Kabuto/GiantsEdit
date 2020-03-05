unit bin_w_read;

interface

uses
  TreeManager, SysUtils, Console, DTD;

type
  tByteList=array of byte;


const
  Hex:array[0..15] of char='0123456789ABCDEF';

var
  rMapData :tDTDNode;
  rMissionData :tDTDNode;

function LoadBinW(data :tByteList) :boolean;
function SaveBinW:tByteList;
//procedure LoadBldWO(name :string;th :tTreeHandle);
function LoadBinWM(data :tByteList) :boolean;

implementation

uses
  Unit1;

type
  tRGB=array[0..2] of byte;

var
  data :tByteList;
  dataptr :integer;
//  ttable :text;
  w_bstart,w_bend,w_end :boolean;
  fentry,fsubtail,lobject,lobase :tTreeHandle;

function Objectname(n :longint):string;
  var
    s :string;
  begin
    case n of
      1024:Objectname := 'pub (inside)';
      834:Objectname := 'smartie dropoff';
      951:Objectname := 'blue flag';
      952:Objectname := 'green flag';
      953:Objectname := 'red flag';
      954:Objectname := 'yellow flag';
      1028:Objectname := 'high concrete tower';
      1041:Objectname := 'medium concrete tower';
      127:Objectname := 'great britain flag';
      60:Objectname := 'mobile turret';
      1002:Objectname := 'medium smartie house';
      1003:Objectname := 'medium smartie house';
      1073:Objectname := 'stone';
      1075:Objectname := 'stone';
      1078:Objectname := 'bin';
      1082:Objectname := 'samurai hut';
      1083:Objectname := 'samurai gong';
      1084:Objectname := 'samurai gate';
      1200:Objectname := 'knife';
      1335:Objectname := 'tall smartie house';
      1336:Objectname := 'tall smartie house';
      1348:Objectname := 'smartie hideout';
      1354:Objectname := 'smartie table';
      234:Objectname := 'fork';
      235:Objectname := 'knife';
      506:Objectname := 'small smartie ship';
      507:Objectname := 'smartie car';
      508:Objectname := 'smartie bin';
      509:Objectname := 'stone';
      510:Objectname := 'broken stone';
      511:Objectname := 'smartie window';
      512:Objectname := 'smartie fence';
      513:Objectname := 'smartie baumstumpf';
      514:Objectname := 'smartie table';
      515:Objectname := 'smartie hideout';
      516:Objectname := 'smartie brunnen';
      517:Objectname := 'smartie window';
      518:Objectname := 'smartie _';
      519:Objectname := 'smartie ladder';
      520:Objectname := 'smartie fence';
      521:Objectname := 'high smartie baumstumpf';
      522:Objectname := 'smartie spawn tunnel';
      523:Objectname := 'stone with holes';
      524:Objectname := 'big stone with holes';
      525:Objectname := 'spherical stone';
      527:Objectname := 'small spherical stone';
      528:Objectname := 'dark spherical stone';
      102:Objectname := 'tree';
      679:Objectname := 'marker';
      985:Objectname := 'reaper base';
      981:Objectname := 'mecc base';
      1334:Objectname := 'eat here';
      else begin
        Str(n,s);
        Objectname := 'Obj'+s;
      end
    end;
  end;

procedure Hint(s :string);
  begin
//    {$I-}Write(t,s);if IOResult<>0 then;{$I+}
    fentry := fbase.addNode(s);
  end;

procedure Group(s,s2 :string); overload;
  var
    th :tTreeHandle;
    fl :boolean;
  begin
    th := fBase;
    th.SearchInitNode;
    fl := false;
    while th.SearchNextNode do
      if th.getName=s then begin
        fl := true;
        break
      end;
    if fl then
      fEntry := th.addNode(s2)
    else
      fEntry := th.addNode(s).addNode(s2);
  end;

procedure Help(s :string);
  begin
    fEntry.SetHelp(s);
  end;

procedure Group(s :string); overload;
  var
    th :tTreeHandle;
    fl :boolean;
  begin
    th := fBase;
    th.SearchInitNode;
    fl := false;
    while th.SearchNextNode do
      if th.getName=s then begin
        fl := true;
        break
      end;
    if fl then
      fEntry := th
    else
      fEntry := th.addNode(s);
  end;

procedure ReadVoid(s :string);
  begin
    fentry.addVoid(s);
  end;

function ReadByte(s :string):byte; overload;
  var
    b :byte;
  begin
    b := data[dataptr];
    inc(dataptr);
//    Write(t,b,' ');
    fentry.addByte(s,b);
    ReadByte := b;
  end;

function ReadInt32(s :string):longint; overload;
  var
    l :longint;
  begin
    Move(data[dataptr],l,4);
    inc(dataptr,4);
//    Write(t,l,' ');
    fentry.addInt32(s,l);
    ReadInt32 := l;
  end;

function ReadSingle(name :string):single; overload;
  var
    s :single;
  begin
    Move(data[dataptr],s,4);
    inc(dataptr,4);
    fentry.addSingle(name,s);
    ReadSingle := s;
  end;

function ReadString16(name :string):string; overload;
  var
    s :string;
  begin
    SetLength(s,16);
    Move(data[dataptr],s[1],16);
    inc(dataptr,16);
    while (s<>'') and (s[length(s)]=#0) do
      s := copy(s,1,length(s)-1);
    fentry.addStringl(name,s,16);
    ReadString16 := s;
  end;

function ReadString32(name :string):string; overload;
  var
    s :string;
  begin
    SetLength(s,32);
    Move(data[dataptr],s[1],32);
    inc(dataptr,32);
    while (s<>'') and (s[length(s)]=#0) do
      s := copy(s,1,length(s)-1);
    fentry.addStringl(name,s,32);
    ReadString32 := s;
  end;

function ReadString64(name :string):string; overload;
  var
    s :string;
  begin
    SetLength(s,64);
    Move(data[dataptr],s[1],64);
    inc(dataptr,64);
    while (s<>'') and (s[length(s)]=#0) do
      s := copy(s,1,length(s)-1);
    fentry.addStringl(name,s,64);
    ReadString64 := s;
  end;

function ReadPChar(name :string):string; overload;
  var
    s :string;
    c :char;
  begin
    s := '';
    repeat
      c := char(data[dataptr]);
      inc(dataptr);
      if c=#0 then begin
        fentry.addString(name,s);
        ReadPChar := s;
        exit
      end;
      s := s+c;
    until false;
  end;

function ReadBLString(name :string):string; overload;
  var
    s :string;
    c :char;
//    b :byte;
  begin
    s := '';
//    b := data[dataptr];
    inc(dataptr);
    repeat
      c := char(data[dataptr]);
      inc(dataptr);
      if c=#0 then begin
        fentry.addString(name,s);
        ReadBLString := s;
        exit;
      end;
      s := s+c;
    until false;
  end;

function ReadRGB:tRGB;
  var
    rgb :tRGB;
  begin
    rgb[0] := ReadByte('Red');
    rgb[1] := ReadByte('Green');
    rgb[2] := ReadByte('Blue');
    ReadRGB := rgb;
  end;

procedure SpecialMarkerName(fEntry :tTreeHandle;j :longint);
  begin
    case j of
      1:fEntry.setName('Object marker Meccspawn');
      2:fEntry.setName('Object marker Meccspawn (2nd base)');
      3:fEntry.setName('Object marker Reaperspawn');
      4:fEntry.setName('Object marker Reaperspawn (2nd base)');
      27:fEntry.setName('Object marker Kabutospawn');
      22:fEntry.setName('Object marker Vimpherd1');
      23:fEntry.setName('Object marker Vimpherd2');
    end
  end;

procedure ReadChunk(chunktype:byte);
  var
    i,j,n :longint;
    b :byte;
    th :tTreeHandle;
    fl :boolean;
    s :string;
  begin
    case ChunkType of
{      $17:begin
        fEntry := lobject.addNode('Scale');
//        Hint('  Scale ');
        ReadSingle;
      end;}
      $17:begin
        fEntry := lobject;
        ReadSingle('Scale');
      end;
      $1D:begin
        Group('<Textures>');
        ReadString16('OutDomeTex');
      end;
      $1E:begin
        Group('<Textures>');
        Help('the sky, sea and sea ground as well as terrain textures');
        ReadString16('DomeTex');
      end;
      $1F:begin
        Group('<Textures>');
        ReadString16('DomeEdgeTex');
      end;
      $20:begin
        Group('<Textures>');
        ReadString16('WFall1Tex');
      end;
      $21:begin
        Group('<Textures>');
        ReadString16('WFall2Tex');
      end;
      $22:begin
        Group('<Textures>');
        ReadString16('WFall3Tex');
      end;
      $23:begin
        Group('<Textures>');
        ReadString16('SpaceLineTex');
      end;
      $24:begin
        Group('<Textures>');
        ReadString16('SpaceTex');
      end;
      $25:begin
        Group('<Textures>');
        ReadString16('SeaTex');
      end;
      $26:begin
        Group('<Textures>');
        ReadString16('GlowTex');
      end;
      $27:begin
        Group('<Teleport>','Teleport');

        Help('was used for cheating during development but is useless nowadays');

//        Hint(';Teleport ');
//        fEntry.setName('Teleport');
        ReadByte('Index');
        ReadSingle('X');
        ReadSingle('Y');
        ReadSingle('Z');
        ReadSingle('Angle');
      end;
      $28:begin
        Group('<Sun>','SunColor');
        ReadRGB;
      end;
      $29:begin
        if fBase.HasChildNode('Fog') then
          fBase.GetChildNode('Fog').Delete;
        Hint('Fog');
        Help('the amount and color of fog applied to terrain');
        ReadSingle('Near distance');
        ReadSingle('Far distance');
        ReadRGB;
      end;
      $2A:begin
//        if w_bstart then
          Group('<Objects>','Object')
{        else
          Group('<PreObjects>','Object')};

//        Hint('Object Obj');
        j := ReadInt32('Type');
//        fEntry.SetName('Object '+Objectname(j));
        ReadSingle('X');
        ReadSingle('Y');
        ReadSingle('Z');
        ReadSingle('Angle');
        lobject := fEntry;
      end;
      $2B:begin
        Hint(';?AnimTime');
      end;
      $2C:begin
        Hint('Music');
        ReadString32('Music');
      end;
      $2D:begin
        Hint('Path');
      end;
      $2E:begin
        Hint('SeaSpeed');
        ReadSingle('p0');
        ReadSingle('p1');
        ReadSingle('p2');
      end;
      $2F:begin
        Hint('EffectRef');
      end;
      $30:begin
        Group('<StartLoc>','StartLoc');
//        fEntry.setName('StartLoc');
        ReadByte('Index');
        ReadByte('Unknown');
        ReadSingle('X');
        ReadSingle('Y');
        ReadSingle('Z');
        ReadSingle('Angle');
      end;
      $34:begin
        Group('<Textures>','GroundTexture');
        ReadString32('Name');
        ReadSingle('Stretch');
        ReadSingle('Offset X');
        ReadSingle('Offset Y');
      end;
      $35:begin
        Group('<Textures>','SlopeTexture');
        ReadString32('Name');
        ReadSingle('Stretch');
        ReadSingle('Offset X');
        ReadSingle('Offset Y');
      end;
      $36:begin
        Group('<Textures>','WallTexture');
        ReadString32('Name');
        ReadSingle('Stretch');
        ReadSingle('Offset X');
        ReadSingle('Offset Y');
      end;
      $39:begin
        Hint('Tiling');
        ReadSingle('p0');
        ReadSingle('p1');
        ReadSingle('p2');
        ReadSingle('p3');
        ReadSingle('p4');
        ReadSingle('p5');
        ReadSingle('p6');
      end;
{      $3B:begin
        fEntry := lobject.addNode('AIMode');
 //       Hint('  AIMode ');
        ReadByte;
      end;}
      $3B:begin
        fEntry := lobject;
        j := ReadByte('AIMode');
        if fEntry.getName='Object marker' then
          SpecialMarkerName(fEntry,j);
      end;
      $44:begin {
        Hint('ObjEditStart');}
        w_bstart := true;
      end;
      $45:begin
{        Hint('ObjEditEnd');}
        w_bend := true;
      end;
      $46:begin
//        if w_bstart then
          Group('<Objects>','Object')
{       else
          Group('<PreObjects>','Object')};

//        Hint('Object Obj');
        j := ReadInt32('Type');
//        fEntry.SetName('Object '+Objectname(j));
        ReadSingle('X');
        ReadSingle('Y');
        ReadSingle('Z');
        ReadSingle('Angle X');
        ReadSingle('Angle Y');
        ReadSingle('Angle Z');
        lObject := fEntry;
      end;
      $49:begin
        Hint('Scenario');
        ReadSingle('p0');
      end;
      $4A:begin
        Hint('WorldNoLightning');
      end;
      $4C:begin
        lobject := lobject.addNode('Lock');
        fentry := lobject;
        ReadInt32('Type');
        ReadByte('Lock 1');
        ReadByte('Lock 2');
      end;
      $4D:begin
        lobject := lobject.parent;
      end;
      $4F:begin
        th := fBase;
        th.SearchInitNode;
        fl := false;
        while th.SearchNextNode do
          if th.getName='<Flicks>' then begin
            fl := true;
            break
          end;
        if fl then
          fEntry := th
        else
          fEntry := th.addNode('<Flicks>');

    //    Hint(';Flick ');
        ReadString64('Name');
      end;
{      $52:begin
        fEntry := lobject.addNode('TeamID');
//        Hint('  TeamID ');
        ReadInt32;
      end;}
      $52:begin
        fEntry := lobject;
        ReadInt32('TeamID');
      end;
      $58:begin
        if fBase.HasChildNode('WaterFog') then
          fBase.GetChildNode('WaterFog').Delete;
        Hint('WaterFog');
        ReadSingle('Near distance');
        ReadSingle('Far distance');
        ReadRGB;
      end;
      $59:begin
        Hint('StartWeather');
        ReadPChar('Name');
      end;
      $5A:begin
        fEntry := lobject;
        ReadSingle('OData 0');
        ReadSingle('OData 1');
        ReadSingle('OData 2');

(*        fEntry := lobject.addNode('OData');
        for i := 0 to 2 do
          ReadSingle;*)
      end;
      $5B:begin
        fEntry := lobject{.addNode('HerdMarkers')};
//      Hint('  HerdMarkers ');
        ReadInt32('HerdMarker 0');
        ReadInt32('HerdMarker 1');
        ReadInt32('HerdMarker 2');
        ReadInt32('HerdMarker 3');
        ReadInt32('HerdMarker 4');
      end;
      $5C:begin
        Group('<Scenerios>','scenerio');

//        Hint('Scenerio ');
        j := ReadByte('Type');
{        case j of
          2:fEntry.setName('mission');
          3:fEntry.setName('new level');
          else fEntry.setName('?unknown?');
        end;}
        ReadInt32('Index');
        ReadString32('Name');
      end;

      $5D:begin
        th := fBase;
        th.SearchInitNode;
        fl := false;
        while th.SearchNextNode do
          if th.getName='<Missions>' then begin
            fl := true;
            break
          end;
        if fl then
          fEntry := th
        else
          fEntry := th.addNode('<Missions>');


//      Hint('Mission ');

        ReadString32('Name');
      end;
      $5F:begin
        fEntry := lobject;
        ReadSingle('LightColor 0');
        ReadSingle('LightColor 1');
        ReadSingle('LightColor 2');


(*        fEntry := lobject.addNode('LightColor');
        for i := 0 to 2 do
          ReadSingle; *)
      end;
      $60:begin
        Hint('DisableScenerios');
        ReadInt32('Value');
      end;
      $65:begin
        Hint('LandTexFade');
        ReadSingle('p0');
        ReadSingle('p1');
        ReadSingle('p2');
      end;
      $66:begin
        Hint('LandAngles');
        ReadSingle('Angle 0');
        ReadSingle('Angle 1');
      end;
      $67:begin
//        Hint('  MinishopRIcons ');
        fEntry := lobject{.addNode('MinishopRIcons')};
        Move(data[dataptr],n,4);
        inc(dataptr,4);
        for i := 0 to n-1 do
          ReadInt32('MinishopRIcon');
      end;
      $68:begin
//        Hint('  MinishopMIcons ');
        fEntry := lobject{.addNode('MinishopMIcons')};
        Move(data[dataptr],n,4);
        inc(dataptr,4);
        for i := 0 to n-1 do
          ReadInt32('MinishopMIcon');
      end;
      $6B:begin
        fEntry := lobject{.addNode('SplineKeyTime')};
//        Hint('  SplineKeyTime ');
        ReadInt32('SplineKeyTime');
      end;
      $6C:begin
        Hint('MusicSuspense');
        ReadString32('p0');
        ReadString32('p1');
      end;
      $6D:begin
        Hint('MusicLight');
        ReadString32('p0');
        ReadString32('p1');
      end;
      $6E:begin
        Hint('MusicWin');
        ReadString32('p0');
        ReadString32('p1');
      end;
      $6F:begin
        Hint('MusicHeavy');
        ReadString32('p0');
        ReadString32('p1');
      end;
      $72:begin
        Group('<Textures>','GroundBumpTexture');
        ReadString32('Name');
        ReadSingle('Stretch');
        ReadSingle('Offset X');
        ReadSingle('Offset Y');
      end;
      $73:begin
        Group('<Textures>','SlopeBumpTexture');
        ReadString32('Name');
        ReadSingle('Stretch');
        ReadSingle('Offset X');
        ReadSingle('Offset Y');
      end;
      $74:begin
        Group('<Textures>','WallBumpTexture');
        ReadString32('Name');
        ReadSingle('Stretch');
        ReadSingle('Offset X');
        ReadSingle('Offset Y');
      end;
      $75:begin
        Hint('bumpclampvalue');
        ReadSingle('Value');
      end;
      $76:begin
        Group('<Sun>','Sunfxname');
        ReadPChar('Name');
        ReadSingle('p0');
        ReadSingle('p1');
        ReadSingle('p2');
        ReadSingle('p3');
        ReadSingle('p4');
      end;
      $77:begin
        Group('<Sun>','Sunflare1');
        ReadInt32('unknown');
        ReadSingle('p0');
        ReadSingle('p1');
        ReadSingle('p2');
        ReadSingle('p3');
        ReadSingle('p4');
        ReadSingle('p5');
        ReadSingle('p6');
        ReadSingle('p7');
        ReadSingle('p8');
        ReadSingle('p9');
        ReadSingle('p10');
      end;
      $78:begin
        Group('<Sun>','Sunflare2');
        ReadInt32('unknown');
        ReadSingle('p0');
        ReadSingle('p1');
        ReadSingle('p2');
        ReadSingle('p3');
        ReadSingle('p4');
        ReadSingle('p5');
        ReadSingle('p6');
        ReadSingle('p7');
        ReadSingle('p8');
        ReadSingle('p9');
        ReadSingle('p10');
      end;
      $79:begin
        Hint('WaterColor');
        ReadSingle('p0');
        ReadSingle('p1');
        ReadSingle('p2');
        ReadSingle('p3');
        ReadSingle('p4');
        ReadSingle('p5');
        ReadSingle('p6');
        ReadSingle('p7');
        ReadSingle('p8');
        ReadSingle('p9');
        ReadSingle('p10');
        ReadSingle('p11');
        ReadSingle('p12');
        ReadSingle('p13');
        ReadSingle('p14');
        ReadSingle('p15');
        ReadSingle('p16');
        ReadSingle('p17');
        ReadSingle('p18');
        ReadSingle('p19');
        ReadSingle('p20');
        ReadSingle('p21');
        ReadSingle('p22');
      end;
      $82:begin
        Hint('ArmyBin');
        ReadString32('Name');
      end;
      $84:begin
        Hint('VoPath');
        ReadPChar('Name');
      end
      else begin
        Str(data[dataptr-1],s);
        s := 'Unknown chunk id found ($'
        +Hex[chunktype div 16]
        +Hex[chunktype and 15]
        +') at FilePos '+s+#13#10'HexData after incident (up to 256 bytes):';
        i := 0;
        while (i<256) and (dataptr<length(data)) do begin
          b := data[dataptr];
          inc(dataptr);
          s := s+Hex[b div 16]+Hex[b and 15]+' ';
          if dataptr and 15=0 then
            s := s+#13#10;
          inc(i);
        end;
        raise Exception.Create(s);
      end
    end;
  end;

(*
procedure LoadBldWO(name :string;th :tTreeHandle);
  var
    f :text;
    s,zeile,s2 :string;
    i,n :longint;
    fileend :tTreeHandle;
    delall :boolean;

  function GetString:string;
    begin
      Getstring := '';
      while (zeile<>'') and (zeile[1]<>' ') do begin
        Getstring := Getstring+zeile[1];
        zeile := copy(zeile,2,length(zeile)-1)
      end;
      if zeile<>'' then
        zeile := copy(zeile,2,length(zeile)-1)
    end;

  function GetInt32:longint;
    var
      s :string;
      w :longint;
      i :longint;
    begin
      s := GetString;
      Val(s,i,w);
      GetInt32 := i;
      if w<>0 then
        halt(1);
    end;

  function GetSingle:single;
    var
      s :string;
      w :longint;
      si :single;
    begin
      s := GetString;
      Val(s,si,w);
      GetSingle := si;
      if w<>0 then
        halt(1);
    end;

  begin
    fEntry := fbase;
    fEntry.SearchInitNode;
    delall := false;
    i := 0;
    while i<fBase.nodes do begin
      s := fBase.getIndexNode(i).getName;
      if s='FileEnd' then
        fileEnd := fBase.getIndexNode(i);
      if s='ObjEditStart' then
        delall := true;
      if delall or (s='Done') then
        fBase.getIndexNode(i).delete
      else
        inc(i);
      if s='ObjEditEnd' then
        delall := false;
    end; // produziert Abstrze, genaue Ursache noch unbekannt
    fileEnd.unlink;

    Assign(f,name);
    Reset(f);
    while not eof(f) do begin
      Readln(f,s);
      // 1. Zeile von "Unrat" befreien (d.s. berflssige Leerzeichen)
      // und gleichzeitig W”rter z„hlen
      while (s<>'') and (s[1]<=#32) do
        s := copy(s,2,length(s)-1);
      if (s='') or (s[1]=';') then
        continue;
      s2 := '';
      n := 1;
      for i := 1 to length(s) do
        if s[i]>#32 then
          s2 := s2+s[i]
        else
          if (s[i-1]>#32) then begin
            s2 := s2+' ';
            inc(n)
          end;
      zeile := s2;
      // Writeln(n,':',s);
      // 2. Zeile interpretieren

      s := Getstring;
      if s='ObjEditStart' then begin
        Hint('ObjEditStart');
      end
      else if s='ObjEditEnd' then begin
        Hint('ObjEditEnd');
      end
      else if s='Fog' then begin
        Hint('Fog');
        fEntry.addSingle('single',GetSingle);
        fEntry.addSingle('single',GetSingle);
        fEntry.addByte('Byte',GetInt32);
        fEntry.addByte('Byte',GetInt32);
        fEntry.addByte('Byte',GetInt32);
      end
      else if s='WaterFog' then begin
        Hint('WaterFog');
        fEntry.addSingle('single',GetSingle);
        fEntry.addSingle('single',GetSingle);
        fEntry.addByte('Byte',GetInt32);
        fEntry.addByte('Byte',GetInt32);
        fEntry.addByte('Byte',GetInt32);
      end
      else if s='bumpclampvalue' then begin
        Hint('bumpclampvalue');
        fEntry.addSingle('single',GetSingle);
      end
      else if s='DisableScenerios' then begin
        Hint('DisableScenerios');
        fEntry.addInt32('Int32',GetInt32);
      end
      else if s='WaterColor' then begin
        Hint('WaterColor');
        for i := 0 to 22 do
          fEntry.addSingle('single',GetSingle);
      end
      else if s='Object' then begin
        zeile := copy(zeile,4,length(zeile)-3); // entferne "Obj"
        if n=6 then begin
          Group('<Objects>','');
          i := GetInt32;
          fEntry.addInt32('Type',i);
          fEntry.addSingle('X',GetSingle);
          fEntry.addSingle('Y',GetSingle);
          fEntry.addSingle('Z',GetSingle);
          fEntry.addSingle('Angle',GetSingle);
          lobject := fEntry;
        end
        else if n=8 then begin
          Group('<Objects>','');
          i := GetInt32;
          fEntry.addInt32('Type',i);
          fEntry.addSingle('X',GetSingle);
          fEntry.addSingle('Y',GetSingle);
          fEntry.addSingle('Z',GetSingle);
          fEntry.addSingle('Angle X',GetSingle);
          fEntry.addSingle('Angle Y',GetSingle);
          fEntry.addSingle('Angle Z',GetSingle);
          lObject := fEntry;
        end
        else begin
          i := -1;
          halt(1);
        end;
        fEntry.SetName('Object '+Objectname(i));
      end
      else if s='AIMode' then begin
        i := GetInt32;
        lobject.addByte('AIMode',i);
        if lobject.getName='Object marker' then
          SpecialMarkerName(lobject,i);
      end
      else if s='TeamId' then begin
        lobject.addInt32('TeamID',GetInt32);
      end
      else if s='Scale' then begin
        lobject.addSingle('Scale',GetSingle);
      end
      else if s='OData' then begin
        fEntry := lobject.addNode('OData');
        for i := 0 to 2 do
          fEntry.addSingle('single',GetSingle);
      end
      else if s='LightColor' then begin
        fEntry := lobject.addNode('LightColor');
        for i := 0 to 2 do
          fEntry.addSingle('single',GetSingle);
      end
      else
        Writeln('Fehler: unbekannter Bezeichner: '+s);
    end;
    Close(f);

    fbase.addNode('Done');

    fBase.link(fileEnd);
  end;*)






  {
| byte Datatype=$17, int32 ScaleFactor
| byte Datatype=$1A, int32[8] Header0_Data, <PChar> (''|'box01'), <PChar> GTIName
| byte Datatype=$1E, char[16] Sky_TextureName

| byte Datatype=$25, char[16] Sea_TextureName
| byte Datatype=$26, char[16] Seabed_TextureName
| byte Datatype=$27, byte SuspBl1_Index, single[4] SuspBl1_Data
| byte Datatype=$28, byte SuspBl3_red,byte SuspBl3_green,byte SuspBl3_blue
| byte Datatype=$29, single[2] TerrainFogParam, byte[3] TerrainFogColor
| byte Datatype=$2A, int32 Objecttype, single[3] Origin, single Angle
| byte Datatype=$2E, single[3] SuspBl3_Data

| byte Datatype=$30, byte SuspBl2_Index, byte _=1, single[4] SuspBl2_Data
| byte Datatype=$34, char[32] Ground_TextureName, single[3] Ground_TextureParams
| byte Datatype=$35, char[32] Wall1_TextureName, single[3] Wall1_TextureParams
| byte Datatype=$36, char[32] Wall2_TextureName, single[3] Wall2_TextureParams
| byte Datatype=$39, single[7] Header1_Data
| byte Datatype=$3B, byte AIMode

| byte Datatype=$44     // Hauptblock Anfang
| byte Datatype=$45     // Hauptblock Ende
| byte Datatype=$46, int32 Objecttype, single[3] Origin, single[3] Angle
| byte Datatype=$4F, char[64] FlickName

| byte Datatype=$52, int32 TeamID
| byte Datatype=$58, single[2] WaterFogParam, byte[3] WaterFogColor
| byte Datatype=$5A, single[3] OData
| byte Datatype=$5C, byte _=2, int32 _=1, char[32] MissionName
| byte Datatype=$5D, byte _=$6D, byte _=$69, char[30] MissionName
| byte Datatype=$5F, single[3] LightColor

| byte Datatype=$60, int32 DisableScenarios

| byte Datatype=$73, char[32] Wallbump1_TextureName, single[3] Wallbump1_TextureParams
| byte Datatype=$74, char[32] Wallbump2_TextureName, single[3] Wallbump2_TextureParams
| byte Datatype=$75, single BumpClampValue
| byte Datatype=$76, PChar SunModel, single[5] SunData
| byte Datatype=$77, int32 SuspBl5L, single[11] SuspBl5S
| byte Datatype=$77, int32 SuspBl6L, single[11] SuspBl6S
| byte Datatype=$79, single[23] WaterColor

| byte Datatype=$84, PChar Streamfolder

| byte Datatype=$E5, byte _=2, byte_=0

| byte Datatype=$FF, <TailData>

}

procedure WriteByte(b :byte);
  begin
    data[dataptr] := b;
    inc(dataptr);
  end;

procedure WriteInt32(l :longint);
  begin
    Move(l,data[dataptr],4);
    inc(dataptr,4);
  end;

procedure WriteString0(s :string);
  begin
    s := s+#0;
    Move(s[1],data[dataptr],length(s));
    inc(dataptr,length(s));
  end;

procedure WriteLString0(s :string);
  begin
    s := s+#0;
    s := chr(length(s))+s;
    Move(s[1],data[dataptr],length(s));
    inc(dataptr,length(s));
  end;

procedure WriteString16(s :string);
  begin
    while length(s)<16 do s := s+#0;
    Move(s[1],data[dataptr],length(s));
    inc(dataptr,length(s));
  end;

procedure WriteString32(s :string);
  begin
    while length(s)<32 do s := s+#0;
    Move(s[1],data[dataptr],length(s));
    inc(dataptr,length(s));
  end;

procedure WriteString64(s :string);
  begin
    while length(s)<64 do s := s+#0;
    Move(s[1],data[dataptr],length(s));
    inc(dataptr,length(s));
  end;

procedure WriteContent(th :tTreeHandle);
  var
    i :longint;
    s :string;
    si :single;
  begin
    if th.isANode then begin
      ConsoleFrame.WriteMessage('Error: WriteContent can''t be applied to nodes; here it was applied onto '+th.getName);
{      th.SearchInitLeaf;
      while th.SearchNextLeaf do
        WriteContent(th);
      th.SearchInitNode;
      while th.SearchNextNode do
        WriteContent(th);}
      exit;
    end;
    case th.getType of
      tprByte:begin
        WriteByte(th.getByte);
      end;
      tprInt32:begin
        i := th.getInt32;
        Move(i,data[dataptr],4);
        inc(dataptr,4);
      end;
      tprSingle:begin
        si := th.getSingle;
        Move(si,data[dataptr],4);
        inc(dataptr,4);
      end;
      tprString:ConsoleFrame.WriteMessage('Error: WriteContent can''t be applied to strings; here it was applied onto '+th.getName);
    end
  end;

procedure SaveTiling(th :tTreeHandle);
  begin
    WriteByte($39);
    WriteContent(th.GetChildLeaf('p0'));
    WriteContent(th.GetChildLeaf('p1'));
    WriteContent(th.GetChildLeaf('p2'));
    WriteContent(th.GetChildLeaf('p3'));
    WriteContent(th.GetChildLeaf('p4'));
    WriteContent(th.GetChildLeaf('p5'));
    WriteContent(th.GetChildLeaf('p6'));
  end;


procedure WriteTexture(th :tTreeHandle);
  begin
    WriteString32(th.GetChildLeaf('Name').getString);
    WriteContent(th.GetChildLeaf('Stretch'));
    WriteContent(th.GetChildLeaf('Offset X'));
    WriteContent(th.GetChildLeaf('Offset Y'));
  end;

procedure SaveTextures(th :tTreeHandle);
  begin
    th.SearchInitLeaf;
    while th.SearchNextLeaf do
      if th.getName='DomeTex' then begin
        WriteByte($1E);
        WriteString16(th.getString);
      end
      else if th.getName='SeaTex' then begin
        WriteByte($25);
        WriteString16(th.getString);
      end
      else if th.getName='GlowTex' then begin
        WriteByte($26);
        WriteString16(th.getString);
      end
      else
        Writeln('Error: SaveTextures does not know '+th.getName);
    th.SearchInitNode;
    while th.SearchNextNode do
      if th.getName='GroundTexture' then begin
        WriteByte($34);
        WriteTexture(th);
      end
      else if th.getName='SlopeTexture' then begin
        WriteByte($35);
        WriteTexture(th);
      end
      else if th.getName='WallTexture' then begin
        WriteByte($36);
        WriteTexture(th);
      end
      else if th.getName='GroundBumpTexture' then begin
        WriteByte($72);
        WriteTexture(th);
      end
      else if th.getName='SlopeBumpTexture' then begin
        WriteByte($73);
        WriteTexture(th);
      end
      else if th.getName='WallBumpTexture' then begin
        WriteByte($74);
        WriteTexture(th);
      end
      else
        Writeln('Error: SaveTextures does not know '''+th.getName+'''');
   end;

procedure SaveSeaSpeed(th :tTreeHandle);
  begin
    WriteByte($2E);
    WriteContent(th.GetChildLeaf('p0'));
    WriteContent(th.GetChildLeaf('p1'));
    WriteContent(th.GetChildLeaf('p2'));
  end;

procedure SaveTeleport(th :tTreeHandle);
  begin
    th.SearchInitNode;
    while th.SearchNextNode do begin
      WriteByte($27);
      WriteContent(th.GetChildLeaf('Index'));
      WriteContent(th.GetChildLeaf('X'));
      WriteContent(th.GetChildLeaf('Y'));
      WriteContent(th.GetChildLeaf('Z'));
      WriteContent(th.GetChildLeaf('Angle'));
    end;
  end;

procedure SaveStartloc(th :tTreeHandle);
  begin
    th.SearchInitNode;
    while th.SearchNextNode do begin
      WriteByte($30);
      WriteContent(th.GetChildLeaf('Index'));
      WriteContent(th.GetChildLeaf('Unknown'));
      WriteContent(th.GetChildLeaf('X'));
      WriteContent(th.GetChildLeaf('Y'));
      WriteContent(th.GetChildLeaf('Z'));
      WriteContent(th.GetChildLeaf('Angle'));
    end;
  end;

procedure SaveDone(th :tTreeHandle);
  begin
    WriteByte($FF);
  end;

procedure SaveFileEndIncs(th :tTreeHandle);
  var
    i,l :longint;
  begin
    l := th.nodes;
    WriteInt32(l);
//    WriteLength
    th.SearchInitNode;
    while th.SearchNextNode do begin
      WriteContent(th.GetChildLeaf('Unknown'));
      WriteContent(th.GetChildLeaf('IsSkyDome'));
      WriteLString0(th.GetChildLeaf('Name').getString);
    end;
  end;

procedure SaveFileEndUnkn(th :tTreeHandle);
  begin
    WriteContent(th);
  end;

procedure SaveFileEndScen(th :tTreeHandle);
  var
    i,l :longint;
  begin
    l := th.nodes;
    WriteInt32(l);
    th.searchinitleaf;
    while th.SearchNextLeaf do begin
      WriteContent(th.GetChildLeaf('Index'));
      WriteString32(th.GetChildLeaf('Name').getstring);
    end;
  end;

procedure SaveFileEndFX(th :tTreeHandle);
  var
    l :longint;
  begin
    l := th.leaves;
    WriteInt32(l);
    WriteContent(th);
  end;

procedure SaveFlicks(th :tTreeHandle);
  begin
    th.SearchInitLeaf;
    while th.SearchNextLeaf do begin 
      WriteByte($4F);
      WriteString64(th.getString);
    end
  end;

procedure SaveSun(th :tTreeHandle);
  begin
    th.SearchInitNode;
    while th.SearchNextNode do
      if th.getName='SunColor' then begin
        WriteByte($28);
        WriteContent(th.GetChildLeaf('Red'));
        WriteContent(th.GetChildLeaf('Green'));
        WriteContent(th.GetChildLeaf('Blue'));
      end
      else if th.getName='Sunfxname' then begin
        WriteByte($76);
        WriteString0(th.GetChildLeaf('Name').getString);
        WriteContent(th.GetChildLeaf('p0'));
        WriteContent(th.GetChildLeaf('p1'));
        WriteContent(th.GetChildLeaf('p2'));
        WriteContent(th.GetChildLeaf('p3'));
        WriteContent(th.GetChildLeaf('p4'));
      end
      else if (th.getName='Sunflare1') or (th.getName='Sunflare2') then begin
        if (th.getName='Sunflare1') then
          WriteByte($77)
        else
          WriteByte($78);
        WriteContent(th.GetChildLeaf('unknown'));
        WriteContent(th.GetChildLeaf('p0'));
        WriteContent(th.GetChildLeaf('p1'));
        WriteContent(th.GetChildLeaf('p2'));
        WriteContent(th.GetChildLeaf('p3'));
        WriteContent(th.GetChildLeaf('p4'));
        WriteContent(th.GetChildLeaf('p5'));
        WriteContent(th.GetChildLeaf('p6'));
        WriteContent(th.GetChildLeaf('p7'));
        WriteContent(th.GetChildLeaf('p8'));
        WriteContent(th.GetChildLeaf('p9'));
        WriteContent(th.GetChildLeaf('p10'));
      end
      else
        ConsoleFrame.WriteMessage('Error: SaveSun does not know '+th.getName);
  end;

procedure SaveObjects(th :tTreeHandle);
  var
    th2 :tTreeHandle;
  begin
    th.SearchInitNode;
    while th.SearchNextNode do begin
      th.ScanInitLeaf;
      if th.ScanLeaf('Angle') then begin
        th2 := th;
        WriteByte($2A);
        th.ScanLeaf('Type');
        WriteContent(th);
        th.ScanLeaf('X');
        WriteContent(th);
        th.ScanLeaf('Y');
        WriteContent(th);
        th.ScanLeaf('Z');
        WriteContent(th);
        WriteContent(th2);
      end
      else begin
        WriteByte($46);
        th.ScanLeaf('Type');
        WriteContent(th);
        th.ScanLeaf('X');
        WriteContent(th);
        th.ScanLeaf('Y');
        WriteContent(th);
        th.ScanLeaf('Z');
        WriteContent(th);
        th.ScanLeaf('Angle X');
        WriteContent(th);
        th.ScanLeaf('Angle Y');
        WriteContent(th);
        th.ScanLeaf('Angle Z');
        WriteContent(th);
      end;
      if th.ScanLeaf('Scale') then begin
        WriteByte($17);
        WriteContent(th)
      end;
      if th.ScanLeaf('AIMode') then begin
        WriteByte($3B);
        WriteContent(th);
      end;
      if th.ScanLeaf('TeamID') then begin
        WriteByte($52);
        WriteContent(th);
      end;
      if th.ScanLeaf('SplineKeyTime') then begin
        WriteByte($6B);
        WriteContent(th);
      end;
      if th.ScanLeaf('OData 0') then begin
        WriteByte($5A);
        WriteContent(th);
        th.ScanLeaf('OData 1');
        WriteContent(th);
        th.ScanLeaf('OData 2');
        WriteContent(th);
      end;
      if th.ScanLeaf('LightColor 0') then begin
        WriteByte($5F);
        WriteContent(th);
        th.ScanLeaf('LightColor 1');
        WriteContent(th);
        th.ScanLeaf('LightColor 2');
        WriteContent(th);
      end;

      th.ScanDone;
      th.ScanInitNode;
      while th.ScanNode('Lock') do begin
        WriteByte($4C);
        WriteContent(th.GetChildLeaf('Type'));
        WriteContent(th.GetChildLeaf('p1'));
        WriteContent(th.GetChildLeaf('p2'));
        SaveObjects(th);
        WriteByte($4D);
      end;

      {      if th.ScanNode('HerdMarkers') then begin
        WriteByte($5B);
        WriteContent(th);
      end;
      if th.ScanNode('MinishopRIcons') then begin
        WriteByte($67);
        WriteContent(th);
      end;
      if th.ScanNode('MinishopMIcons') then begin
        WriteByte($68);
        WriteContent(th);
      end;}
      th.ScanDone;
//      ConsoleFrame.WriteMessage(th.ScanDone);
    end;
  end;

procedure SaveFog(th :tTreeHandle);
  begin
    WriteByte($29);
    WriteContent(th.GetChildLeaf('Near distance'));
    WriteContent(th.GetChildLeaf('Far distance'));
    WriteContent(th.GetChildLeaf('Red'));
    WriteContent(th.GetChildLeaf('Green'));
    WriteContent(th.GetChildLeaf('Blue'));
  end;

procedure SaveWaterFog(th :tTreeHandle);
  begin
    WriteByte($58);
    WriteContent(th.GetChildLeaf('Near distance'));
    WriteContent(th.GetChildLeaf('Far distance'));
    WriteContent(th.GetChildLeaf('Red'));
    WriteContent(th.GetChildLeaf('Green'));
    WriteContent(th.GetChildLeaf('Blue'));
  end;

procedure SaveBumpclampvalue(th :tTreeHandle);
  begin
    WriteByte($75);
    WriteContent(th.GetChildLeaf('Value'));
  end;

procedure SaveDisableScenerios(th :tTreeHandle);
  begin
    WriteByte($60);
    WriteContent(th.GetChildLeaf('Value'));
  end;

procedure SaveWaterColor(th :tTreeHandle);
  begin
    WriteByte($79);
    WriteContent(th.GetChildLeaf('p0'));
    WriteContent(th.GetChildLeaf('p1'));
    WriteContent(th.GetChildLeaf('p2'));
    WriteContent(th.GetChildLeaf('p3'));
    WriteContent(th.GetChildLeaf('p4'));
    WriteContent(th.GetChildLeaf('p5'));
    WriteContent(th.GetChildLeaf('p6'));
    WriteContent(th.GetChildLeaf('p7'));
    WriteContent(th.GetChildLeaf('p8'));
    WriteContent(th.GetChildLeaf('p9'));
    WriteContent(th.GetChildLeaf('p10'));
    WriteContent(th.GetChildLeaf('p11'));
    WriteContent(th.GetChildLeaf('p12'));
    WriteContent(th.GetChildLeaf('p13'));
    WriteContent(th.GetChildLeaf('p14'));
    WriteContent(th.GetChildLeaf('p15'));
    WriteContent(th.GetChildLeaf('p16'));
    WriteContent(th.GetChildLeaf('p17'));
    WriteContent(th.GetChildLeaf('p18'));
    WriteContent(th.GetChildLeaf('p19'));
    WriteContent(th.GetChildLeaf('p20'));
    WriteContent(th.GetChildLeaf('p21'));
    WriteContent(th.GetChildLeaf('p22'));
  end;

procedure SaveStartWeather(th :tTreeHandle);
  begin
    WriteByte($59);
    WriteContent(th);
  end;

procedure SaveMissions(th :tTreeHandle);
  begin
    th.SearchInitLeaf;
    while th.SearchNextLeaf do begin
      WriteByte($5D);
      WriteString32(th.getString);
    end;
  end;

procedure SaveScenerios(th :tTreeHandle);
  begin
    th.SearchInitNode;
    while th.SearchNextNode do begin
      WriteByte($5C);
      WriteContent(th.GetChildLeaf('Type'));
      WriteContent(th.GetChildLeaf('Index'));
      WriteString32(th.GetChildLeaf('Name').getString);
    end;
  end;


{LandAngles
LandTexFade}

function SaveBinW:tByteList;
  var
    s :string;
    th,th2 :tTreeHandle;
    i,l :longint;
    pointers :array[-1..6] of integer;
    dataptr2 :longint;

  begin
    th := fbase;
    SetLength(data,1000000);
    dataptr := 32;
    th.ScanInitNode;
    if not th.ScanNode('[FileStart]') then raise Exception.Create('Fatal Error: Map file has no header');
    // Pointer 0 : object list
    pointers[0] := dataptr;
    inc(dataptr,4);
    WriteString0(th.GetChildLeaf('Box').getString);
    WriteString0(th.GetChildLeaf('GtiName').getString);
    if th.ScanNode('Tiling') then
      SaveTiling(th);
    if th.ScanNode('<Textures>') then
      SaveTextures(th);
    if th.ScanNode('SeaSpeed') then
      SaveSeaSpeed(th);
    if th.ScanNode('<Teleport>') then
      SaveTeleport(th);
    if th.ScanNode('<StartLoc>') then
      SaveStartLoc(th);
    if th.ScanNode('<Sun>') then
      SaveSun(th);
    if th.ScanNode('<Flicks>') then
      SaveFlicks(th);
    if th.ScanNode('<PreObjects>') then
      SaveObjects(th);
    if th.ScanNode('StartWeather') then
      SaveStartWeather(th);
//    if th.ScanNode('ObjEditStart') then
      WriteByte($44);
    if th.ScanNode('Fog') then
      SaveFog(th);
    if th.ScanNode('WaterFog') then
      SaveWaterFog(th);
    if th.ScanNode('bumpclampvalue') then
      SaveBumpclampvalue(th);
    if th.ScanNode('DisableScenerios') then
      SaveDisableScenerios(th);
    if th.ScanNode('LandAngles') then begin
      WriteByte($66);
      WriteContent(th.GetChildLeaf('Angle 0'));
      WriteContent(th.GetChildLeaf('Angle 1'));
    end;
    if th.ScanNode('LandTexFade') then begin
      WriteByte($65);
      WriteContent(th.GetChildLeaf('p0'));
      WriteContent(th.GetChildLeaf('p1'));
      WriteContent(th.GetChildLeaf('p2'));
    end;
    if th.ScanNode('WaterColor') then
      SaveWaterColor(th);
    if th.ScanNode('<Missions>') then
      SaveMissions(th);
    if th.ScanNode('<Scenerios>') then
      SaveScenerios(th);
    if th.ScanNode('<Objects>') then
      SaveObjects(th);
//    if th.ScanNode('ObjEditEnd') then
      WriteByte($45);
    WriteByte($FF);

    l := dataptr-(pointers[0]+4);
    Move(l,data[Pointers[0]],4);

    // Pointer 1: texture files
    if not th.ScanNode('[textures]') then raise Exception.Create('Fatal Error: Map file has no texture section');
    pointers[1] := dataptr;
    SaveFileEndIncs(th);

    // pointer 4: fx
    if not th.ScanNode('[fx]') then raise Exception.Create('Fatal Error: Map file has no "fx" section');
    pointers[4] := dataptr;
    WriteContent(th.GetChildLeaf('p0'));

    // pointer 5: scenerios
    if not th.ScanNode('[scenerios]') then raise Exception.Create('Fatal Error: Map file has no scenerios section');
    pointers[5] := dataptr;

    l := 0;
    dataptr2 := dataptr;
    inc(dataptr,4);
    th2 := th;
    th2.SearchInitLeaf;
    while th2.SearchNextLeaf do begin
      WriteContent(th2.getChildLeaf('Index'));
      WriteContent(th2.getChildLeaf('Name'));
      inc(l);
    end;
    Move(l,data[dataptr2],4);

    // pointer 6: includefiles
    if not th.ScanNode('[includefiles]') then raise Exception.Create('Fatal Error: Map file has no includefiles section');
    pointers[6] := dataptr;
    l := th.leaves;
    Move(l,data[dataptr],4);
    inc(dataptr,4);
    th2 := th;
    th2.SearchInitLeaf;
    while th2.SearchNextLeaf do
      WriteString32(th2.getString);

    // Pointer 2: version chunk (?)
    if not th.ScanNode('[sfxlist]') then raise Exception.Create('Fatal Error: Map file has no sfx list section');
    pointers[2] := dataptr;
    WriteContent(th.GetChildLeaf('p0'));
    WriteContent(th.GetChildLeaf('p1'));
    WriteContent(th.GetChildLeaf('p2'));
    WriteContent(th.GetChildLeaf('p3'));
    WriteContent(th.GetChildLeaf('p4'));

    // Pointer 3: unknown
    if not th.ScanNode('[unknown]') then raise Exception.Create('Fatal Error: Map file has no "unknown" section');
    pointers[3] := dataptr;
    l := th.leaves;
    Move(l,data[dataptr],4);
    inc(dataptr,4);
    th2 := th;
    th2.SearchInitLeaf;
    while th2.SearchNextLeaf do
      WriteContent(th2);

    pointers[-1] := $1A0002E5;
    Move(pointers,data[0],32);

    SetLength(Result,dataptr);
    Move(data[0],Result[0],dataptr);
    SetLength(data,0);
    s := th.ScanDone;
    if s<>'' then
      ConsoleFrame.WriteMessage(s+#13#10+'These items were not included in the saved map file; all other items should be allright.');
  end;

function LoadBinW(data :tByteList) :boolean;
  var
    b :byte;
    i,n :longint;
    s2 :string;
    th :tTreeHandle;
    pointers :array[-1..6] of integer;

  begin
    bin_w_read.data := data;
    dataptr := 0;
    th.CreateNewBase('Map data',rMapData);
    fbase := th;

    Move(data[dataptr],pointers,32);
    inc(dataptr,32);

    // check file for validity

    for i := 0 to 6 do
      if (pointers[i]<32) or (pointers[i]>length(data)) then begin
        loadbinw := false;
        exit
      end;

    dataptr := pointers[0];

    Move(data[dataptr],n,4); // length of data block
    inc(dataptr,4);

    Hint('[FileStart]');

    s2 := ReadPChar('Box');
//    Write(ttable,s2,#9);
{    if s2<>'box01' then begin
      loadbinw := false;
      Close(f);
      exit
    end;}
    loadbinw := true;

    ReadPChar('GtiName');
    Help('automatic');
//    Write(ttable,ReadPChar('GtiName'),#9);

    w_bstart := false;
    w_bend := false;
    w_end := false;

//    Write(ttable,filepos(f),#9);

    try
    while true do begin  // not eof(f) and not (w_end and not (w_bstart xor w_bend))
      b := data[dataptr];
      inc(dataptr);
      if b=$FF then
        break;
      ReadChunk(b);
    end;
    except
      on e:exception do
        ConsoleFrame.WriteMessage('Error while parsing objects: '#13#10+e.Message);
    end;

    dataptr := pointers[1];
    Hint('[textures]');

    Move(data[dataptr],n,4);
    inc(dataptr,4);
    fSubTail := fEntry;
    for i := 0 to n-1 do begin
      fEntry := fSubTail.AddNode('texture');
      ReadByte('Unknown');
      ReadByte('IsSkyDome');
      ReadBLString('Name');  (***)
    end;

    dataptr := pointers[2];
    Hint('[sfxlist]');
    ReadInt32('p0');
    ReadInt32('p1');
    ReadInt32('p2');
    ReadInt32('p3');
    ReadInt32('p4');

    dataptr := pointers[3];
    Hint('[unknown]');
    Move(data[dataptr],n,4);
    inc(dataptr,4);
    for i := 0 to n-1 do
      ReadByte('unknown');

    dataptr := pointers[4];
    Hint('[fx]');
    ReadInt32('p0');

    dataptr := pointers[5];
    Hint('[scenerios]');
    Move(data[dataptr],n,4);
    inc(dataptr,4);
    fSubTail := fEntry;
    for i := 0 to n-1 do begin
      fEntry := fSubTail.AddNode('scenerio');
      ReadByte('Index');
      ReadString32('Name');
    end;

    dataptr := pointers[6];
    Hint('[includefiles]');
    Move(data[dataptr],n,4);
    inc(dataptr,4);
    for i := 0 to n-1 do
      ReadString32('Name');

//    if dataptr<>length(data) then
//      ConsoleFrame.WriteMessage('Error: w_*.bin file length is larger than expected');

  end;

procedure ReadMissionChunk(typ :byte);
  var
    s :string;
    n :integer;
  begin
    case typ of
      $03:begin // 1-angled object
        fentry := lobase.AddNode('Object');
        lobject := fentry;
        ReadInt32('Type');
        ReadSingle('X');
        ReadSingle('Y');
        ReadSingle('Z');
        ReadSingle('Angle');
      end;
      $04:begin // 3-angled object
        fentry := lobase.AddNode('Object');
        lobject := fentry;
        ReadInt32('Type');
        ReadSingle('X');
        ReadSingle('Y');
        ReadSingle('Z');
        ReadSingle('Angle X');
        ReadSingle('Angle Y');
        ReadSingle('Angle Z');
      end;
      $05:begin
        fentry := lobject;
        ReadByte('AIMode');
      end;
      $06:begin
        fentry := lobject;
        ReadSingle('OData 0');
        ReadSingle('OData 1');
        ReadSingle('OData 2');
      end;
      $07:begin
        fentry := lobject;
        ReadInt32('TeamID');
      end;
      $08:begin
        fentry := lobject;
        ReadByte('TriggerType');
      end;
      $09:begin
        fentry := lobject;
        ReadSingle('Scale');
      end;
      $0A:begin
        n := 0; Move(data[dataptr],n,1); inc(dataptr,1);
        while n>0 do begin
          ReadSingle('AIData');
          dec(n)
        end
      end;
      $0B:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadInt32('Character 0');
        ReadInt32('Character 1');
        ReadInt32('Character 2');
        ReadInt32('Character 3');
      end;
      $0C:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadInt32('SmartieType');
      end;
      $0D:begin
        ReadInt32('SpecialText');
      end;
      $0E:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        Move(data[dataptr],n,4); inc(dataptr,4);
        while n>0 do begin
          ReadInt32('Icons');
          dec(n)
        end
      end;
      $0F:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadInt32('VimpMeat');
      end;
      $10:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadInt32('NoNitro');
      end;
      $11:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadInt32('NoJetpack');
      end;
      $13:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadString32('FailFlick');
      end;
      $14:begin
        fentry := lobject;
        ReadString32('FlickUsed');
      end;
      $15:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadString32('StartFlick');
      end;
      $16:begin
        lobject :=  lobject.AddNode('Lock');
        fentry := lobject;
        ReadInt32('Type');
        ReadByte('Lock 1');
        ReadByte('Lock 2');
      end;
      $17:lobject := lobject.parent;
      $18:begin
        fentry := lobject;
        ReadSingle('Directions 0');
        ReadSingle('Directions 1');
        ReadSingle('Directions 2');
      end;
      $19:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadString32('EndFlick');
      end;
      $1A:begin
        fentry := lobject;
        ReadSingle('SplineScale 0');
        ReadSingle('SplineScale 1');
      end;
      $1C:begin
        fentry := lobject;
        ReadVoid('SplinePath3D');
      end;
      $1E:begin
        fentry := lobject;
        Move(data[dataptr],n,4); inc(dataptr,4);
        while n>0 do begin
          ReadInt32('MinishopRIcon');
          dec(n)
        end
      end;
      $1F:begin
        fentry := lobject;
        Move(data[dataptr],n,4); inc(dataptr,4);
        while n>0 do begin
          ReadInt32('MinishopMIcon');
          dec(n)
        end
      end;
      $20:begin
        fentry := lobject;
        ReadByte('SplineStartID');
      end;
      $21:begin
        fentry := lobject;
        ReadInt32('SplineKeyTime');
      end;
      $22:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadVoid('JetskiRace');
      end;
      $24:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadVoid('DiscardVimpMeat');
      end;
      $25:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadVoid('GrabSmartie');
      end;
      $26:begin
        fentry := wmbase[wmbaseidx].GetAddNode('<Options>');
        ReadSingle('SuccessDelay 0');
        ReadSingle('SuccessDelay 1');
      end;
      else begin
        Str(typ,s);
        ConsoleFrame.WriteMessage('Error: MissionRead does not understand chunk ID '+s);
        exit
      end
    end;
    if verbose then begin
      Str(typ,s);
      ConsoleFrame.WriteMessage('MissionRead: chunk ID '+s);
    end
  end;

function LoadBinWM(data :tByteList) :boolean;
  var
    b :byte;
    i,n :longint;
    s2 :string;
    th :tTreeHandle;
    magic :integer;

  begin
    bin_w_read.data := data;
    dataptr := 0;
    th.CreateNewBase('Mission data',rMissionData);
    wmbase[wmbaseidx] := th;

    Move(data[dataptr],magic,4);
    inc(dataptr,4);
    b := data[dataptr];
    inc(dataptr);

    // check file for validity

    lobase := wmbase[wmbaseidx].AddNode('<Objects>');
    if (magic<>4) or (b<>1) then begin
      loadbinwm := false;
      exit
    end;

    while true do begin
      b := data[dataptr];
      inc(dataptr);
      if b=$2 then
        break;
      ReadMissionChunk(b);
    end;

  end;



begin
  rMapData := LoadDTD('w.dtd')[0];
  rMissionData := LoadDTD('wm.dtd')[0];
  SetLength(wmbase,0);
end.
