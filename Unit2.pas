unit Unit2;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, MMSystem;

type
  TAboutBox = class(TForm)
    Image1: TImage;
    procedure FormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

uses
  Unit1;

{$R *.dfm}

procedure TAboutBox.FormClick(Sender: TObject);
  begin
    PlaySound(nil,0,SND_PURGE);
    self.Close;
  end;

procedure TAboutBox.FormShow(Sender: TObject);
  begin
    PlaySound(pchar(giantsfolder+'Stream\Intro_island\Intro_island.wav'),0,SND_ASYNC or SND_FILENAME or SND_NODEFAULT or SND_NOSTOP or SND_LOOP)
  end;



end.

