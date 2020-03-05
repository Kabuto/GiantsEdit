unit FixEdgesDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TFixEdgesDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    RadioGroup2: TRadioGroup;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FixEdgesDlg: TFixEdgesDlg;

implementation

uses
  Unit1,Math;

{$R *.dfm}



procedure TFixEdgesDlg.OKBtnClick(Sender: TObject);
var
  x,y :integer;
function TrianglesAt(x,y :longint):byte;
  begin
    if (x<0) or (y<0) or (x>=terrain.xl-1) or (y>=terrain.yl-1) then
      TrianglesAt := 0
    else
      TrianglesAt := terrain.triangle[y*terrain.xl+x] and 7;
  end;

begin
  for y := 0 to terrain.yl-1 do
    for x := 0 to terrain.xl-1 do
      if (TrianglesAt(x,y) in [0,2]) or (TrianglesAt(x-1,y-1) in [0,1]) or
        (TrianglesAt(x-1,y) in [0,4,7]) or (TrianglesAt(x,y-1) in [0,3]) then
          if RadioGroup2.ItemIndex=0 then
            terrain.height[y*terrain.xl+x] := -40*ord(RadioGroup1.ItemIndex=0)
          else
            terrain.height[y*terrain.xl+x] := Min(-40*ord(RadioGroup1.ItemIndex=0),terrain.height[y*terrain.xl+x]);
end;



end.
