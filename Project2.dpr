program Project2;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form2},
  Unit2 in 'Unit2.pas' {AboutBox},
  TrueValue in 'TrueValue.pas',
  Unit5 in 'Unit5.pas' {ImportWizard},
  Unit6 in 'Unit6.pas' {Form3},
  Unit7 in 'Unit7.pas' {Form4},
  Unit8 in 'Unit8.pas' {NewMapDialog},
  Unit9 in 'Unit9.pas' {StretchDialog},
  CropDialog in 'CropDialog.pas' {CropDlg},
  AddBorderDialog in 'AddBorderDialog.pas' {AddBorderDlg},
  FixEdgesDialog in 'FixEdgesDialog.pas' {FixEdgesDlg},
  LightingDialog in 'LightingDialog.pas' {LightingDlg},
  Heightbasedlighting in 'Heightbasedlighting.pas' {HeightBasedLight},
  GMMSaveDialog in 'GMMSaveDialog.pas' {GMMSaveDlg},
  GoToLocationDialog in 'GoToLocationDialog.pas' {GotoLocationDlg},
  Includefiles in 'Includefiles.pas' {IncludefilesDlg},
  EasyGTI in 'EasyGTI.pas' {EasyGTIDialog},
  Console in 'Console.pas' {ConsoleFrame},
  ZLib in '..\..\zlib\ZLIB.PAS',
  gck in 'gck.pas',
  inclist in 'inclist.pas',
  MapNamesDialog in 'MapNamesDialog.pas' {MapNamesDlg},
  dtd in 'dtd.pas',
  Unit10 in 'Unit10.pas' {Form10},
  Unit11 in 'Unit11.pas' {Form11},
  objectmanager in 'objectmanager.pas',
  ModelDetail in 'ModelDetail.pas' {Form12};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TImportWizard, ImportWizard);
  Application.CreateForm(TNewMapDialog, NewMapDialog);
  Application.CreateForm(TStretchDialog, StretchDialog);
  Application.CreateForm(TCropDlg, CropDlg);
  Application.CreateForm(TAddBorderDlg, AddBorderDlg);
  Application.CreateForm(TFixEdgesDlg, FixEdgesDlg);
  Application.CreateForm(TLightingDlg, LightingDlg);
  Application.CreateForm(THeightBasedLight, HeightBasedLight);
  Application.CreateForm(TGMMSaveDlg, GMMSaveDlg);
  Application.CreateForm(TGotoLocationDlg, GotoLocationDlg);
  Application.CreateForm(TIncludefilesDlg, IncludefilesDlg);
  Application.CreateForm(TEasyGTIDialog, EasyGTIDialog);
  Application.CreateForm(TConsoleFrame, ConsoleFrame);
  Application.CreateForm(TMapNamesDlg, MapNamesDlg);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TForm12, Form12);
  Form2.InitEdit;
  Application.Run;
end.
