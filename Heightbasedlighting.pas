unit Heightbasedlighting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, Menus;

type
  THeightBasedLight = class(TForm)
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Edit2: TEdit;
    Panel2: TPanel;
    Label3: TLabel;
    RadioButton1: TRadioButton;
    Edit3: TEdit;
    Panel3: TPanel;
    RadioButton2: TRadioButton;
    Edit4: TEdit;
    Panel4: TPanel;
    RadioButton3: TRadioButton;
    Edit5: TEdit;
    Panel5: TPanel;
    RadioButton4: TRadioButton;
    Edit6: TEdit;
    Panel6: TPanel;
    RadioButton5: TRadioButton;
    Edit7: TEdit;
    Panel7: TPanel;
    RadioButton6: TRadioButton;
    ColorDialog1: TColorDialog;
    CheckBox2: TCheckBox;
    RadioButton0: TRadioButton;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Image1: TImage;
    Image2: TImage;
    Shape1: TShape;
    Shape2: TShape;
    LoadPreset: TButton;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    procedure FormCreate(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure PanelClick(Sender: TObject);
    procedure LoadPresetClick(Sender: TObject);
    procedure ColorizeHeightbased(x1,y1,x2,y2 :integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    function Triangle1(x,y :integer):boolean;
    function Triangle2(x,y :integer):boolean;
    procedure RadioGroup1Click(Sender: TObject);
    procedure Panel8Click(Sender: TObject);
    procedure Panel9Click(Sender: TObject);
    procedure Panel10Click(Sender: TObject);
    procedure PlaceSun;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure UpdateLightmap;
    procedure ReadPresets(filename :string);
  private
    { Private declarations }
    Radios :array[0..6] of TRadioButton;
    Edits :array[0..6] of TEdit;
    Colors :array[0..6] of TPanel;
  public
    { Public declarations }
  end;
  tColorLevel = record
    color :TColor;
    height :single
  end;
  tLightingPreset=record
    name :string;
    colors :array of tColorLevel;
    enablesun :boolean;
    sunx,suny,sunz :single;
    sunlight,skylight,toplight :TColor
  end;

var
  HeightBasedLight: THeightBasedLight;
  heights :integer=7;
  heighttable :array[0..6] of single;
  colortable :array[0..6] of TColor;
  sun :boolean = false;
  sunlight :TColor = $00E0FF;
  skylight :TColor = $FF1F00;
  toplight :TColor = $000000;
  direction :integer = 0;
  sunvec :array[0..2] of single = (0.8,0,0.6);
  presets :array of tLightingPreset;


implementation


{$R *.dfm}

uses
  Unit1;

procedure THeightBasedLight.FormCreate(Sender: TObject);
  var
    i,code :integer;
  begin
    PlaceSun;
    Radios[0] := RadioButton0;
    Radios[1] := RadioButton1;
    Radios[2] := RadioButton2;
    Radios[3] := RadioButton3;
    Radios[4] := RadioButton4;
    Radios[5] := RadioButton5;
    Radios[6] := RadioButton6;
    Edits[0] := Edit1;
    Edits[1] := Edit2;
    Edits[2] := Edit3;
    Edits[3] := Edit4;
    Edits[4] := Edit5;
    Edits[5] := Edit6;
    Edits[6] := Edit7;
    Colors[0] := Panel1;
    Colors[1] := Panel2;
    Colors[2] := Panel3;
    Colors[3] := Panel4;
    Colors[4] := Panel5;
    Colors[5] := Panel6;
    Colors[6] := Panel7;
    for i := 0 to 6 do
      Edits[i].Color := $FFFFFF;
    for i := 0 to 6 do
      Val(Edits[i].Text,heighttable[i],code);
    for i := 0 to 6 do
      colortable[i] := colors[i].Color;
  end;

procedure THeightBasedLight.RadioButtonClick(Sender: TObject);
  var
    i,j :integer;
  begin
    for i := 0 to length(radios)-1 do if radios[i]=sender then begin
      for j := 0 to i do begin
        Edits[j].Enabled := true;
        Colors[j].Enabled := true;
      end;
      for j := i+1 to length(radios)-1 do begin
        Edits[j].Enabled := false;
        Colors[j].Enabled := false;
      end;
      heights := i+1;
    end
  end;

procedure THeightBasedLight.EditChange(Sender: TObject);
  var
    i,j,code :integer;
    s :single;
  begin
    for i := 0 to length(edits)-1 do begin //if edits[i]=sender then begin
      Val(edits[i].Text,s,code);
      if code<>0 then
        edits[i].Color := $C0C0FF
      else begin
        edits[i].Color := $FFFFFF;
        for j := i+1 to heights-1 do
          if heighttable[j]<=s then
            edits[i].Color := $C0C0FF;
        for j := 0 to i-1 do
          if heighttable[j]>=s then
            edits[i].Color := $C0C0FF;
      end;
      if edits[i].Color = $FFFFFF then
        heighttable[i] := s;
    end;
    for i := 0 to length(edits)-1 do
      if edits[i].Color<>$FFFFFF then
        exit;
    UpdateLightmap;
  end;

procedure THeightBasedLight.PanelClick(Sender: TObject);
  var
    i :integer;
  begin
    for i := 0 to length(colors)-1 do if colors[i]=sender then begin
      ColorDialog1.Color := colors[i].color;
      if colordialog1.execute then begin
        colors[i].color := colordialog1.color;
        colortable[i] := colors[i].color;
        if Checkbox1.Checked then
          UpdateLightmap;
      end
    end
  end;


procedure THeightBasedLight.LoadPresetClick(Sender: TObject);
  var
    i :integer;
    mi :TMenuItem;
  begin
    PopupMenu1.Items.Clear;
    for i := 0 to length(presets)-1 do begin
      mi := TMenuItem.Create(HeightBasedLight);
      mi.Caption := presets[i].name;
      PopupMenu1.Items.Add(mi);
    end;
    PopupMenu1.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
  end;

function THeightBasedLight.Triangle1(x,y :integer):boolean;
  begin
    if (x<0) or (y<0) or (x>=terrain.xl-1) or (y>=terrain.yl-1) then
      Triangle1 := false
    else
      Triangle1 := terrain.triangle[y*terrain.xl+x] and 7 in [1,3,5,6];
          end;

function THeightBasedLight.Triangle2(x,y :integer):boolean;
  begin
    if (x<0) or (y<0) or (x>=terrain.xl-1) or (y>=terrain.yl-1) then
      Triangle2 := false
    else
      Triangle2 := terrain.triangle[y*terrain.xl+x] and 7  in [2,4,5,6,7];
  end;

procedure THeightBasedLight.ColorizeHeightbased(x1,y1,x2,y2 :integer);
  var
    x,y,i,j :integer;
    h,r :single;
    normal :array[0..2] of single;
  begin
    for i := 0 to heights-1 do
      if edits[i].Color<>$FFFFFF then
        exit;
    for y := Max(y1,0) to Min(y2-1,terrain.yl-1) do
      for x := Max(x1,0) to Min(x2-1,terrain.xl-1) do begin
        // 1. heightbased light
        h := terrain.height[y*terrain.xl+x];
        if h<heighttable[0] then h := heighttable[0];
        if h>heighttable[heights-1] then h := heighttable[heights-1];
        i := 0;
        while (h>heighttable[i+1]) do
          inc(i);
        if sun then begin
          normal[2] := terrain.stretch;
          if triangle1(x,y) or triangle2(x,y-1) then
            if triangle1(x-1,y) or triangle2(x-1,y-1) then
              normal[0] :=
               (terrain.height[y*terrain.xl+(x+1)]-terrain.height[y*terrain.xl+(x-1)])/2
            else
              normal[0] :=
               (terrain.height[y*terrain.xl+(x+1)]-terrain.height[y*terrain.xl+x])
          else
            if triangle1(x-1,y) or triangle2(x-1,y-1) then
              normal[0] :=
               (terrain.height[y*terrain.xl+x]-terrain.height[y*terrain.xl+(x-1)])
            else
              normal[0] := 0;
          if triangle2(x,y) or triangle1(x-1,y) then
            if triangle2(x,y-1) or triangle1(x-1,y-1) then
              normal[1] :=
               (terrain.height[(y+1)*terrain.xl+x]-terrain.height[(y-1)*terrain.xl+x])/2
            else
              normal[1] :=
               (terrain.height[(y+1)*terrain.xl+x]-terrain.height[y*terrain.xl+x])
          else
            if triangle2(x,y-1) or triangle1(x-1,y-1) then
              normal[1] :=
               (terrain.height[y*terrain.xl+x]-terrain.height[(y-1)*terrain.xl+x])
            else
              normal[1] := 0;
          r := 1/sqrt(sqr(normal[0])+sqr(normal[1])+sqr(normal[2]));
          for j := 0 to 2 do
            normal[j] := normal[j]*r;
          r := normal[0]*sunvec[0]+normal[1]*sunvec[1]+normal[2]*sunvec[2];
          if r<0 then r := 0;
          for j := 0 to 2 do
            terrain.light[y*terrain.xl+x,j] := min(round(
            ((colortable[i+1] shr (j*8) and 255)
            *(h-heighttable[i])/(heighttable[i+1]-heighttable[i])
            +(colortable[i] shr (j*8) and 255)
            *(heighttable[i+1]-h)/(heighttable[i+1]-heighttable[i]) )
            *(toplight shr (j*8) and 255*normal[2]
             +skylight shr (j*8) and 255
             +sunlight shr (j*8) and 255*r)/128),255);
        end
        else
          for j := 0 to 2 do
            terrain.light[y*terrain.xl+x,j] := round(
             (colortable[i+1] shr (j*8) and 255)
            *(h-heighttable[i])/(heighttable[i+1]-heighttable[i])
            +(colortable[i] shr (j*8) and 255)
            *(heighttable[i+1]-h)/(heighttable[i+1]-heighttable[i]));
        // 2. sunlight


      end;
    Form2.Draww;
  end;

procedure THeightBasedLight.CheckBox1Click(Sender: TObject);
begin
  if Checkbox1.Checked then
    UpdateLightmap;
end;

procedure THeightBasedLight.CheckBox2Click(Sender: TObject);
  begin
    sun := CheckBox2.Checked;
    Image1.Enabled := sun;
    Image2.Enabled := sun;
    Shape1.Enabled := sun;
    Shape2.Enabled := sun;
    Panel8.Enabled := sun;
    Panel9.Enabled := sun;
    Panel10.Enabled := sun;
    if Checkbox1.Checked then
      UpdateLightmap;
  end;

procedure THeightBasedLight.RadioGroup1Click(Sender: TObject);
begin
  if Checkbox1.Checked then
    UpdateLightmap;
end;


procedure THeightBasedLight.PlaceSun;
  begin
    Shape1.Left:=  Image1.Left-5+round((Sunvec[0]/2+0.5)*79);
    Shape1.Top :=  Image1.Top-5+round((Sunvec[1]/2+0.5)*79);
    Shape2.Left:=  Image2.Left-5+round((1-sqrt(sqr(Sunvec[0])+sqr(Sunvec[1])))*79);
    Shape2.Top :=  Image2.Top-5+round((1-Sunvec[2])*79);
  end;

procedure THeightBasedLight.Panel8Click(Sender: TObject);
  begin
    ColorDialog1.Color := TPanel(sender).Color;
    if colordialog1.execute then begin
      TPanel(sender).Color := colordialog1.color;
      sunlight := colordialog1.color;
      if Checkbox1.Checked then
         UpdateLightmap;
    end
  end;

procedure THeightBasedLight.Panel9Click(Sender: TObject);
  begin
    ColorDialog1.Color := TPanel(sender).Color;
    if colordialog1.execute then begin
      TPanel(sender).Color := colordialog1.color;
      skylight := colordialog1.color;
      if Checkbox1.Checked then
         UpdateLightmap;
    end
  end;

procedure THeightBasedLight.Panel10Click(Sender: TObject);
  begin
    ColorDialog1.Color := TPanel(sender).Color;
    if colordialog1.execute then begin
      TPanel(sender).Color := colordialog1.color;
      toplight := colordialog1.color;
      if Checkbox1.Checked then
         UpdateLightmap;
    end
  end;

procedure THeightBasedLight.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    r :single;
  begin
    if x<0 then x := 0;
    if x>79 then x := 79;
    if y<0 then y := 0;
    if y>79 then y := 79;
    SunVec[0] := x/39.5-1;
    SunVec[1] := y/39.5-1;
    r := sqr(SunVec[0])+sqr(SunVec[1]);
    if r>1 then begin
      r := sqrt(r)*1.0001;
      SunVec[0] := SunVec[0]/r;
      SunVec[1] := SunVec[1]/r
    end;
    SunVec[2] := sqrt(1-sqr(SunVec[0])-sqr(SunVec[1]));
    PlaceSun;
    if Checkbox1.Checked then
       UpdateLightmap;
  end;

procedure THeightBasedLight.Image2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    x2,y2,r :single;
  begin
    if x<0 then x := 0;
    if x>79 then x := 79;
    if y<0 then y := 0;
    if y>79 then y := 79;
    y2 := 1.0001-y/79;
    x2 := 1.0002-x/79;
    r := sqrt(sqr(x2)+sqr(y2));
    x2 := x2/r;
    y2 := y2/r;
    SunVec[2] := y2;
    r := sqrt(sqr(SunVec[1])+sqr(SunVec[0]));
    SunVec[0] := SunVec[0]/r*x2;
    SunVec[1] := SunVec[1]/r*x2;
    PlaceSun;
    if Checkbox1.Checked then
       UpdateLightmap;
  end;

procedure THeightBasedLight.Image1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    Image1MouseDown(sender,mbLeft,shift,x,y);
end;

procedure THeightBasedLight.Image2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    Image2MouseDown(sender,mbLeft,shift,x,y);
end;


procedure THeightBasedLight.UpdateLightmap;
  begin
    ColorizeHeightbased(0,0,terrain.xl,terrain.yl);
  end;

procedure THeightBasedLight.ReadPresets(filename :string);
  var
    t :system.text;
    s :string;
    mode :integer;
    preset :tLightingPreset;
    i :integer;
    b :boolean;
  begin
    AssignFile(t,filename);
    {$I-}
    Reset(t);
    if IOResult<>0 then
      exit;
    {$I+}
    mode := 0;
    while not eof(t) do begin
      Readln(t,s);
      s := trim(s);
      if (s='') or (s[1]=';') then
        continue;
      case mode of
        0:if s<>'[Lighting]' then
          continue
        else
          mode := 1;
        1:begin
          preset.name := s;
          mode := 2
        end;
        2:if s='<Sun>' then
          mode := 3
        else if s='<Top>' then
          mode := 4
        else if s='<Sky>' then
          mode := 5
        else if s='<Height>' then
          mode := 6
        else if s='#' then begin
          b := true;
          for i := 0 to length(presets)-1 do
            if presets[i].name=preset.name then begin
              presets[i] := preset;
              b := false;
              break
            end;
          if b then begin
            i := length(presets);
            SetLength(presets,i+1);
            presets[i] := preset
          end
        end;
      end;
    end;
  end;

end.
