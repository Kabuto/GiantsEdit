unit LightingDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls, Dialogs, OpenGL;

type
  TLightingDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label3: TLabel;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    Label7: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label8: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    ColorDialog1: TColorDialog;
    procedure FormShow(Sender: TObject);
    procedure PlaceSun;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LightingDlg: TLightingDlg;
  SunPos :TGLArrayf3 = (0,0.6,0.8);

implementation

uses
  Math,Unit1;

{$R *.dfm}

procedure TLightingDlg.PlaceSun;
  begin
    Shape1.Left:=   0+round((SunPos[0]/2+0.5)*127);
    Shape1.Top :=  24+round((SunPos[1]/2+0.5)*127);
    Shape2.Left:= 144+round((1-sqrt(sqr(SunPos[0])+sqr(SunPos[1])))*127);
    Shape2.Top :=  24+round((1-SunPos[2])*127);
  end;

procedure TLightingDlg.FormShow(Sender: TObject);
  var
    x,y,x2,y2 :integer;
  begin
    for y := 0 to 63 do
      for x := 0 to 63 do begin
        x2 := round((x/63-0.5)*max(terrain.xl,terrain.yl)+terrain.xl/2);
        y2 := round((y/63-0.5)*max(terrain.xl,terrain.yl)+terrain.yl/2);
        if (x2<0) or (x2>=terrain.xl) or (y2<0) or (y2>=terrain.yl) then
          Image1.Canvas.Pixels[x+32,y+32] := 0
        else
          Image1.Canvas.Pixels[x+32,y+32] :=
            terrain.light[y2*terrain.xl+x2,0]
           +terrain.light[y2*terrain.xl+x2,1]*256
           +terrain.light[y2*terrain.xl+x2,2]*65536;
      end;
    PlaceSun;
  end;

procedure TLightingDlg.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    r :single;
  begin
    if x<0 then x := 0;
    if x>127 then x := 127;
    if y<0 then y := 0;
    if y>127 then y := 127;
    SunPos[0] := x/63.5-1;
    SunPos[1] := y/63.5-1;
    r := sqr(SunPos[0])+sqr(SunPos[1]);
    if r>1 then begin
      r := sqrt(r)*1.0001;
      SunPos[0] := SunPos[0]/r;
      SunPos[1] := SunPos[1]/r
    end;
    SunPos[2] := sqrt(1-sqr(SunPos[0])-sqr(SunPos[1]));
    PlaceSun
  end;


procedure TLightingDlg.Image2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    x2,y2,r :single;
  begin
    if x<0 then x := 0;
    if x>127 then x := 127;
    if y<0 then y := 0;
    if y>127 then y := 127;
    y2 := 1.0001-y/127;
    x2 := 1.0002-x/127;
    r := sqrt(sqr(x2)+sqr(y2));
    x2 := x2/r;
    y2 := y2/r;
    SunPos[2] := y2;
    r := sqrt(sqr(SunPos[1])+sqr(SunPos[0]));
    SunPos[0] := SunPos[0]/r*x2;
    SunPos[1] := SunPos[1]/r*x2;
    PlaceSun
  end;

procedure TLightingDlg.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if ssLeft in Shift then
    Image1MouseDown(sender,mbLeft,shift,x,y);
end;

procedure TLightingDlg.Image2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if ssLeft in Shift then
    Image2MouseDown(sender,mbLeft,shift,x,y);
end;

procedure TLightingDlg.Panel1Click(Sender: TObject);
begin
  ColorDialog1.Color := Panel1.Color;
  if ColorDialog1.Execute then
    Panel1.Color := ColorDialog1.Color;
end;

procedure TLightingDlg.Panel2Click(Sender: TObject);
begin
  ColorDialog1.Color := Panel2.Color;
  if ColorDialog1.Execute then
    Panel2.Color := ColorDialog1.Color;
end;

procedure TLightingDlg.Panel3Click(Sender: TObject);
begin
  ColorDialog1.Color := Panel3.Color;
  if ColorDialog1.Execute then
    Panel3.Color := ColorDialog1.Color;
end;

procedure TLightingDlg.OKBtnClick(Sender: TObject);
  begin
    // now comes the really dirty stuff... RAYTRACING!!!
(*    for y := 0 to terrain.yl-1 do
      for x := 0 to terrain.xl-1 do begin
      eye[0] := x*terrain.stretch+terrain.xoffset;
      eye[1] := y*terrain.stretch+terrain.yoffset;
      eye[2] := terrain.height[y*terrain.xl+x]+0.01; // threshold value
      ray[0] := sunpos[0];
      ray[1] := sunpos[1];
      ray[2] := sunpos[2];
      vertex := Form2.Raytrace(eye,ray,false);
      for i := 0 to 2 do
        light[i] := (Panel3.Color shr (i*8) and 255)*TrackBar3.Position/255;
      if vertex[2]<0 then begin

        if trianglevisible(x,y,0) then
          gettrianglenormal(x,y,0)
        vertex[0] := terrain.height[y*terrain.xl+(x-1)]- ,y)-h(x+1,y);
        vertex[1] := h(x,y+1)-h(x,y-1);
        vertex[2] := 2*terrain.stretch;
        terrain.light[y*terrain.xl+x,1] :=
          |(2*st,0,h(x+1,y)-h(x-1,y)) x (0,2*st,h(x,y+1)-h(x,y-1))|
          * ray




      else
        terrain.light[y*terrain.xl+x,1] := 0;
{        for i := 0 to 2 do
          light[i] := light[i]+(Panel1.Color shr (i*8) and 255)*TrackBar1.Position/255;
      for i := 0 to 2 do begin
        light[i] := light[i]/255*terrain.light[y*terrain.xl+x,i];
        if light[i]<0 then light[i] := 0;
        if light[i]>255 then light[i] := 255;
        terrain.light[y*terrain.xl+x,i] := round(light[i]);
      end;}
    end;*)
  end;

end.
