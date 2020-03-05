unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Menus, StdCtrls, OpenGL, Grids, Unit2,
  Unit5,TreeManager, bin_w_read, ValEdit, TrueValue, Unit6, Unit7,
  Buttons, Math, CropDialog, AddBorderDialog, FixEdgesDialog, LightingDialog,
  Heightbasedlighting, Registry, GMMSaveDialog, GotoLocationDialog,
  MapObjReader, TreeWrapper, Includefiles, inclist,
  EasyGTI, Console, ZipMstr, ClipBrd, jpeg, MapNamesDialog,Unit10,Unit11,
  objectmanager;

const
  SO_LIGHTING=0;
  SO_SPECIAL=1;
  SO_VIMP=2;
  SO_MECCSHOP=3;
  SO_REAPERSHOP=4;

type
  TMemFile = array of byte;
  T2DControlList = array of array of tControl;
  TForm2 = class(TForm)
    MainMenu1: TMainMenu;
    Something1: TMenuItem;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel3: TPanel;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N2: TMenuItem;
    SaveAs1: TMenuItem;
    Save1: TMenuItem;
    Open1: TMenuItem;
    New1: TMenuItem;
    OpenGTIDialog: TOpenDialog;
    GTIheadereditor1: TMenuItem;
    N3DView1: TMenuItem;
    DrawDome: TMenuItem;
    DomeColor1: TMenuItem;
    seagroundcolor1: TMenuItem;
    Seacolor1: TMenuItem;
    ColorDialog1: TColorDialog;
    Help1: TMenuItem;
    About1: TMenuItem;
    ImportWizard1: TMenuItem;
    Mapproperties1: TMenuItem;
    Special1: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Panel2: TPanel;
    Panel5: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    ColorPanel: TPanel;
    ColorRed: TEdit;
    ColorGreen: TEdit;
    ColorBlue: TEdit;
    SaveGTIDialog: TSaveDialog;
    N3: TMenuItem;
    StretchMove1: TMenuItem;
    Crop1: TMenuItem;
    Addborders1: TMenuItem;
    SpeedButton7: TSpeedButton;
    Panel6: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Exportlightmap1: TMenuItem;
    Exportheightmap1: TMenuItem;
    Exporttrianglemap1: TMenuItem;
    ExportMapDialog: TSaveDialog;
    ExportHeightmapDialog: TSaveDialog;
    Fixopenedges1: TMenuItem;
    Heightbasedlight1: TMenuItem;
    N1: TMenuItem;
    Gotolocation1: TMenuItem;
    Viewobjectsthroughterrain1: TMenuItem;
    Markerreport1: TMenuItem;
    SpeedButton8: TSpeedButton;
    Panel7: TPanel;
    Obj_x: TEdit;
    Obj_y: TEdit;
    Obj_z: TEdit;
    Label4: TLabel;
    Obj_rot_chk: TCheckBox;
    Obj_aimode: TEdit;
    Obj_teamid: TEdit;
    Obj_scale: TEdit;
    Obj_scale_chk: TCheckBox;
    Obj_rot1: TEdit;
    Obj_rot2: TEdit;
    Obj_rot3: TEdit;
    Obj_light1: TEdit;
    Obj_light2: TEdit;
    Obj_light3: TEdit;
    Obj_special1: TEdit;
    Obj_special2: TEdit;
    Obj_special3: TEdit;
    Obj_type: TEdit;
    obj_aimode_chk: TCheckBox;
    obj_teamid_chk: TCheckBox;
    Savew_bindialog: TSaveDialog;
    PopupMenu1: TPopupMenu;
    CreateObjectCopy: TMenuItem;
    Createmarker1: TMenuItem;
    Deleteobjectundercursor1: TMenuItem;
    LocateGiantsExeDialog: TOpenDialog;
    Saveterrainas1: TMenuItem;
    Showconsole1: TMenuItem;
    N4: TMenuItem;
    Savemap1: TMenuItem;
    Import1: TMenuItem;
    Export1: TMenuItem;
    terrain1: TMenuItem;
    objects1: TMenuItem;
    Exportobjects1: TMenuItem;
    ZipMaster1: TZipMaster;
    NewOpenMapDialog: TOpenDialog;
    Createweirdmatrix1: TMenuItem;
    Createinverseparabolicshape1: TMenuItem;
    Image4: TImage;
    GroupBox1: TGroupBox;
    TrackBar2: TTrackBar;
    Edit4: TEdit;
    GroupBox2: TGroupBox;
    TrackBar3: TTrackBar;
    Edit5: TEdit;
    Panel4: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Optimizemapnoedges1: TMenuItem;
    Softenmapincludingedges1: TMenuItem;
    Clearterrain1: TMenuItem;
    Clearterrain2: TMenuItem;
    Image5: TImage;
    N5: TMenuItem;
    Closemap1: TMenuItem;
    Displaynonerrormessages1: TMenuItem;
    Label6: TLabel;
    Placeallobjectonsurface1: TMenuItem;
    StaticText1: TStaticText;
    Label7: TLabel;
    Obj_Vimp1: TEdit;
    Obj_Vimp2: TEdit;
    Obj_Vimp3: TEdit;
    Mapnames1: TMenuItem;
    errain1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    Cameramode1: TMenuItem;
    Heighteditor1: TMenuItem;
    Lighteditor1: TMenuItem;
    riangleeditor1: TMenuItem;
    Objecteditingmode1: TMenuItem;
    Button1: TButton;
    PopupMenu2: TPopupMenu;
    Lighting1: TMenuItem;
    Special2: TMenuItem;
    Vimpherdcontroller1: TMenuItem;
    Meccshopitems1: TMenuItem;
    Reapershopitems1: TMenuItem;
    Obj_light: TLabel;
    Obj_special: TLabel;
    Obj_Vimp: TLabel;
    Obj_Meccshop: TLabel;
    Obj_Reapershop: TLabel;
    Obj_Meccshop1: TEdit;
    Obj_Reapershop1: TEdit;
    Obj_Vimp4: TEdit;
    Obj_Vimp5: TEdit;
    Specialproperties: TPopupMenu;
    aplight: TMenuItem;
    apspecial: TMenuItem;
    apvimp: TMenuItem;
    apmeccshop: TMenuItem;
    apreapershop: TMenuItem;
    Missionobjectstreeview1: TMenuItem;
    N11: TMenuItem;
    Worldobjectsvisible1: TMenuItem;
    Worldobjectseditable1: TMenuItem;
    Missionobjectsvisible1: TMenuItem;
    Missionobjectseditable1: TMenuItem;
    Missions1: TMenuItem;
    Drawrealobjects1: TMenuItem;
    ExporttoAGSPTmapformat1: TMenuItem;
    Viewterrainmesh1: TMenuItem;
    Modeldebugger1: TMenuItem;
    procedure InitEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure Splitter2Moved(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure DrawDomeClick(Sender: TObject);
    procedure DomeColor1Click(Sender: TObject);
    procedure Seacolor1Click(Sender: TObject);
    procedure seagroundcolor1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure ImportWizard1Click(Sender: TObject);
    procedure GTIheadereditor1Click(Sender: TObject);
    procedure Mapproperties1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure ColorPanelClick(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure UpdateColor;
    procedure ColorRedChange(Sender: TObject);
    procedure ColorGreenChange(Sender: TObject);
    procedure ColorBlueChange(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Save1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
//    procedure FormPaint(Sender: TObject);
    procedure UpdateTerrainHeader;
    procedure StretchMove1Click(Sender: TObject);
    procedure Crop1Click(Sender: TObject);
    procedure Addborders1Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TrackBar1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Exportlightmap1Click(Sender: TObject);
    procedure Exportheightmap1Click(Sender: TObject);
    procedure Exporttrianglemap1Click(Sender: TObject);
    procedure Fixopenedges1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Lighting1Click(Sender: TObject);
    procedure Heightbasedlight1Click(Sender: TObject);
    procedure SaveGTI(filename :string);
    procedure Gotolocation1Click(Sender: TObject);
    procedure Markerreport1Click(Sender: TObject);
    procedure Viewobjectsthroughterrain1Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure Obj_xChange(Sender: TObject);
    procedure Obj_yChange(Sender: TObject);
    procedure Obj_zChange(Sender: TObject);
    function LoadGTI(filename :string):boolean;
    function DecodeGTI(var gti :array of byte):boolean;
    procedure Obj_rot_chkClick(Sender: TObject);
    procedure SetMapObject(th :tTreeHandle);
    procedure ClearMapObject;
    procedure Obj_scale_chkClick(Sender: TObject);
    procedure Obj_light_chkClick(Sender: TObject);
    procedure Obj_special_chkClick(Sender: TObject);
    procedure obj_aimode_chkClick(Sender: TObject);
    procedure obj_teamid_chkClick(Sender: TObject);
    function Loadwbin(filename :string) :boolean;
    procedure SaveObjectsClick(Sender: TObject);
    procedure Deleteobjectundercursor1Click(Sender: TObject);
    procedure CreateObjectCopyClick(Sender: TObject);
    procedure Addincludefile1Click(Sender: TObject);
    procedure Copyincludefilelist1Click(Sender: TObject);
    procedure Pasteincludefilelist1Click(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure GZPIndexer;
    procedure expertmodeClick(Sender: TObject);
    procedure Openmap1Click(Sender: TObject);
    function Decompress(var buf :array of byte; start,len,finalsize:longint):tMemFile;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Showconsole1Click(Sender: TObject);
    procedure NewMap(filename :string);
    procedure Createweirdmatrix1Click(Sender: TObject);
    procedure objects1Click(Sender: TObject);
    procedure Createinverseparabolicshape1Click(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Savemap1Click(Sender: TObject);
    procedure Saveterrainas1Click(Sender: TObject);
    procedure SetDefaultTerrain;
    procedure ZipMaster1Message(Sender: TObject; ErrCode: Integer;
      msg: String);
    procedure Optimizemapnoedges1Click(Sender: TObject);
    procedure Softenmapincludingedges1Click(Sender: TObject);
    procedure Clearterrain2Click(Sender: TObject);
    procedure Clearterrain1Click(Sender: TObject);
    procedure Setmaptype1Click(Sender: TObject);
    procedure MapOpen;
    procedure MapClose;
    procedure Closemap1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function SaveMap:boolean;
    procedure Displaynonerrormessages1Click(Sender: TObject);
    procedure Placeallobjectonsurface1Click(Sender: TObject);
    procedure Mapnames1Click(Sender: TObject);
    procedure Cameramode1Click(Sender: TObject);
    procedure Heighteditor1Click(Sender: TObject);
    procedure Lighteditor1Click(Sender: TObject);
    procedure riangleeditor1Click(Sender: TObject);
    procedure Objecteditingmode1Click(Sender: TObject);
    procedure SpecUpdate;
    procedure Button1Click(Sender: TObject);
    procedure aplightClick(Sender: TObject);
    procedure Missions1Click(Sender: TObject);
    procedure Missionobjectstreeview1Click(Sender: TObject);
    procedure Worldobjectsvisible1Click(Sender: TObject);
    procedure Worldobjectseditable1Click(Sender: TObject);
    procedure Missionobjectsvisible1Click(Sender: TObject);
    procedure Missionobjectseditable1Click(Sender: TObject);
    procedure Exporttestfeature1Click(Sender: TObject);
    function LoadGZPFile(name :string):tMemFile;
    procedure Drawrealobjects1Click(Sender: TObject);
    procedure ExporttoAGSPTmapformat1Click(Sender: TObject);
    procedure Viewterrainmesh1Click(Sender: TObject);
    procedure Modeldebugger1Click(Sender: TObject);
  private
    { Private declarations }
    _MapObjectSelected :boolean;
    _MapObject :tTreeHandle;
    spec :T2DControlList;
    specactive :array of boolean;

    function GetTerrainVoxel(x,y :integer):TGLArrayf3; overload; pascal;
    function GetTerrainVoxel(x,y :integer; testinvisible:boolean):TGLArrayf3; overload; pascal;
    procedure Initsvet;
    procedure SetPixFormat;
//    procedure WMPaint(var Msg: TWMPaint);
//    procedure Panel1Redraw(Sender :TObject);
    procedure UpdateLowerPanel;
    function DecodeGZPFile(gzpname,ingzpfilename :string):tMemFile;
    function SaveGTIToStream:tByteList;
    procedure CreateNewObject(objectid,aimode :integer);
  public
    property MapObjectSelected :boolean read _MapObjectSelected;
    property MapObject :tTreeHandle read _MapObject;
    { Public declarations }
  published
    procedure Draww;
    procedure PaintTriangles(Sender: TObject; Shift: TShiftState; X, Y: Integer); pascal;
    procedure FlyAround(Sender: TObject; Shift: TShiftState; X, Y: Integer); pascal;
    procedure EditTerrain(Sender: TObject; Shift: TShiftState; X, Y: Integer); pascal;
    procedure PaintTerrain(Sender: TObject; Shift: TShiftState; X, Y: Integer); pascal;
    procedure EditObjects(Sender :TObject; Shift: TShiftState;X,Y :Integer; click :boolean); pascal;
    function Raytrace(eye,ray :TGLArrayf3; testinvisible:boolean):TGLArrayf3; pascal;
  end;
  tColor4=array[0..3] of byte;
  tMainEditProc = procedure(Sender: TObject; Shift: TShiftState; X, Y: Integer) of object; pascal;
  tTerrainheader = record
    signature :longint;
    u0 :longint;
    xoffset,yoffset :single;
    minheight,maxheight :single;
    xl,yl :longint;
    stretch :single;
    u1,u2,u3,u4 :single;
    version,u6 :word;
    u7,u8 :single;
    texture :array[0..31] of char;
  end;
  tgzpfile=record
    name :string;
    source :string;
  end;

  function Upcases(s :string):string;

const
  seaground = -42;
  domerad = 10240;
  domegradamt = 0.15;
var
  Form2: TForm2;
  PanelDC : HDC;
  Panelhrc : HGLRC;
  Yellow : array[0..3] of GLfloat = (1.0,1.0,0.0,1.0);
  lightpos : array[0..3] of GLfloat = (0.0,0.0,3.0,-1.0);
  lgih : array[0..3] of GLfloat = (1,1,1,1);
  domecolor :TColor = $FFFFFF;
  seacolor :TColor = $C08080;
  seagroundcolor :TColor = $008000;

  eye :TGLArrayf3 = (-2000,0.314,200);
  view :TGLArrayf3 = (1,0,0);
  up :TGLArrayf3 = (0,0,1);
  right :TGLArrayf3 = (0,1,0);
  fov :single = 65;
  oldmx,oldmy :integer;
  oldshift : TShiftState;

  time :GLFloat;

  terrain :tMap;
  terrainheader :tTerrainheader;

  CurrentHeight : single = -40;
  MinimumHeight : single = -40;
  MaximumHeight : single = 1000;

//  ShowABX :boolean = false;
//  ABXEntry :tABXEntry;
//  ABXDrawWhat :longint = -1;

  noevent :boolean = false;

  newobjpos :array[0..2] of single;
  newobjlastobject :TTreeHandle;

  mouseclickpos :array[0..1] of integer;

  brushradius :single = 2;
  brushalpha :single = 1;

  gzpentry :array of tGZPFile;
  giantsfolder :string;

  isready :boolean=false;

  map:record
    isopen :boolean;
    filename :string;
    wbinname :string;
    gtiname :string;
    gmmname :string;
    shareable :boolean;
    maptype :integer;
    usermessage :string;
    otherfilenames :array of string;
    otherfiles : array of tByteList;
    othertags : array of string;
  end;
//  texture : array[0..0] of GLuint;
  gtieditor : tTrueValueListEditor;
  binweditor : tTrueValueListEditor;
  binwmeditor : tTrueValueListEditor;

  lasterror :string;

  verbose :boolean=false;
  f :text;

  fbase :tTreeHandle;
  wmbase :array of tTreeHandle;
  wmbaseidx :integer=-1;

  editwobjects:boolean=true;
  editwmobjects:boolean=true;
  drawwobjects:boolean=true;
  drawwmobjects:boolean=true;

  DrawRealObjects :boolean=false;

  lineoffset :GLfloat = 1.0;

  MeshTexture : integer = -1;

type
  tTextureImage = record
    imageData : pointer;// Image Data (Up To 32 Bits)
    bpp : GLuint;       // Image Color Depth In Bits Per Pixel
    width : GLuint;	// Image Width
    height : GLuint;	// Image Height
    texID : GLuint;	// Texture ID Used To Select A Texture
  end;
  tObjectCreator = class
    ObjectID :integer;
    AIMode :integer;
    SetAIMode :boolean;
    constructor Create;
    procedure CreateObject(Source :TObject);
  end;


procedure glGenTextures(n: GLsizei; var textures: GLuint); stdcall; external 'opengl32.dll';
procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external 'opengl32.dll';
// procedure glPolygonOffset(factor :GLfloat; units :GLfloat); stdcall; external 'opengl32.dll';
// procedure glActiveTextureARB(target: GLenum); stdcall; external 'opengl32.dll';
procedure glEnableClientState(aarray: GLEnum); stdcall; external 'opengl32.dll';
procedure glVertexPointer(size: GLint; atype: GLEnum; stride: GLsizei; data: pointer); stdcall; external 'opengl32.dll';
procedure glColorPointer(size: GLint; atype: GLEnum; stride: GLsizei; data: pointer); stdcall; external 'opengl32.dll';
// procedure glLockArraysEXT(first: GLint; count: GLsizei); stdcall; external 'opengl32.dll';
procedure glDrawElements(mode: GLEnum; count: GLsizei; atype: GLEnum; indices: Pointer); stdcall; external 'opengl32.dll';
// procedure glUnlockArraysEXT; stdcall; external 'opengl32.dll';
procedure glDisableClientState(aarray: GLEnum); stdcall; external 'opengl32.dll';
// procedure glArrayElement(i: GLint); stdcall; external 'opengl32.dll';
procedure glTexCoordPointer(size: GLint; atype: GLEnum; stride: GLsizei; data: pointer); stdcall; external 'opengl32.dll';



const
  GL_POLYGON_OFFSET_UNITS                           = $2A00;
  GL_POLYGON_OFFSET_POINT                           = $2A01;
  GL_POLYGON_OFFSET_LINE                            = $2A02;
  GL_POLYGON_OFFSET_FILL                            = $8037;
  GL_POLYGON_OFFSET_FACTOR                          = $8038; 
      GL_VERTEX_ARRAY                            = $8074;
      GL_NORMAL_ARRAY                            = $8075;
      GL_COLOR_ARRAY                             = $8076;
      GL_INDEX_ARRAY                             = $8077;
      GL_TEXTURE_COORD_ARRAY                     = $8078;
      GL_EDGE_FLAG_ARRAY                         = $8079;
      GL_VERTEX_ARRAY_SIZE                       = $807A;
      GL_VERTEX_ARRAY_TYPE                       = $807B;
      GL_VERTEX_ARRAY_STRIDE                     = $807C;
      GL_NORMAL_ARRAY_TYPE                       = $807E;
      GL_NORMAL_ARRAY_STRIDE                     = $807F;
      GL_COLOR_ARRAY_SIZE                        = $8081;
      GL_COLOR_ARRAY_TYPE                        = $8082;
      GL_COLOR_ARRAY_STRIDE                      = $8083;
      GL_INDEX_ARRAY_TYPE                        = $8085;
      GL_INDEX_ARRAY_STRIDE                      = $8086;
      GL_TEXTURE_COORD_ARRAY_SIZE                = $8088;
      GL_TEXTURE_COORD_ARRAY_TYPE                = $8089;
      GL_TEXTURE_COORD_ARRAY_STRIDE              = $808A;
      GL_EDGE_FLAG_ARRAY_STRIDE                  = $808C;


implementation

uses Unit4, Unit8, Unit9, ModelDetail;


constructor TObjectCreator.Create;
  begin
    ObjectID := -1;
    AIMode := -1;
    SetAIMode := false;
  end;

procedure TObjectCreator.CreateObject(Source :TObject);
  begin
    Form2.CreateNewObject(objectid,aimode);
  end;

procedure TForm2.MapOpen;
  begin
    map.isopen := true;
    Panel2.Visible := true;
    Panel3.Visible := true;
    Image5.Visible := false;
    N3DView1.Visible := true;
    Something1.Visible := true;
    Special1.Visible := true;
    Savemap1.Visible := true;
    Errain1.Visible := true;
    Saveterrainas1.Visible := true;
    Save1.Visible := true;
    N3.Visible := true;
    Clearterrain1.Visible := true;
    Clearterrain2.Visible := true;
    Import1.Visible := true;
    Export1.Visible := true;
    N2.Visible := true;
    N5.Visible := true;
    Closemap1.Visible := true;
    Resize;
  end;

procedure TForm2.MapClose;
  begin
    map.isopen := false;
    Panel2.Visible := false;
    Panel3.Visible := false;
    Image5.Visible := true;
    N3DView1.Visible := false;
    Something1.Visible := false;
    Special1.Visible := false;
    Savemap1.Visible := false;
    Errain1.Visible := false;
    Saveterrainas1.Visible := false;
    Save1.Visible := false;
    N3.Visible := false;
    Clearterrain1.Visible := false;
    Clearterrain2.Visible := false;
    Import1.Visible := false;
    Export1.Visible := false;
    N2.Visible := false;
    N5.Visible := false;
    Closemap1.Visible := false;
    SetLength(map.otherfilenames,0);
    SetLength(map.otherfiles,0);
    SetLength(map.othertags,0);
  end;

procedure TForm2.SetDefaultTerrain;
var
  x,y,n :integer;
  r :single;
begin
  with terrainheader do begin
    signature := -1802088445;
    u0 := 0;
    u1 := 0.5;
    u2 := 0.5;
    u3 := 1.25e-4;
    u4 := 1.25e-4;
    version := 3;
    u6 := 1;
    u7 := 0;
    u8 := 1;
    texture := 'useless';
  end;
  with terrain do begin
    stretch := 40;
    xoffset := xl*stretch*-0.5;
    yoffset := yl*stretch*-0.5;
  end;

  Terrain.SetSize(64,64);
  terrain.xoffset := -32*20;
  terrain.yoffset := -32*20;
  terrain.stretch := 40;

  for x := 0 to 63 do
    for y := 0 to 63 do begin
//      x2 := x/32-1;
//      y2 := y/32-1;
      n := random(32);
      terrain.light[y*64+x,0] := round(sin((x*x-y*y)/1000)*112+112+n) and 255;
      terrain.light[y*64+x,1] := round(sin((2*(63-x)*(63-y))/1000)*112+112+n) and 255;
      terrain.light[y*64+x,2] := round(sin((2*x*(63-x)*(31-y))/10000)*112+112+n) and 255;
      terrain.light[y*64+x,3] := 0;
      r :=  sqr(sqr((x-31.5)/20)+sqr((y-31.5)/20));
      terrain.height[y*64+x] := sin(r)/r*400;
      terrain.triangle[y*64+x] := 5;
    end;
end;

procedure CreateMesh(xl,yl,bpp :integer; buffer :PByteArray); stdcall;
  var
    x,y,i :integer;
    x2,y2,z2 :single;
  begin
    for i := 0 to xl*yl*bpp-1 do
      buffer^[i] := 0;
    for y := 0 to yl-1 do
      for x := 0 to xl-1 do begin
        x2 := (x+0.5)/xl;
        y2 := (y+0.5)/yl;
        if x2<y2 then begin
          z2 := x2;
          x2 := y2;
          y2 := z2;
        end;
        buffer^[y*xl*bpp+x*bpp+3] := 255-Min(round(y2*(1-x2)*(x2-y2)*10000),255)
      end;
    for y := 1 to yl-2 do
      for i := 0 to bpp-1 do begin
        buffer^[y*xl*bpp+(y+1)*bpp+i] := 192;
        buffer^[y*xl*bpp+(y-1)*bpp+i] := 192;
        buffer^[y*xl*bpp+y*bpp+i] := 255;
      end;
    for x := 0 to xl-1 do
      for i := 0 to bpp-1 do begin
        buffer^[x*bpp+i] := 255;
        buffer^[(yl-1)*xl*bpp+x*bpp+i] := 255;
      end;
    for y := 0 to yl-1 do
      for i := 0 to bpp-1 do begin
        buffer^[y*xl*bpp+i] := 255;
        buffer^[(xl-1)*bpp+y*xl*bpp+i] := 255;
      end;
  end;

procedure TForm2.InitEdit;
var
//  Hansimage :TPicture;
  i :integer;
  s :string;
  name :string;
  code :integer;
  reg :TRegistry;
  menu,menu2:TMenuItem;
  creator :tObjectCreator;

begin
  s := ParamStr(0);
  while (s<>'') and (s[length(s)]<>'\') do
    s := copy(s,1,length(s)-1);
  AssignFile(f,s+'prefabs.txt');
  {$I-}
  Reset(f);
  if IOResult<>0 then
    Application.MessageBox('Prefabs file not found. This may disable some functionality.','Error')
  else begin
    while not eof(f) do begin
      Readln(f,s);
      s := trim(s);
      if s='' then continue;
      Val(s,i,code);
      if copy(s,1,6)='AIMode' then begin
        s := copy(s,8,length(s)-7);
        Val(s,i,code);
        creator.SetAIMode := true;
        creator.AIMode := i;
      end
      else if code=0 then begin
        creator.ObjectID := i;
        menu.Enabled := true
      end
      else begin
        name := s;
        menu := PopupMenu1.Items.Items[1];
        while name<>'' do begin
          s := '';
          while (name<>'') and (name[1]<>'/') do begin
            s := s+name[1];
            name := copy(name,2,length(name)-1)
          end;
          if name<>'' then
            name := copy(name,2,length(name)-1);
          if menu.Find(s)=nil then begin
            menu2 := TMenuItem.Create(self);
            menu2.Caption := s;
            menu.Add(menu2);
            menu := menu2
          end
          else
            menu := menu.Find(s);
          if name='' then begin
            creator := TObjectCreator.Create;
            menu.OnClick := creator.CreateObject;
            menu.Enabled := false;
          end;
        end;
      end;
    end;
    CloseFile(f);
    SetLength(spec,5);
    SetLength(specactive,5);
    for i := 0 to 4 do
      specactive[i] := false;
    SetLength(spec[0],4);
    Spec[0,0] := Obj_light;
    Spec[0,1] := Obj_light1;
    Spec[0,2] := Obj_light2;
    Spec[0,3] := Obj_light3;
    SetLength(spec[1],4);
    Spec[1,0] := Obj_special;
    Spec[1,1] := Obj_special1;
    Spec[1,2] := Obj_special2;
    Spec[1,3] := Obj_special3;
    SetLength(spec[2],6);
    Spec[2,0] := Obj_vimp;
    Spec[2,1] := Obj_vimp1;
    Spec[2,2] := Obj_vimp2;
    Spec[2,3] := Obj_vimp3;
    Spec[2,4] := Obj_vimp4;
    Spec[2,5] := Obj_vimp5;
    SetLength(spec[3],2);
    Spec[3,0] := Obj_meccshop;
    Spec[3,1] := Obj_meccshop1;
    SetLength(spec[4],2);
    Spec[4,0] := Obj_reapershop;
    Spec[4,1] := Obj_reapershop1;
  end;

  reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  s := '';
  if Reg.OpenKey('\SOFTWARE\GMM',false) then begin
    s := Reg.ReadString('DESTDIR');
    Reg.CloseKey;
  end;
  if (s<>'') and (s[length(s)]<>'\') then
    s := s+'\';
  if (s='') or not DirectoryExists(s+'Modpacks\') then begin
    Application.MessageBox('Warning: GMM is not installed. Go to http://www.qtpie.net and get it there.','Error');
  end
  else NewOpenMapDialog.InitialDir := s+'Modpacks\';
  if verbose then ConsoleFrame.WriteMessage('Indexing GZP files...');
  MapClose;
  GZPIndexer;

//  Hansimage := TPicture.Create;
//  Hansimage.LoadFromFile('je.bmp');

  OpenGTIDialog.InitialDir := 'e:\spiele\giants\bin\';

  Terrain := TMap.Create;

  SetDefaultTerrain;

  // Create The Texture
//  glGenTextures(1, texture[0]);
  // Typical Texture Generation Using Data From The Bitmap
//  glBindTexture(GL_TEXTURE_2D, texture[0]);
//  glTexImage2D(GL_TEXTURE_2D,0,3,64,64,0,GL_RGB,GL_UNSIGNED_BYTE,@Hansbitmap);
//  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
//  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);

  PanelDC := GetDC(Panel1.Handle);
  SetPixFormat;
  Panelhrc := wglCreateContext(PanelDC);
  wglMakeCurrent(PanelDC,Panelhrc);
  Initsvet;

  gtieditor := tTrueValueListEditor.Create;
  Form4 := TForm4.Create(self);
  Form4.Hide;
  gtieditor.BindEditor(Form4.ScrollBox2);

  binweditor := tTrueValueListEditor.Create;
  Form3 := TForm3.Create(self);
  Form3.Hide;
  binweditor.BindEditor(Form3.ScrollBox1);

  binwmeditor := tTrueValueListEditor.Create;
  binwmeditor.BindEditor(Form10.ScrollBox1);

  //  Panel1.OnPaint := Panel1Redraw;

//  editor.AddByte('Signature',51);
//  editor.AddSingle('Value',0.51341);
  SpeedButton1.Click;

//  Panel1.OnResize;
  s := ParamStr(0);
  while (s<>'') and (s[length(s)]<>'\') do
    s := copy(s,1,length(s)-1);

  MapObjReader.ReadMapFile(s+'MapObj.txt',Application);
  HeightBasedLight.ReadPresets('Lighting.txt');
  HeightBasedLight.ReadPresets('UserLighting.txt');

    _MapObjectSelected := false;

    for i := 0 to panel7.ControlCount-1 do
      panel7.Controls[i].Enabled := false;
    obj_type.Enabled := true;

   MeshTexture := Generate2DTexture(256,256,GL_RGBA,@CreateMesh,AVM_CALLBACK);

  ConsoleFrame.Hide;

  isready := true;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(Panelhrc);
  ReleaseDC(Handle,PanelDC);
end;

procedure TForm2.Initsvet;
begin
  glEnable(GL_TEXTURE_2D);
  glShadeModel(GL_SMOOTH);
  glClearColor(0.0,0.0,0.0,0.0);
  glClearDepth(1.0);
  glDepthFunc(GL_LEQUAL);
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
//  glEnable(GL_LIGHTING);
//  glEnable(GL_LIGHT0);
end;

procedure TForm2.SetPixFormat;
var
  nPixelFormat : integer;
  pfd : TPixelFormatDescriptor;
begin
  FillChar(pfd,SizeOf(pfd),0);
  with pfd do begin
    nSize := sizeof(pfd);
    nVersion := 1;
    dwFlags := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;

    iPixelType := PFD_TYPE_RGBA;
    cColorBits := 32;
    cDepthBits := 24;
    iLayerType := PFD_MAIN_PLANE;
  end;
  nPixelFormat := ChoosePixelFormat(PanelDC,@pfd);
  SetPixelFormat(PanelDC,nPixelFormat,@pfd);
end;

(*procedure TForm2.WMPaint(var Msg: TWMPaint);
var
  ps : TPaintStruct;
begin
  BeginPaint(Handle,ps);
  Draww;
  EndPaint(Handle,ps);
end;*)

procedure DrawBox(x1,y1,z1,x2,y2,z2 :single);
  begin
      glBegin(GL_TRIANGLES);
        glVertex3f(x1,y1,z1);
        glVertex3f(x2,y1,z1);
        glVertex3f(x1,y2,z1);
        glVertex3f(x1,y2,z1);
        glVertex3f(x2,y1,z1);
        glVertex3f(x2,y2,z1);
        glVertex3f(x1,y1,z2);
        glVertex3f(x2,y1,z2);
        glVertex3f(x1,y2,z2);
        glVertex3f(x1,y2,z2);
        glVertex3f(x2,y1,z2);
        glVertex3f(x2,y2,z2);

        glVertex3f(x1,y1,z1);
        glVertex3f(x1,y2,z1);
        glVertex3f(x1,y1,z2);
        glVertex3f(x1,y1,z2);
        glVertex3f(x1,y2,z1);
        glVertex3f(x1,y2,z2);
        glVertex3f(x2,y1,z1);
        glVertex3f(x2,y2,z1);
        glVertex3f(x2,y1,z2);
        glVertex3f(x2,y1,z2);
        glVertex3f(x2,y2,z1);
        glVertex3f(x2,y2,z2);

        glVertex3f(x1,y1,z1);
        glVertex3f(x2,y1,z1);
        glVertex3f(x1,y1,z2);
        glVertex3f(x1,y1,z2);
        glVertex3f(x2,y1,z1);
        glVertex3f(x2,y1,z2);
        glVertex3f(x1,y2,z1);
        glVertex3f(x2,y2,z1);
        glVertex3f(x1,y2,z2);
        glVertex3f(x1,y2,z2);
        glVertex3f(x2,y2,z1);
        glVertex3f(x2,y2,z2);
      glEnd;
  end;

procedure DrawObject(x,y,z,angle,scale :single; n :integer);
  var
    i,j :integer;
    sa,ca :single;
    x1,y1 :single;
    s :string;
  begin
    glMatrixMode(GL_MODELVIEW);
    glPushMatrix;
    glLoadIdentity;
    glTranslate(x,y,z);
    glRotate(angle,0,0,1);
    if DrawRealObjects then
      glScale(scale,scale,scale);

    if DrawRealObjects and DrawModel(n) then begin
      glPopMatrix;
      exit
    end;

    if (n<-256) or (n>=4096) then begin
      Str(n,s);
      ConsoleFrame.WriteMessage('Invalid object: '+s);
      exit
    end;
    n := ObjWrap[n];
{    ca := cos(angle/180*pi);
    sa := sin(angle/180*pi);}
    glBegin(GL_TRIANGLES);
    for i := 0 to length(MapObj[n])-1 do
      for j := 0 to 2 do begin
{        x1 := MapObj[n][i].vert[j].p[0];
        y1 := MapObj[n][i].vert[j].p[1];}
        glColor3ub(MapObj[n][i].vert[j].c[0],
                   MapObj[n][i].vert[j].c[1],
                   MapObj[n][i].vert[j].c[2]);
        glVertex3f(MapObj[n][i].vert[j].p[0],MapObj[n][i].vert[j].p[1],MapObj[n][i].vert[j].p[2]);
{        glVertex3f(x1*ca-y1*sa+x,
                   y1*ca+x1*sa+y,
                   MapObj[n][i].vert[j].p[2]+z);}
      end;
    glEnd;

    glPopMatrix;
  end;


procedure TForm2.Draww;
var
  x,y,i,j,k :integer;
  b :byte;
  vx,vy,vz,vl,px,py,pz,pangx,pscale :GLfloat;
  domepos :array[0..32,0..8,0..2] of GLFloat;
  domelight :array[0..32,0..8,0..2] of byte;
  stripactive :boolean;
  node,leaf :tTreeHandle;
  vertices :array of array[0..3] of single;
  triangles :array of integer;
  terrainxtexplane,terrainytexplane,terrainztexplane,terrainnegxtexplane :TGLArrayf4;
  splineids :array[0..511] of array of TGLArrayF3;

begin
  if not isready then exit;
  if not map.isopen then exit;


{    glDisable(GL_FRONT);
    glEnable(GL_BACK);
    glPolygonMode(GL_FRONT, GL_CLEAR);
    glFrontFace(GL_CW);}


//  glEnable(GL_POLYGON_OFFSET_LINE);
//  glPolygonOffset(1,lineoffset);

  glClear(GL_DEPTH_BUFFER_BIT or GL_COLOR_BUFFER_BIT);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;

  gluPerspective(fov, Panel1.Width/Panel1.Height,40,domerad*4    );
  gluLookAt(eye[0],eye[1],eye[2],eye[0]+view[0],eye[1]+view[1],eye[2]+view[2],0,0,1);
//  glBindTexture(GL_TEXTURE_2D, texture[0]);
  glEnable(GL_FRONT);
  glDisable(GL_BACK);
  glBlendFunc(GL_SRC_ALPHA,GL_ONE);
  glEnable(GL_DEPTH_TEST);
  glDisable(GL_BLEND);
  glDisable(GL_TEXTURE_2D);



    // draw sea ground

  if DrawDome.checked then begin
    glBegin(GL_TRIANGLES);
    glColor3ub(seagroundcolor and $FF,
               seagroundcolor shr 8 and $FF,
               seagroundcolor shr 16 and $FF);
    for x := 0 to 31 do begin
      glVertex3f(0,0,seaground);
      glVertex3f(cos(x*pi/16)*domerad,sin(x*pi/16)*domerad,seaground);
      glVertex3f(cos((x+1)*pi/16)*domerad,sin((x+1)*pi/16)*domerad,seaground);
    end;

    // calculate dome

    for y := 0 to 8 do
      for x := 0 to 32 do begin
        domepos[x,y,0] := cos((x+y/2)*pi/16)*cos(y*pi/16);
        domepos[x,y,1] := sin((x+y/2)*pi/16)*cos(y*pi/16);
        domepos[x,y,2] :=                    sin(y*pi/16);

        domelight[x,y,0] := round((domepos[x,y,0]*domegradamt                                  +(1-domegradamt))*(domecolor and $FF));
        domelight[x,y,1] := round((-domepos[x,y,0]*domegradamt/2+domepos[x,y,1]*domegradamt*0.7+(1-domegradamt))*(domecolor shr 8 and $FF));
        domelight[x,y,2] := round((-domepos[x,y,0]*domegradamt/8-domepos[x,y,1]*domegradamt*0.7+(1-domegradamt))*(domecolor shr 16 and $FF));
        for i := 0 to 2 do
          domepos[x,y,i] := domepos[x,y,i]*domerad;
      end;

    for y := 0 to 7 do
      for x := 0 to 31 do begin
        glColor3ubv(PGLubyte(@domelight[x,y,0]));
        glVertex3fv(PGLFloat(@domepos[x,y,0]));
        glColor3ubv(PGLubyte(@domelight[x+1,y,0]));
        glVertex3fv(PGLFloat(@domepos[x+1,y,0]));
        glColor3ubv(PGLubyte(@domelight[x,y+1,0]));
        glVertex3fv(PGLFloat(@domepos[x,y+1,0]));
        if y<7 then begin
          glColor3ubv(PGLubyte(@domelight[x+1,y+1,0]));
          glVertex3fv(PGLFloat(@domepos[x+1,y+1,0]));
          glColor3ubv(PGLubyte(@domelight[x+1,y,0]));
          glVertex3fv(PGLFloat(@domepos[x+1,y,0]));
          glColor3ubv(PGLubyte(@domelight[x,y+1,0]));
          glVertex3fv(PGLFloat(@domepos[x,y+1,0]));
        end
      end;
    glEnd;
  end;

     glNormal3f(0,0,1);



    SetLength(vertices,terrain.xl*terrain.yl);

    for y := 0 to terrain.yl-1 do
      for x := 0 to terrain.xl-1 do begin
        vertices[y*terrain.xl+x][0] := x*terrain.stretch+terrain.xoffset;
        vertices[y*terrain.xl+x][1] := y*terrain.stretch+terrain.yoffset;
        vertices[y*terrain.xl+x][2] := terrain.height[y*terrain.xl+x];
        vertices[y*terrain.xl+x][3] := 1;
      end;

    SetLength(triangles,length(vertices)*6);
    i := 0;
    for y := 0 to terrain.yl-2 do begin
      for x := 0 to terrain.xl-2 do begin
        b := terrain.triangle[y*terrain.xl+x] and 7;
        if (b=4) or (b=5) or (b=7) then begin
          triangles[i] := (y+1)*terrain.xl+x; inc(i);
          triangles[i] := y*terrain.xl+x; inc(i);
          triangles[i] := (y+1)*terrain.xl+(x+1); inc(i);
        end;
        if (b=5) or (b=3) then begin
          triangles[i] := y*terrain.xl+(x+1); inc(i);
          triangles[i] := y*terrain.xl+x; inc(i);
          triangles[i] := (y+1)*terrain.xl+(x+1); inc(i);
        end;
      end;
    end;
    j := i;
    for y := 0 to terrain.yl-2 do begin
      for x := 0 to terrain.xl-2 do begin
        b := terrain.triangle[y*terrain.xl+x] and 7;
        if (b=1) or (b=6) then begin
          triangles[i] := (y+1)*terrain.xl+x; inc(i);
          triangles[i] := y*terrain.xl+x; inc(i);
          triangles[i] := y*terrain.xl+(x+1); inc(i);
        end;
        if (b=2) or (b=6) then begin
          triangles[i] := y*terrain.xl+(x+1); inc(i);
          triangles[i] := (y+1)*terrain.xl+x; inc(i);
          triangles[i] := (y+1)*terrain.xl+(x+1); inc(i);
        end;
      end;
    end;
    SetLength(triangles,i);


    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
    glVertexPointer(4,GL_FLOAT,0,@vertices[0]);
    glColorPointer(4,GL_UNSIGNED_BYTE,0,@terrain.light[0]);
    glDrawElements(GL_TRIANGLES,length(triangles),GL_UNSIGNED_INT,@triangles[0]);
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_VERTEX_ARRAY);



{    glBegin(GL_TRIANGLES);


    for y := 0 to terrain.yl-2 do begin
      for x := 0 to terrain.xl-2 do begin
        b := terrain.triangle[y*terrain.xl+x] and 7;

        if (b=4) or (b=5) or (b=7) then begin
          glColor3ubv(PGLubyte(@terrain.light[(y+1)*terrain.xl+x,0]));
          glVertex3f(x*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+x]);
          glColor3ubv(PGLubyte(@terrain.light[y*terrain.xl+x,0]));
          glVertex3f(x*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+x]);
          glColor3ubv(PGLubyte(@terrain.light[(y+1)*terrain.xl+(x+1),0]));
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+(x+1)]);
        end;

        if (b=5) or (b=3) then begin
          glColor3ubv(PGLubyte(@terrain.light[y*terrain.xl+(x+1),0]));
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+(x+1)]);
          glColor3ubv(PGLubyte(@terrain.light[y*terrain.xl+x,0]));
          glVertex3f(x*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+x]);
          glColor3ubv(PGLubyte(@terrain.light[(y+1)*terrain.xl+(x+1),0]));
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+(x+1)]);
        end;

        if (b=1) or (b=6) then begin
          glColor3ubv(PGLubyte(@terrain.light[(y+1)*terrain.xl+x,0]));
          glVertex3f(x*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+x]);
          glColor3ubv(PGLubyte(@terrain.light[y*terrain.xl+x,0]));
          glVertex3f(x*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+x]);
          glColor3ubv(PGLubyte(@terrain.light[y*terrain.xl+(x+1),0]));
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+(x+1)]);
        end;

        if (b=2) or (b=6) then begin
          glColor3ubv(PGLubyte(@terrain.light[y*terrain.xl+(x+1),0]));
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+(x+1)]);
          glColor3ubv(PGLubyte(@terrain.light[(y+1)*terrain.xl+x,0]));
          glVertex3f(x*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+x]);
          glColor3ubv(PGLubyte(@terrain.light[(y+1)*terrain.xl+(x+1),0]));
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+(x+1)]);
        end;
      end;
    end;

    glEnd;}

  if ViewTerrainMesh1.Checked then begin

    for i := 0 to 3 do begin
      terrainxtexplane[i] := 0;
      terrainytexplane[i] := 0;
      terrainztexplane[i] := 0;
      terrainnegxtexplane[i] := 0;
    end;

    terrainxtexplane[0] := 1/terrain.stretch;
    terrainytexplane[1] := 1/terrain.stretch;
    terrainnegxtexplane[0] := -1/terrain.stretch;

    terrainxtexplane[3] := -terrain.xoffset/terrain.stretch;
    terrainytexplane[3] := -terrain.yoffset/terrain.stretch;
    terrainnegxtexplane[3] := terrain.xoffset/terrain.stretch;

    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    glEnable(GL_TEXTURE_2D);
    glColor4ub(255,255,255,255);
    glBindTexture(GL_TEXTURE_2D,MeshTexture);

    glEnableClientState(GL_VERTEX_ARRAY);
    glVertexPointer(4,GL_FLOAT,0,@vertices[0]);


    GLTexGenfv(GL_S,GL_OBJECT_PLANE,@terrainxtexplane);
    GLTexGeni(GL_S,GL_Texture_Gen_Mode,GL_OBJECT_LINEAR);
    glEnable(GL_TEXTURE_GEN_S);
    GLTexGenfv(GL_T,GL_OBJECT_PLANE,@terrainytexplane);
    GLTexGeni(GL_T,GL_Texture_Gen_Mode,GL_OBJECT_LINEAR);
    glEnable(GL_TEXTURE_GEN_T);

    glDrawElements(GL_TRIANGLES,j,GL_UNSIGNED_INT,@triangles[0]);

    GLTexGenfv(GL_S,GL_OBJECT_PLANE,@terrainnegxtexplane);
    GLTexGeni(GL_S,GL_Texture_Gen_Mode,GL_OBJECT_LINEAR);

    glDrawElements(GL_TRIANGLES,length(triangles)-j,GL_UNSIGNED_INT,@triangles[j]);

    glDisable(GL_TEXTURE_GEN_S);
    glDisable(GL_TEXTURE_GEN_T);

    glDisableClientState(GL_VERTEX_ARRAY);

{    glBegin(GL_TRIANGLES);

    for y := 0 to terrain.yl-2 do begin
      for x := 0 to terrain.xl-2 do begin
        (*vx := terrain[x,y]-terrain[x+1,y];
        vy := terrain[x,y]-terrain[x,y+1];
        vz := 1/terrainl;
        vl := sqrt(sqr(vx)+sqr(vy)+sqr(vz));
        //glNormal3f(vx/vl,vy/vl,vz/vl); *)
        b := terrain.triangle[y*terrain.xl+x] and 7;

        if (b=4) or (b=5) or (b=7) then begin
          glTexCoord2f(0.0, 1.0);
          glVertex3f(x*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+x]);
          glTexCoord2f(0.0, 0.0);
          glVertex3f(x*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+x]);
          glTexCoord2f(1.0, 1.0);
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+(x+1)]);
        end;

        if (b=5) or (b=3) then begin
          glTexCoord2f(1.0, 0.0);
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+(x+1)]);
          glTexCoord2f(0.0, 0.0);
          glVertex3f(x*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+x]);
          glTexCoord2f(1.0, 1.0);
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+(x+1)]);
        end;

        if (b=1) or (b=6) then begin
          glTexCoord2f(0.0, 0.0);
          glVertex3f(x*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+x]);
          glTexCoord2f(1.0, 0.0);
          glVertex3f(x*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+x]);
          glTexCoord2f(1.0, 1.0);
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+(x+1)]);
        end;

        if (b=2) or (b=6) then begin
          glTexCoord2f(1.0, 1.0);
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+(x+1)]);
          glTexCoord2f(0.0, 0.0);
          glVertex3f(x*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+x]);
          glTexCoord2f(0.0, 1.0);
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+(x+1)]);
        end;
      end;
    end;

    glEnd;}

    glDisable(GL_BLEND);
    glDisable(GL_TEXTURE_2D);

  end;

 { if ViewTerrainMesh1.Checked then begin
    glColor4ub(255,255,255,255);
    glDisable(GL_BLEND);
    glDisable(GL_DEPTH_TEST);
    glBegin(GL_LINES);
    for y := 0 to terrain.yl-1 do
      for x := 0 to terrain.xl-2 do
        if (terrain.getTriangle(x,y) and 7 in [1,3,5,6])
        or (terrain.getTriangle(x,y-1) and 7 in [2,4,5,6,7]) then begin
          glVertex3f(x*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+x]);
          glVertex3f((x+1)*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+(x+1)]);
        end;
    for x := 0 to terrain.xl-1 do
      for y := 0 to terrain.yl-2 do
        if (terrain.getTriangle(x,y) and 7 in [1,4,5,6,7])
        or (terrain.getTriangle(x-1,y) and 7 in [2,3,5,6]) then begin
          glVertex3f(x*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+x]);
          glVertex3f(x*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+x]);
        end;
    for x := 0 to terrain.xl-2 do
      for y := 0 to terrain.yl-2 do
        if (terrain.getTriangle(x,y) and 7 <> 0) then
          if (terrain.getTriangle(x,y) and 7 in [3,4,5,7]) then begin
            glVertex3f(x*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+x]);
            glVertex3f((x+1)*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+(x+1)]);
          end
          else begin
            glVertex3f((x+1)*terrain.stretch+terrain.xoffset,y*terrain.stretch+terrain.yoffset,terrain.height[y*terrain.xl+(x+1)]);
            glVertex3f(x*terrain.stretch+terrain.xoffset,(y+1)*terrain.stretch+terrain.yoffset,terrain.height[(y+1)*terrain.xl+x]);
          end;
    glEnd;
    glEnable(GL_DEPTH_TEST);
  end;}


  glEnable(GL_CULL_FACE);
  glPolygonMode(GL_FRONT, GL_FILL);
  glPolygonMode(GL_BACK, GL_CLEAR);

  if (drawwobjects or drawwmobjects) then begin
    if (viewobjectsthroughterrain1.checked) then
      glDisable(GL_DEPTH_TEST);
    if (wrapper<>nil) and wrapper.Tree.HasChildNode('<Objects>') then begin
      node := wrapper.Tree.GetChildNode('<Objects>');
      node.SearchInitNode;
      while node.SearchNextNode do begin
        leaf := node;
        leaf.ScanInitLeaf;
        leaf.ScanLeaf('Type');
        i := leaf.getInt32;
        if (i=1052) or (i=1162) then begin
          if i=1052 then
            i := 0
          else if i=1162 then
            i := 256;
          if leaf.ScanLeaf('AIMode') then
            i := i+leaf.getByte;
          if leaf.ScanLeaf('TeamID') then
            j := leaf.getInt32
          else
            j := 0;
          k := length(splineids[i]);
          if k<=j then begin
            SetLength(splineids[i],j+1);
            while k<j do begin
              splineids[i,k,0] := Math.NaN;
              splineids[i,k,1] := Math.NaN;
              splineids[i,k,2] := Math.NaN;
              inc(k)
            end;
          end;
          leaf.ScanLeaf('X'); splineids[i,j,0] := leaf.getSingle;
          leaf.ScanLeaf('Y'); splineids[i,j,1] := leaf.getSingle;
          leaf.ScanLeaf('Z'); splineids[i,j,2] := leaf.getSingle;
          leaf.ScanDoneNoHint;
        end;
      end;
    end;
    if (wmwrapper<>nil) and wmwrapper.Tree.HasChildNode('<Objects>') then begin
      node := wmwrapper.Tree.GetChildNode('<Objects>');
      node.SearchInitNode;
      while node.SearchNextNode do begin
        leaf := node;
        leaf.ScanInitLeaf;
        leaf.ScanLeaf('Type');
        i := leaf.getInt32;
        if (i=1052) or (i=1162) then begin
          if i=1052 then
            i := 0
          else if i=1162 then
            i := 256;
          if leaf.ScanLeaf('AIMode') then
            i := i+leaf.getByte;
          if leaf.ScanLeaf('TeamID') then
            j := leaf.getInt32
          else
            j := 0;
          k := length(splineids[i]);
          if k<=j then begin
            SetLength(splineids[i],j+1);
            while k<j do begin
              splineids[i,k,0] := Math.NaN;
              splineids[i,k,1] := Math.NaN;
              splineids[i,k,2] := Math.NaN;
              inc(k)
            end;
          end;
          leaf.ScanLeaf('X'); splineids[i,j,0] := leaf.getSingle;
          leaf.ScanLeaf('Y'); splineids[i,j,1] := leaf.getSingle;
          leaf.ScanLeaf('Z'); splineids[i,j,2] := leaf.getSingle;
          leaf.ScanDoneNoHint;
        end;
      end;
    end;
    glBegin(GL_LINES);
    glColor4ub(255,255,255,255);
    for i := 0 to 255 do
      for j := 0 to length(splineids[i])-2 do if not Math.IsNan(splineids[i,j,0]) and not Math.IsNan(splineids[i,j+1,0]) then begin
        glVertex3f(splineids[i,j,0],splineids[i,j,1],splineids[i,j,2]);
        glVertex3f(splineids[i,j+1,0],splineids[i,j+1,1],splineids[i,j+1,2]);
      end;
    glColor4ub(255,192,128,255);
    for i := 256 to 511 do
      for j := 0 to length(splineids[i])-2 do if not Math.IsNan(splineids[i,j,0]) and not Math.IsNan(splineids[i,j+1,0]) then begin
        glVertex3f(splineids[i,j,0],splineids[i,j,1],splineids[i,j,2]);
        glVertex3f(splineids[i,j+1,0],splineids[i,j+1,1],splineids[i,j+1,2]);
      end;
    glEnd;
    glEnable(GL_DEPTH_TEST);
  end;

  if (wrapper<>nil) and (drawwobjects) then begin
    if ViewObjectsThroughTerrain1.Checked then
      glDisable(GL_DEPTH_TEST);
    glColor4ub(0,128,255,0);
    if wrapper.Tree.HasChildNode('<Objects>') then begin
      node := wrapper.Tree.GetChildNode('<Objects>');
      node.SearchInitNode;
      while node.SearchNextNode do begin
        leaf := node;
        j := -1;
        i := 0;
        px := 0;
        py := 0;
        pz := 0;
        pangx := 0;
        pscale := 1;
        leaf.ScanInitLeaf;
        if leaf.ScanLeaf('Type') then
          i := leaf.getInt32;
        if leaf.ScanLeaf('X') then
          px := leaf.getSingle;
        if leaf.ScanLeaf('Y') then
          py := leaf.getSingle;
        if leaf.ScanLeaf('Z') then
          pz := leaf.getSingle;
        if leaf.ScanLeaf('Angle') then
          pangx := leaf.getSingle;
        if leaf.ScanLeaf('Angle X') then
          pangx := leaf.getSingle;
        if leaf.ScanLeaf('AIMode') then
          j := leaf.getByte;
        if leaf.ScanLeaf('Scale') then
          pscale := leaf.getSingle;
        leaf.ScanDoneNoHint;
        if i=679 then begin
          case j of
            1:i := -1;
            2:i := -2;
            3:i := -3;
            4:i := -4;
            27:i := -5;
            22:i := -6;
            23:i := -7;
          end
        end;
        DrawObject(px,py,pz,pangx,pscale,i);
      end;
    end;
    if ViewObjectsThroughTerrain1.Checked then
      glEnable(GL_DEPTH_TEST);
  end;

  if (wmwrapper<>nil) and (drawwmobjects) then begin
    if ViewObjectsThroughTerrain1.Checked then
      glDisable(GL_DEPTH_TEST);
    glColor4ub(0,128,255,0);
    node := wmwrapper.Tree;
    node.SearchInitNode;
    while node.SearchNextNode do
      if node.getName='<Objects>' then
        break;
    if node.getName='<Objects>' then begin
      node.SearchInitNode;
      while node.SearchNextNode do begin
        leaf := node;
        j := -1;
        i := 0;
        px := 0;
        py := 0;
        pz := 0;
        pangx := 0;
        pscale := 1;
        leaf.ScanInitLeaf;
        if leaf.ScanLeaf('Type') then
          i := leaf.getInt32;
        if leaf.ScanLeaf('X') then
          px := leaf.getSingle;
        if leaf.ScanLeaf('Y') then
          py := leaf.getSingle;
        if leaf.ScanLeaf('Z') then
          pz := leaf.getSingle;
        if leaf.ScanLeaf('Angle') then
          pangx := leaf.getSingle;
        if leaf.ScanLeaf('Angle X') then
          pangx := leaf.getSingle;
        if leaf.ScanLeaf('AIMode') then
          j := leaf.getByte;
        if leaf.ScanLeaf('Scale') then
          pscale := leaf.getSingle;
        leaf.ScanDoneNoHint;
        if i=679 then begin
          case j of
            1:i := -1;
            2:i := -2;
            3:i := -3;
            4:i := -4;
            27:i := -5;
            22:i := -6;
            23:i := -7;
          end
        end;
        DrawObject(px,py,pz,pangx,pscale,i);
      end;
    end;

    if ViewObjectsThroughTerrain1.Checked then
      glEnable(GL_DEPTH_TEST);
  end;

  glDisable(GL_TEXTURE_2D);
(*    if ShowABX then begin
      glEnable(GL_BLEND);
      glDisable(GL_DEPTH_TEST);
      glColor4ub(1,8,64,255);
      for i := 0 to length(ABXEntry.boxes)-1 do if (ABXDrawWhat=-1) or (ABXDrawWhat=i) then with ABXEntry.boxes[i] do
        DrawBox(p1[0],p1[1],p1[2],p2[0],p2[1],p2[2]);
    end;*)


  glDisable(GL_CULL_FACE);


  if DrawDome.checked then begin

    // draw sea

    glEnable(GL_BLEND);
    glBlendFunc(GL_ONE,GL_ONE);
    glBegin(GL_TRIANGLES);
    glColor4ub(seacolor and $FF,
               seacolor shr 8 and $FF,
               seacolor shr 16 and $FF,255);
    for x := 0 to 31 do begin
      glVertex3f(0,0,0);
      glVertex3f(cos(x*pi/16)*domerad,sin(x*pi/16)*domerad,0);
      glVertex3f(cos((x+1)*pi/16)*domerad,sin((x+1)*pi/16)*domerad,0);
    end;
    glEnd;
  end;


  glFlush;
  SwapBuffers(PanelDC);
  time := time+5.0;
end;

procedure TForm2.FormResize(Sender: TObject);
begin
  glViewPort(0,0,Panel1.Width,Panel1.Height);
//  glDisable(gl_scissor_bit);
  glLoadIdentity;
  Draww;
end;

{$R *.dfm}

procedure TForm2.Splitter1Moved(Sender: TObject);
begin
(*
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  gluPerspective(00.0,Panel1.Width/Panel1.Height,0.01,100.0);
  glViewPort(Panel1.Top,Panel1.Left,Panel1.Width,Panel1.Height);
//  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;//InvalidateRect(Handle,nil,false);*)
  FormResize(Sender);
end;

function SkalProd(v1,v2 :TGLArrayf3):GLfloat; overload;
  begin
    SkalProd := v1[0]*v2[0]+v1[1]*v2[1]+v1[2]*v2[2];
  end;

function SkalProd(v2 :GLFloat;v1 :TGLArrayf3):TGLArrayf3; overload;
  begin
    v1[0] := v1[0]*v2;
    v1[1] := v1[1]*v2;
    v1[2] := v1[2]*v2;
    SkalProd := v1;
  end;

function SkalProd(v1 :TGLArrayf3;v2 :GLFloat):TGLArrayf3; overload;
  begin
    v1[0] := v1[0]*v2;
    v1[1] := v1[1]*v2;
    v1[2] := v1[2]*v2;
    SkalProd := v1;
  end;

function VectProd(v1,v2 :TGLArrayf3):TGLArrayf3;
  var
    v3 :TGLArrayf3;
  begin
    v3[0] := v1[1]*v2[2]-v1[2]*v2[1];
    v3[1] := v1[2]*v2[0]-v1[0]*v2[2];
    v3[2] := v1[0]*v2[1]-v1[1]*v2[0];
    VectProd := v3;
  end;

function VectAdd(v1,v2 :TGLArrayf3):TGLArrayf3; overload;
  var
    i :integer;
  begin
    for i := 0 to 2 do
      v1[i] := v1[i]+v2[i];
    VectAdd := v1;
  end;

function VectAdd(v1 :TGLArrayf3;s1 :GLFloat;v2 :TGLArrayf3;s2 :GLFloat):TGLArrayf3; overload;
  var
    i :integer;
  begin
    for i := 0 to 2 do
      v1[i] := v1[i]*s1+v2[i]*s2;
    VectAdd := v1;
  end;

function VectNorm(v1 :TGLArrayf3):TGLArrayf3;
  var
    s :GLFloat;
  begin
    s := sqrt(sqr(v1[0])+sqr(v1[1])+sqr(v1[2]));
    if s<>0 then
      s := 1/s;
    VectNorm := SkalProd(v1,s);
  end;

function VectRotZ(v1 :TGLArrayf3; angle :GLFloat):TGLArrayf3;
  var
    v2 :TGLArrayf3;
  begin
    v2[0] := v1[0]*cos(angle)-v1[1]*sin(angle);
    v2[1] := v1[1]*cos(angle)+v1[0]*sin(angle);
    v2[2] := v1[2];
    VectRotZ := v2;
  end;

procedure TForm2.FlyAround(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  new_up,new_view :TGLArrayf3;
  amx,amy,r :GLFloat;
  movestate :integer;

begin
  movestate := 0;
  if (ssLeft in Shift) then
    if (ssLeft in OldShift) then
      movestate := movestate or 1
    else
      movestate := movestate or 255
  else
    if (ssLeft in OldShift) then
      movestate := movestate or 255;

  if (ssRight in Shift) then
    if (ssRight in OldShift) then
      movestate := movestate or 2
    else
      movestate := movestate or 255
  else
    if (ssRight in OldShift) then
      movestate := movestate or 255;

  if movestate = 1 then begin
    amx := -(x-oldmx)/100;
    amy :=  (y-oldmy)/100;
    view := vectrotz(view,amx);
    right := vectrotz(right,amx);
    up := vectrotz(up,amx);
    new_view  := VectAdd(view,cos(amy),up,-sin(amy));
    new_up := VectAdd(view,sin(amy),up,cos(amy));
    if new_up[2]>0 then begin
      view := new_view;
      up := new_up;
    end;

  end;
  if movestate = 2 then begin
    amx := (x-oldmx)*30;
    amy := (y-oldmy)*30;
    eye := VectAdd(eye,1,right,-amx);
    eye := VectAdd(eye,1,up,-amy);
  end;
  if movestate = 3 then begin
//    amx := (x-oldmx)*30;
    amy := (y-oldmy)*30;
    eye := VectAdd(eye,1,view,-amy);
  end;
  OldShift := Shift;
  OldMX := x;
  OldMY := y;
  if DrawDome.Checked then begin
    if eye[2]<0 then eye[2] := 0;
    r := sqr(eye[0])+sqr(eye[1])+sqr(eye[2]);
    if r>sqr(domerad*0.8) then begin
      r := domerad*0.8/sqrt(r);
      eye := SkalProd(eye,r);
    end;
  end;
  Draww;
end;

procedure TForm2.Splitter2Moved(Sender: TObject);
begin
  FormResize(Sender);
end;

function StringOfInteger(i :integer):string;
  var
    s :string;
  begin
    Str(i,s);
    StringOfInteger := s
  end;

function StringOfSingle(r :single):string;
  var
    s :string;
  begin
    Str(r,s);
    StringOfSingle := s
  end;

procedure TForm2.UpdateTerrainHeader;
  begin
    gtieditor.Clear;


    gtieditor.AddLongint('Signature',terrainheader.signature);
    gtieditor.AddLongint('unknown',terrainheader.u0);
//    gtieditor.AddSingle('x offset',terrainheader.xoffset);
//    gtieditor.AddSingle('y offset',terrainheader.yoffset);
//    gtieditor.AddSingle('minimum height',terrainheader.minheight);
//    gtieditor.AddSingle('maximum height',terrainheader.maxheight);
//    gtieditor.AddLongint('x length (vertex cols)',terrainheader.xl);
//    gtieditor.AddLongint('y length (vertex rows)',terrainheader.yl);
//    gtieditor.AddSingle('horizontal stretching',terrainheader.stretch);
    gtieditor.AddSingle('unknown',terrainheader.u1);
    gtieditor.AddSingle('unknown',terrainheader.u2);
    gtieditor.AddSingle('unknown',terrainheader.u3);
    gtieditor.AddSingle('unknown',terrainheader.u4);
    gtieditor.AddLongint('unknown',terrainheader.version);
    gtieditor.AddLongint('unknown',terrainheader.u6);
    gtieditor.AddSingle('unknown',terrainheader.u7);
    gtieditor.AddSingle('unknown',terrainheader.u8);
//    editor.AddFixedString('unknown',terrainheader.texture);
  end;

function filematches(filename :string; mask :string):boolean;
  var
    i,j :integer;
  begin
    for i := 1 to length(filename) do
      filename[i] := upcase(filename[i]);
    j := 0;
    for i := 1 to length(mask) do begin
      mask[i] := upcase(mask[i]);
      if mask[i]='*' then
        inc(j)
    end;
    if j=0 then begin
      filematches := filename=mask;
      exit
    end;


    filematches := false;
    for i := 1 to min(length(mask),length(filename)) do
      if mask[i]='*' then
        break
      else
        if mask[i]<>filename[i] then
          exit;
    for i := 0 to min(length(mask),length(filename))-1 do
      if mask[length(mask)-i]='*' then
        break
      else
        if mask[length(mask)-i]<>filename[length(filename)-i] then
          exit;
    filematches := true;
  end;

procedure TForm2.Open1Click(Sender: TObject);
  type
    CharList = array[0..maxlongint-1] of char;
  var
    i,j,k,l,code :longint;
    s,s2,s3 :string;
    filename :string;
    zs :TZipStream;
    data :array of byte;
    f :file;
  begin
    if map.isopen then
      case Application.MessageBox('Save map before closing?','Question',MB_YESNOCANCEL) of
        IDYES:if not Savemap then exit;
        IDCANCEL:exit
      end;
    mapclose;
    NewOpenMapDialog.Title := 'Open a map...';
    NewOpenMapDialog.FilterIndex := 1;
    if not NewOpenMapDialog.Execute then
      exit;
    s := NewOpenMapDialog.FileName;
    filename := s;

    if filematches(s,'*.zip') then begin
      if Application.MessageBox('This map format is no longer supported. Convert?','Question',MB_YESNO)=IDNO then
        exit;
      AssignFile(f,s);
      {$I-}
      Rename(f,copy(s,1,length(s)-4)+'.gck');
      i := IOResult;
      if i<>0 then begin
        Str(i,s);
        Application.MessageBox(PChar('Could not rename file. Error code: '+s),'Error');
        exit
      end;
      s := copy(s,1,length(s)-4)+'.gck';
      ZipMaster1.ZipFileName := s;
    end;

    if not FileExists(s) then begin
      Application.MessageBox('Map does not exist.','Error',MB_OK);
      exit;
    end;

    ZipMaster1.ZipFileName := s;
    Str(ZipMaster1.ErrCode,s);
    if verbose then ConsoleFrame.WriteMessage(s);

    if ZipMaster1.ZipFileName='' then begin
      Application.MessageBox('This is not a valid map file.'#13#13'If you want to open maps created with previous versions create'#13'a new map instead and import bin and gti file manually','Error');
      exit
    end;

    ZipMaster1.Load_Unz_Dll;
    Str(ZipMaster1.ErrCode,s);
    if verbose then ConsoleFrame.WriteMessage(s);

    if verbose then ConsoleFrame.WriteMessage('This map contains the following files:');
    mapopen;
    map.wbinname := '';
    map.gtiname := '';
    map.gmmname := '';
    map.shareable := false;
    map.usermessage := '';
    map.maptype := -1;

    lasterror := 'Indexing zip content';

    for i := 0 to ZipMaster1.ZipContents.Count-1 do begin
      s := ZipDirEntry(ZipMaster1.ZipContents.Items[i]^).FileName;
      Str(ZipMaster1.ErrCode,s2);
      if verbose then ConsoleFrame.WriteMessage(s2);
      if filematches(s,'*.gmm') then begin
        if map.gmmname<>'' then begin
          ConsoleFrame.WriteMessage('Error: can''t load'+s+'because slot is in use');
          continue
        end;
        map.gmmname := s;
        if verbose then ConsoleFrame.WriteMessage(s+'   ...info file');
      end
      else if filematches(s,'w_*.bin') then begin
        if map.wbinname<>'' then begin
          ConsoleFrame.WriteMessage('Error: can''t load'+s+'because slot is in use');
          continue
        end;
        map.wbinname := s;
        if verbose then ConsoleFrame.WriteMessage(s+'   ...map objects file');
      end
      else if filematches(s,'*.gti') then begin
        if map.gtiname<>'' then begin
          ConsoleFrame.WriteMessage('Error: can''t load'+s+'because slot is in use');
          continue
        end;
        map.gtiname := s;
        if verbose then ConsoleFrame.WriteMessage(s+'   ...terrain file');
      end
      else if filematches(s,'*.abx') then begin
        // ignore
        if verbose then ConsoleFrame.WriteMessage(s+'   ...bounding boxes... ignored');
      end
      else begin
        if verbose then ConsoleFrame.WriteMessage(s+'   ...no loader found, loading into buffer');
        zs := ZipMaster1.ExtractFileToStream(map.gmmname);
        if zs<>nil then begin
          l := length(map.otherfilenames);
          SetLength(map.otherfilenames,l+1);
          SetLength(map.otherfiles,l+1);
          map.otherfilenames[l] := s;
          SetLength(map.otherfiles[l],zs.size);
          Move(zs.Memory^,map.otherfiles[l][0],length(map.otherfiles[l]));
        end;
      end
    end;

    // read gmm file

    lasterror := 'Reading GMM file';

    zs := nil;
    if map.gmmname<>'' then begin
      zs := ZipMaster1.ExtractFileToStream(map.gmmname);
      if zs=nil then
        map.gmmname := ''
      else begin
        SetLength(data,zs.size);
        Move(zs.Memory^,data[0],length(data));
      end;
    end;

    if map.gmmname='' then begin
      s := ZipMaster1.ZipFileName;
      if (length(s)>4) and (s[length(s)-3]='.') and FileExists(copy(s,1,length(s)-3)+'gmm') then
        if Application.MessageBox('No GMM file found in GCK file.'#13'However there''s an external gmm file.'#13'Is it okay to load that one?','Error',MB_YESNO)=IDYES then begin
          AssignFile(f,copy(s,1,length(s)-3)+'gmm');
          Reset(f,1);
          SetLength(data,filesize(f));
          BlockRead(f,data[0],length(data));
          CloseFile(f);
          map.gmmname := 'default.gmm';
        end;
    end;

    if map.gmmname<>'' then begin
      s := '';  // error
      if verbose then ConsoleFrame.WriteMessage(s+'Decoding GMM file...');
      for i := 0 to length(data) do
        if (i=length(data)) or (char(data[i])<#32) then begin
          s := trim(s);
          if s='' then continue;
          j := 1;
          while (j<=length(s)) and (s[j]<>'=') do
            inc(j);
          s2 := copy(s,1,j-1);
          s3 := copy(s,j+1,length(s)-j);
          for j := 1 to length(s2) do s2[j] := upcase(s2[j]);
          if s2='MODINFO_USERMESSAGE' then begin
            map.usermessage := s3;
          end
          else if s2='MODINFO_SHAREABLE' then begin
            map.shareable := true;
          end
          else if s2='MODINFO_MECC' then begin
            if map.wbinname='' then
              map.wbinname := s3
            else
              if not filematches(map.wbinname,s3) then
                ConsoleFrame.WriteMessage('Error: a name in .gmm file does not match');
            map.maptype := $0D;
          end
          else if s2='MODINFO_REAPER' then begin
            if map.wbinname='' then
              map.wbinname := s3
            else
              if not filematches(map.wbinname,s3) then
                ConsoleFrame.WriteMessage('Error: a name in .gmm file does not match');
            map.maptype := $0B;
          end
          else if s2='MODINFO_3WAY' then begin
            if map.wbinname='' then
              map.wbinname := s3
            else
              if not filematches(map.wbinname,s3) then
                ConsoleFrame.WriteMessage('Error: a name in .gmm file does not match');
            map.maptype := $31
          end
          else if s2='MODINFO_BINNAME' then begin
            if map.wbinname='' then
              map.wbinname := s3
            else
              if not filematches(map.wbinname,s3) then
                ConsoleFrame.WriteMessage('Error: a name in .gmm file does not match');
          end
          else if s2='MODINFO_BINTYPE' then begin
            Val(s3,k,code);
            if (code=0) then
              map.maptype := k
            else
              ConsoleFrame.WriteMessage('Error: invalid number in '+s2+'='+s3);
          end
          else begin
            if verbose then ConsoleFrame.WriteMessage('Unknown command: '+s2);
            l := length(map.othertags);
            SetLength(map.othertags,l+1);
            map.othertags[l] := s;
          end;
          s := '';
        end
        else
          s := s+char(data[i]);
      SetLength(data,0);
    end
    else begin
      map.gmmname := 'default.gmm';
      Application.MessageBox('No GMM file found. Please select a map type.','Error');
      while MapNamesDlg.ShowModal<>mrOk do
        Application.MessageBox('You must select a map type!','Error');
    end;

    if (map.gtiname='') and (map.wbinname='') then begin
      Application.MessageBox('Modpack does not contain a map.','Error');
      mapclose;
      exit
    end;

    lasterror := 'Reading wbin file';

    if map.wbinname<>'' then begin
      zs := ZipMaster1.ExtractFileToStream(map.wbinname);
      if zs=nil then begin
        Application.MessageBox('Reading wbin file failed.','Error');
        map.wbinname := ''
      end
    end;
    if map.wbinname<>'' then begin
      lasterror := 'Read wbin block';
      Str(ZipMaster1.ErrCode,s2);
      if verbose then ConsoleFrame.WriteMessage(s2);
      lasterror := 'Creating data block';
      SetLength(data,zs.Size); // here this damned error occurs :( zs seems to be defective
      lasterror := 'Copying to data block';
      Move(zs.Memory^,data[0],length(data));
      lasterror := 'deleting stream';
      zs.Clear;
      lasterror := 'decoding wbin';
      if loadbinw(tByteList(data)) then begin
        wrapper := TTreeWrapper.Create(fbase,Form3.TreeView1,Form3.ScrollBox1);
      end
      else begin
        map.wbinname := '';
        wrapper := nil;
        Application.MessageBox('Loading objects failed!','Error')
      end;
    end;
    if map.wbinname='' then begin
      Application.MessageBox('Mod pack does not contain a valid objects file. That may be okay for certain maps but it''s not for GiantsEdit.'#13'Please import the appropriate map file manually.','Error')
    end;

    lasterror := 'Reading gti file';

    if map.gtiname<>'' then begin
      zs := ZipMaster1.ExtractFileToStream(map.gtiname);
      SetLength(data,zs.Size);
      Move(zs.Memory^,data[0],length(data));
      zs.Clear;
      if not decodegti(data) then
        map.gtiname := '';
    end;
    if map.gtiname='' then begin
      Application.MessageBox('Mod pack does not contain a valid terrain file. That may be okay for certain maps but it''s not for GiantsEdit.'#13'Please import the appropriate terrain manually.','Error');
      map.gtiname := 'default.gti';
      Terrain.SetSize(64,64);
      Terrain.Clear;
    end;
    ZipMaster1.ZipFileName := '';
    ZipMaster1.Unload_Unz_Dll;
    Caption := 'GiantsEdit 5.4 - '+filename;
    map.filename := filename;
  end;


function upcases(s :string):string;
  var
    i :integer;
  begin
    for i := 1 to length(s) do
      s[i] := upcase(s[i]);
    upcases := s
  end;

procedure TForm2.GZPIndexer;
  var
    gzplist :TStringList;
    reg :TRegistry;
    s :string;
    sr :TSearchRec;
    i,j,k,p :integer;
    binpath :string;
    f :file;
    header,indexheader :array[0..1] of longint;
    filename2 :array[0..255] of char;
    filename :string;
    fileindex :record
      size :longint;
      size_uncmp :longint;
      u1 :longint;
      start :longint;
      compr :byte;
      namelength :byte
    end;
    gzpbuf :tByteList;

  begin
    gzplist := TStringList.Create;
    gzplist.CaseSensitive := false;
    gzplist.Sorted := true;
    reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    s := '';
    if Reg.OpenKey('\Software\Nullpointer\GiantsEdit',true) then begin
      s := Reg.ReadString('GiantsDir');
      Reg.CloseKey;
    end;
    if (s<>'') and not FileExists(s+'giants.exe') then
      s := '';
    if s='' then begin
      if Reg.OpenKey('\Software\PlanetMoon\Giants',false) then begin
        s := Reg.ReadString('DestDir');
        Reg.CloseKey;
      end;
      if (s<>'') and not FileExists(s+'giants.exe') then begin
        s := s+'\';
        if not FileExists(s+'giants.exe') then begin
          s := copy(s,1,length(s)-1);
          while (s<>'') and (s[length(s)]<>'\') do
            s := copy(s,1,length(s)-1);
          if not FileExists(s+'giants.exe') then begin
            s := '';
          end
        end
      end;
      if s<>'' then begin
        if Reg.OpenKey('\Software\Nullpointer\GiantsEdit',true) then begin
          Reg.WriteString('GiantsDir',s);
          Reg.CloseKey;
        end;
      end;
    end;
    if s='' then begin
      repeat
        if Application.MessageBox('Your Giants folder was not found automatically.'#13#13'Press OK and locate Giants.exe in the following dialog.','Error',mb_okcancel)=idcancel then
          exit;
        if Form2.LocateGiantsExeDialog.Execute then begin
          s := Form2.LocateGiantsExeDialog.FileName;
          if not FileExists(s) or (upcases(copy(s,length(s)-9,10))<>'GIANTS.EXE') then
            s := ''
        end
      until s<>'';
      if Reg.OpenKey('\Software\Nullpointer\GiantsEdit',true) then begin
        Reg.WriteString('GiantsDir',s);
        Reg.CloseKey;
      end;
    end;

    giantsfolder := s;
    binpath := s+'bin\';

    if FindFirst(binpath+'*.gzp',$27,sr)=0 then repeat
      gzplist.Add(sr.Name)
    until FindNext(sr)<>0;
    FindClose(sr);

    SetLength(gzpentry,0);

    for i := 0 to gzplist.Count-1 do begin
      FileMode := 0;
      AssignFile(f,binpath+gzplist.Strings[i]);
      {$I-}
      Reset(f,1);
      if IOResult<>0 then begin
        s := 'Unable to open '+binpath+gzplist.Strings[i];
        Application.MessageBox(PChar(s),'Error');
        continue
      end;

      BlockRead(f,header,8,j);

      if (j<>8) or (header[0]<>$6608F101) then begin
        s := 'Error: '+binpath+gzplist.Strings[i]+' is not a valid GZP file';
        Application.MessageBox(PChar(s),'Error');
        continue
      end;
      Seek(f,header[1]);

      SetLength(gzpbuf,FileSize(f)-FilePos(f));
      BlockRead(f,gzpbuf[0],length(gzpbuf));
      CloseFile(f);

      Move(gzpbuf[0],indexheader,8);

      p := 8;

      for k := 0 to indexheader[1]-1 do begin
        Move(gzpbuf[p],fileindex,18);
        inc(p,18);
        Move(gzpbuf[p],filename2,longint(fileindex.namelength));
        inc(p,longint(fileindex.namelength));
        filename := '';
        for j := 0 to longint(fileindex.namelength)-2 do
          filename := filename+filename2[j];
        filename := upcases(filename);

        for j := 0 to length(gzpentry)-1 do
          if gzpentry[j].name=filename then begin
            filename := '';
            break
          end;

        if filename='' then
          continue;

        j := length(gzpentry);
        SetLength(gzpentry,j+1);
        gzpentry[j].name := filename;
        gzpentry[j].source := binpath+gzplist.Strings[i];
      end;
      SetLength(gzpbuf,0);
    end
  end;

function TForm2.Loadwbin(filename :string) :boolean;
  var
    s :string;
    b :array of byte;
    memfile :tMemFile;
    f :file;
  begin
    memfile := nil;
    if s='' then;
    try
      AssignFile(f,filename);
      Reset(f,1);
      SetLength(b,FileSize(f));
      BlockRead(f,b[0],Length(b));
      CloseFile(f);
      if not LoadBinW(tByteList(b)) then begin
        Loadwbin := false;
        exit
      end;
    except
      on e:Exception do Application.MessageBox(PChar(e.Message),'Error');
    end;
    map.wbinname := filename;
    Loadwbin := true;
    wrapper := TTreeWrapper.Create(fbase,Form3.TreeView1,Form3.ScrollBox1);

    if Application.MessageBox('Do you also want to load the terrain?','Question',MB_YESNO)=IDNO then
      exit;
    memfile := LoadGZPFile(fbase.getchildnode('[FileStart]').getchildleaf('GtiName').getString);
    if not DecodeGTI(memfile) then
      Application.MessageBox('Can''t open GTI file.'#13'Please note that this version of GiantsEdit can''t'#13'extract GZP files.','Error');
  end;

function TForm2.LoadGZPFile(name :string):tMemFile;
  var
    f :file;
    memfile :tMemFile;
    i :longint;
  begin
    FileMode := 0;
    AssignFile(f,giantsfolder+'bin\override\'+name);
    {$I-}
    Reset(f,1);
    if IOResult=0 then begin
    {$I+}
      SetLength(memfile,FileSize(f));
      BlockRead(f,memfile[0],FileSize(f));
      CloseFile(f);
      LoadGZPFile := memfile;
      exit
    end;

    for i := 0 to length(gzpentry)-1 do
      if upcases(name)=upcases(gzpentry[i].name) then begin
        LoadGZPFile := DecodeGZPFile(gzpentry[i].source,gzpentry[i].name);
        exit
      end;

    ConsoleFrame.WriteMessage('ZipRead failed on file '+name);
    SetLength(result,0);
  end;


function TForm2.Decompress(var buf :array of byte; start,len,finalsize:longint):tMemFile;
  var
    i,j,vbufstart,decbits,decpos,declen :longint;
    decbyte :byte;
    dcbuf :tMemFile;
  begin
    i := start;
    j := 0;
    vbufstart := $FEE;
    decbits := 8;
    SetLength(dcbuf,finalsize);
    decbyte := 0;  // unneccessary but avoids a compiler warning which is also unneccessary
    while j<finalsize do begin
      if decbits=8 then begin
        decbyte := buf[i];
        inc(i);
        decbits := 0;
      end;
      if (decbyte shr decbits) and 1=0 then begin
        decpos := (buf[i]+longint(buf[i+1]) and $F0 shl 4-vbufstart-j) and $FFF-4096+j;
        declen := buf[i+1] and $F+3;
        inc(i,2);

        // if decpos+4096=j then Writeln(t,s,' ',filename,': Verweis auf sich selbst bei cpr=',i-2,' unc=',j);
        while declen>0 do begin
          if decpos>=0 then
            dcbuf[j] := dcbuf[decpos]
          else begin
            // Writeln(t,s,' ',filename,': Verweis nach ',decpos,' bei cpr=',i-2,' unc=',j)};
            dcbuf[j] := 32; //„ndern wenn's nicht stimmt, k”nnte auch 31 oder 33 sein
          end;
          inc(j);
          inc(decpos);
          dec(declen)
        end
      end
      else begin
        dcbuf[j] := buf[i];
        inc(i);
        inc(j);
      end;
      inc(decbits);
    end;
    Decompress := dcbuf;
  end;

function TForm2.DecodeGZPFile(gzpname,ingzpfilename :string):tMemFile;
  var
    j,k :integer;
    f :file;
    header,indexheader :array[0..1] of longint;
    filename2 :array[0..255] of char;
    filename :string;
    fileindex :record
      size :longint;
      size_uncmp :longint;
      u1 :longint;
      start :longint;
      compr :byte;
      namelength :byte
    end;
    memfile :tMemFile;

  begin
    FileMode := 0;
    AssignFile(f,gzpname);
    {$I-}
    Reset(f,1);
    if IOResult<>0 then
      raise Exception.Create('ZipRead failed on '+ingzpfilename+#13#13'Unable to open '+gzpname);

    BlockRead(f,header,8,j);
    if (j<>8) or (header[0]<>$6608F101) then
      raise Exception.Create('ZipRead failed on '+ingzpfilename+#13#13+gzpname+' is not a valid archive');

    Seek(f,header[1]);
    BlockRead(f,indexheader,8);

    for k := 0 to indexheader[1]-1 do begin
      BlockRead(f,fileindex,18);
      BlockRead(f,filename2,longint(fileindex.namelength));
      filename := '';
      for j := 0 to longint(fileindex.namelength)-2 do
        filename := filename+filename2[j];
      filename := upcases(filename);
      if filename=upcases(ingzpfilename) then begin
        // read entry, decide whether or not to decode and then do so...
        Seek(f,fileindex.start+16);
        SetLength(memfile,fileindex.size-16);
        BlockRead(f,memfile[0],fileindex.size-16);
        if fileindex.compr and 3=1 then (***)
          memfile := Decompress(memfile,0,fileindex.size-16,fileindex.size_uncmp);
        DecodeGZPFile := memfile;
        CloseFile(f);
        exit
      end;
    end;
    CloseFile(f);
    raise Exception.Create('ZipRead failed on '+ingzpfilename+#13#13+'unable to find file in '+gzpname);

  end;

function TForm2.DecodeGTI(var gti :array of byte):boolean;
  var
    p :longint;
    b :byte;
    x,y :longint;
    gtivoxel :record
      height :single;
      color :tColor4;
      unknown :byte;
    end;
    terrainheader2 :tTerrainheader;
    gtip :integer;

  begin
    DecodeGTI := false;
    Move(gti[0],terrainheader2,sizeof(terrainheader2));
    if (terrainheader2.xl<2) or (terrainheader2.yl<2) or
      (terrainheader2.xl>4096) or (terrainheader2.yl>4096)
       or (terrainheader2.signature<>-1802088445) then begin
        exit
      end;

    terrainheader := terrainheader2;

    terrain.setsize(terrainheader.xl,terrainheader.yl);

    UpdateTerrainHeader;

    for y := 0 to terrain.yl-1 do
      for x := 0 to terrain.xl-1 do begin
        terrain.height[y*terrain.xl+x] := terrainheader.minheight;
        terrain.light[y*terrain.xl+x][0] := 255;
        terrain.light[y*terrain.xl+x][1] := 0;
        terrain.light[y*terrain.xl+x][2] := 255;
        terrain.light[y*terrain.xl+x][3] := 0;
        terrain.triangle[y*terrain.xl+x] := 0;
      end;

    p := 0;
    gtip := sizeof(terrainheader2);

    while p<terrain.xl*terrain.yl do begin
      b := gti[gtip];
      inc(gtip);
      if b>=$80 then
        while b<>$00 do begin
          if p>=terrain.xl*terrain.yl then
            exit;
          inc(p);
          inc(b);
        end
      else
        while b<>$FF do begin
          if p>=terrain.xl*terrain.yl then
            exit;
          if terrainheader.version<>7 then begin
            Move(gti[gtip],gtivoxel,8);
            inc(gtip,8);
          end
          else begin
            Move(gti[gtip],gtivoxel,9);
            inc(gtip,9);
//            terrain.unknown[p] := gtivoxel.unknown;
          end;
          terrain.height[p] := gtivoxel.height;
          terrain.triangle[p]     := gtivoxel.color[0];
          terrain.light[p,0] := gtivoxel.color[1];
          terrain.light[p,1] := gtivoxel.color[2];
          terrain.light[p,2] := gtivoxel.color[3];
          inc(p);
          dec(b);
        end;
    end;
    terrain.stretch := terrainheader.stretch;
    terrain.xoffset := terrainheader.xoffset;
    terrain.yoffset := terrainheader.yoffset;
    edit1.Text := StrSingle(terrainheader.minheight);
    edit2.Text := StrSingle(terrainheader.maxheight);

//    Caption := 'GiantsEdit 5.4 - '+OpenGTIDialog.FileName;

    if terrainheader.version=7 then
      terrainheader.version := 3;
    
    DecodeGTI := true;

  end;


function TForm2.LoadGTI(filename :string):boolean;
  var
    f :file;
    memfile :array of byte;

  begin
    AssignFile(f,FileName);
    FileMode := 0;
    {$I-}
    Reset(f,1);
    LoadGTI := false;
    if IOResult<>0 then begin
      exit
    end;
    {$I+}
    SetLength(memfile,FileSize(f));
    BlockRead(f,memfile[0],filesize(f));
    CloseFile(f);
    LoadGTI := DecodeGTI(memfile);
  end;

procedure TForm2.DrawDomeClick(Sender: TObject);
begin
  DrawDome.Checked := not DrawDome.Checked;
end;

procedure TForm2.DomeColor1Click(Sender: TObject);
begin
  ColorDialog1.Color := domecolor;
  if not ColorDialog1.Execute then
    exit;
  domecolor := ColorDialog1.Color;
end;

procedure TForm2.Seacolor1Click(Sender: TObject);
begin
  ColorDialog1.Color := seacolor;
  if not ColorDialog1.Execute then
    exit;
  seacolor := ColorDialog1.Color;
end;

procedure TForm2.seagroundcolor1Click(Sender: TObject);
begin
  ColorDialog1.Color := seagroundcolor;
  if not ColorDialog1.Execute then
    exit;
  seagroundcolor := ColorDialog1.Color;
end;

procedure TForm2.About1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;
(*
procedure TForm2.FormPaint(Sender: TObject);
var
  ps : TPaintStruct;
begin
  BeginPaint(Handle,ps);
  Draww;
  EndPaint(Handle,ps);
end;
  *)



procedure TForm2.ImportWizard1Click(Sender: TObject);
begin
  ImportWizard.Map := Terrain;
  if ImportWizard.ShowModal=mrOk then begin
    Terrain := ImportWizard.Map;
    if map.gtiname='' then map.gtiname := 'default.gti';
  end;
end;


procedure TForm2.GTIheadereditor1Click(Sender: TObject);
begin
  if Application.MessageBox('This function is useless because'#13'these values are not used by Giants.'#13'Continue?','Question',mb_OkCancel)=idCancel then
    exit;
  Form4.Visible := true;
  Form4.BringToFront;
end;

procedure TForm2.Mapproperties1Click(Sender: TObject);
begin
  if SpeedButton8.Down then begin
    Application.MessageBox('You have to exit map editing mode first','Error');
    exit
  end;
  if (wrapper<>nil) and not Form3.Visible then begin
    wrapper.reload;
  end;
  if not Form3.Visible then begin
    if Application.MessageBox('This dialog provides powerful but hard to understand'#13'means for editing a map''s objects and properties.'#13'Improper use may make your map unusable.'#13'It is better to use the object editing capabilities.'#13#13'Still continue?','Warning',mb_OkCancel)=idCancel then
      exit;
  end;
  Form3.Visible := true;
  Form3.BringToFront;
end;

(*procedure TForm2.Panel1Redraw(Sender :TObject);
  begin
    Draww;
  end;*)



procedure TForm2.NewMap(filename :string);
  begin
    if IsAbortResult(NewMapDialog.ShowModal) then
      exit;
    ZipMaster1.ZipFileName := filename;
//    Caption := 'GiantsEdit 5.2 - new file';
  end;

procedure TForm2.New1Click(Sender: TObject);
  var
    s :string;
  begin
    if map.isopen then
      case Application.MessageBox('Save map before closing?','Question',MB_YESNOCANCEL) of
        IDYES:if not Savemap then exit;
        IDCANCEL:exit
      end;
    mapclose;
    Application.MessageBox('Please select an existing map in the following dialog as a basis for your new map!','Important!');
    objects1Click(sender);
    mapopen;
//    NewMap(s);
    while MapNamesDlg.ShowModal<>mrOk do
      Application.MessageBox('You must select a map type!','Error');
    map.filename := '';
    Caption := 'GiantsEdit 5.4 - '+s;
  end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
  SpeedButton1.Down := true;
  UpdateLowerPanel;
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
  SpeedButton2.Down := true;
  UpdateLowerPanel;
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
begin
  SpeedButton3.Down := true;
  UpdateLowerPanel;
end;

function TForm2.GetTerrainVoxel(x,y :integer):TGLArrayf3;
  begin
    GetTerrainVoxel := GetTerrainVoxel(x,y,false);
  end;

function TForm2.GetTerrainVoxel(x,y :integer; testinvisible:boolean):TGLArrayf3;
  var
    fovfactor,x2,y2 :single;
    ray :TGLArrayf3;
    i :longint;
  begin
// determine the point clicked by the user; this should give the "line of sight"
// the fov is based on the panel height
// I'll eat a broom if this is 100% precise ;-)
    fovfactor := 2*tan(fov/2/360*(2*pi))/Panel1.Height;
    x2 := -(x-Panel1.Width/2)*fovfactor;
    y2 := -(y-Panel1.Height/2)*fovfactor;
// the ray has the formula: ray=eye+d*(view+x2*right+y2*up); d is any positive value
// this must be checked against all possible triangles. The hit which is closest
// to the viever is the triangle we are looking for. If no triangle was hit
// discard this attempt...
    for i := 0 to 2 do
      ray[i] := view[i]+x2*right[i]+y2*up[i];
    GetTerrainVoxel := Raytrace(eye,ray,testinvisible);
  end;


function TForm2.Raytrace(eye,ray :TGLArrayf3; testinvisible:boolean):TGLArrayf3;
  var
    x,y,xl,yl :longint;
    cam :TGLArrayf3; // this is a modified point of view
    ortho,vect :TGLArrayf3;
    b :byte;
    r,s,t :single;
    bestresult :TGLArrayf3;
    hasresult :boolean;
  begin
    bestresult[2] := -1;
    hasresult := false;
    xl := terrain.xl;
    yl := terrain.yl;
    cam[0] := eye[0]-terrain.xoffset;
    cam[1] := eye[1]-terrain.yoffset;
    cam[2] := eye[2];
    cam[0] := cam[0]/terrain.stretch;
    cam[1] := cam[1]/terrain.stretch;
    ray[0] := ray[0]/terrain.stretch;
    ray[1] := ray[1]/terrain.stretch;
// now all triangle edges are aligned on nonnegative integer x and y coordinates :)
// check all the triangles... this process can be speeded up ;-) but I don't do so here
    for y := 0 to yl-2 do
      for x := 0 to xl-2 do begin
        b := terrain.triangle[y*xl+x] and 7;
        if (b=4) or (b=5) or (b=7) or testinvisible then // first condition: does triangle exist?
          if abs(              // second condition: does ray touch area above/below triangle?
             sign((cam[0]- x   )*ray[1]-(cam[1]- y   )*ray[0])
            +sign((cam[0]- x   )*ray[1]-(cam[1]-(y+1))*ray[0])
            +sign((cam[0]-(x+1))*ray[1]-(cam[1]-(y+1))*ray[0]))<3 then begin

          //  cam+r*ray = (x+s,y+1-t,z01+(z00-z01)*t+(z11-z01)*s)
          // ortho = (1,0,z11-z01) x (0,-1,z00-z01)
          // => (cam+r*ray)*ortho=(x,y,z00)*ortho
          // => r = ((x,y,z00)-cam)*ortho/(ray*ortho)
          // cam+r*ray liefert die Koordinaten auf dem Terrain
            ortho[0] := terrain.height[(y+1)*xl+(x+1)]-terrain.height[(y+1)*xl+x];
            ortho[1] := terrain.height[(y+1)*xl+x]-terrain.height[y*xl+x];
            ortho[2] := -1;
            vect[0] := x-cam[0];
            vect[1] := y-cam[1];
            vect[2] := terrain.height[y*xl+x]-cam[2];
            r := SkalProd(vect,ortho)/SkalProd(ray,ortho);
            s := cam[0]+r*ray[0]-x;
            t := cam[1]+r*ray[1]-y;

            if (r>0) and (s>=0) and (t>=0) and (s<1) and (t<1) and (t-s>=0) then
              if not hasresult or (bestresult[2]>r) then begin
                hasresult := true;
                bestresult[2] := r;
                bestresult[0] := s+x;
                bestresult[1] := t+y;
              end;
          end;
        if (b=5) or (b=3) or testinvisible then // first condition: does triangle exist?
          if abs(              // second condition: does ray touch area above/below triangle?
             sign((cam[0]- x   )*ray[1]-(cam[1]- y   )*ray[0])
            +sign((cam[0]-(x+1))*ray[1]-(cam[1]- y   )*ray[0])
            +sign((cam[0]-(x+1))*ray[1]-(cam[1]-(y+1))*ray[0]))<3 then begin

          //  cam+r*ray = (x+s,y+1-t,z01+(z00-z01)*t+(z11-z01)*s)
          // ortho = (1,0,z11-z01) x (0,-1,z00-z01)
          // => (cam+r*ray)*ortho=(x,y,z00)*ortho
          // => r = ((x,y,z00)-cam)*ortho/(ray*ortho)
          // cam+r*ray liefert die Koordinaten auf dem Terrain
            ortho[0] := terrain.height[y*xl+(x+1)]-terrain.height[y*xl+x];
            ortho[1] := terrain.height[(y+1)*xl+(x+1)]-terrain.height[y*xl+(x+1)];
            ortho[2] := -1;
            vect[0] := x-cam[0];
            vect[1] := y-cam[1];
            vect[2] := terrain.height[y*xl+x]-cam[2];
            r := SkalProd(vect,ortho)/SkalProd(ray,ortho);
            s := cam[0]+r*ray[0]-x;
            t := cam[1]+r*ray[1]-y;

            if (r>0) and (s>=0) and (t>=0) and (s<1) and (t<1) and (t-s<=0) then begin
              if not hasresult or (bestresult[2]>r) then begin
                hasresult := true;
                bestresult[2] := r;
                bestresult[0] := s+x;
                bestresult[1] := t+y;
              end;
            end;
          end;
        if (b=1) or (b=6) then // first condition: does triangle exist?
          if abs(              // second condition: does ray touch area above/below triangle?
             sign((cam[0]- x   )*ray[1]-(cam[1]- y   )*ray[0])
            +sign((cam[0]- x   )*ray[1]-(cam[1]-(y+1))*ray[0])
            +sign((cam[0]-(x+1))*ray[1]-(cam[1]- y   )*ray[0]))<3 then begin

          //  cam+r*ray = (x+s,y+1-t,z01+(z00-z01)*t+(z11-z01)*s)
          // ortho = (1,0,z11-z01) x (0,-1,z00-z01)
          // => (cam+r*ray)*ortho=(x,y,z00)*ortho
          // => r = ((x,y,z00)-cam)*ortho/(ray*ortho)
          // cam+r*ray liefert die Koordinaten auf dem Terrain
            ortho[0] := terrain.height[y*xl+(x+1)]-terrain.height[y*xl+x];
            ortho[1] := terrain.height[(y+1)*xl+x]-terrain.height[y*xl+x];
            ortho[2] := -1;
            vect[0] := x-cam[0];
            vect[1] := y-cam[1];
            vect[2] := terrain.height[y*xl+x]-cam[2];
            r := SkalProd(vect,ortho)/SkalProd(ray,ortho);
            s := cam[0]+r*ray[0]-x;
            t := cam[1]+r*ray[1]-y;

            if (r>0) and (s>=0) and (t>=0) and (s<1) and (t<1) and (t+s<1) then
              if not hasresult or (bestresult[2]>r) then begin
                hasresult := true;
                bestresult[2] := r;
                bestresult[0] := s+x;
                bestresult[1] := t+y;
              end;
          end;
        if (b=2) or (b=6) then // first condition: does triangle exist?
          if abs(              // second condition: does ray touch area above/below triangle?
             sign((cam[0]- x   )*ray[1]-(cam[1]-(y+1))*ray[0])
            +sign((cam[0]-(x+1))*ray[1]-(cam[1]- y   )*ray[0])
            +sign((cam[0]-(x+1))*ray[1]-(cam[1]-(y+1))*ray[0]))<3 then begin

          //  cam+r*ray = (x+s,y+1-t,z01+(z00-z01)*t+(z11-z01)*s)
          // ortho = (1,0,z11-z01) x (0,-1,z00-z01)
          // => (cam+r*ray)*ortho=(x,y,z00)*ortho
          // => r = ((x,y,z00)-cam)*ortho/(ray*ortho)
          // cam+r*ray liefert die Koordinaten auf dem Terrain
            ortho[0] := terrain.height[(y+1)*xl+(x+1)]-terrain.height[(y+1)*xl+x];
            ortho[1] := terrain.height[(y+1)*xl+(x+1)]-terrain.height[y*xl+(x+1)];
            ortho[2] := -1;
            vect[0] := (x+1)-cam[0];
            vect[1] := y-cam[1];
            vect[2] := terrain.height[y*xl+(x+1)]-cam[2];
            r := SkalProd(vect,ortho)/SkalProd(ray,ortho);
            s := cam[0]+r*ray[0]-x;
            t := cam[1]+r*ray[1]-y;

            if (r>0) and (s>=0) and (t>=0) and (s<1) and (t<1) and (t+s>=1) then begin
              if not hasresult or (bestresult[2]>r) then begin
                hasresult := true;
                bestresult[2] := r;
                bestresult[0] := s+x;
                bestresult[1] := t+y;
              end;
            end;
          end;
      end;
    Raytrace := bestresult;
  end;

procedure TForm2.PaintTerrain(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  var
    i,l :integer;
    a,s,t :real;
    xl,yl :longint;
    tvox :TGLArrayf3;
    c :TGLArrayf3;
    s1,s2,st :string;
    x3,y3 :longint;
    dl :longint absolute shift;
  begin
    Str(x,s1);
    Str(y,s2);
    st := 'X='+s1+' Y='+s2;
    StatusBar1.SimpleText := st;
    if (ssCtrl in Shift) then begin
      FlyAround(Sender,Shift,X,Y);
      exit
    end;
    xl := terrain.xl;
    yl := terrain.yl;
    if not ((ssLeft in Shift) or (ssRight in Shift)) then begin
      Draww;
      exit
    end;
    tvox := GetTerrainVoxel(x,y);
    if tvox[2]<0 then begin
      Draww;
      exit
    end;
    x := trunc(tvox[0]);
    y := trunc(tvox[1]);
    s := tvox[0]-x;
    t := tvox[1]-y;
    if (ssRight in Shift) then begin
      l := 0;
      for i := 2 downto 0 do
        if brushradius=0 then
          l := l*256+terrain.light[round(tvox[1])*xl+round(tvox[0]),i]
        else
          l := l*256+round(
            terrain.light[ y   *xl+ x   ,i]*(1-s)*(1-t)
           +terrain.light[ y   *xl+(x+1),i]*   s *(1-t)
           +terrain.light[(y+1)*xl+ x   ,i]*(1-s)*   t
           +terrain.light[(y+1)*xl+(x+1),i]*   s *   t );
      ColorPanel.Color := l;
      UpdateColor;
      Draww;
      exit
    end;
    c[0] := ColorPanel.Color and 255;
    c[1] := ColorPanel.Color div 256 and 255;
    c[2] := ColorPanel.Color div 65536 and 255;
    if brushradius=0 then
      for i := 0 to 2 do
        terrain.light[round(tvox[1])*xl+round(tvox[0]),i] :=
          round(terrain.light[round(tvox[1])*xl+round(tvox[0]),i]*(1-brushalpha)+c[i]*brushalpha);
    if brushradius=1 then
      for i := 0 to 2 do begin
        a := (1-s)*(1-t)*brushalpha;
        terrain.light[y*xl+x,i] :=
          round(terrain.light[y*xl+x,i]*(1-a)+c[i]*a);
        a := s*(1-t)*brushalpha;
        terrain.light[y*xl+(x+1),i] :=
          round(terrain.light[y*xl+(x+1),i]*(1-a)+c[i]*a);
        a := (1-s)*t*brushalpha;
        terrain.light[(y+1)*xl+x,i] :=
          round(terrain.light[(y+1)*xl+x,i]*(1-a)+c[i]*a);
        a := s*t*brushalpha;
        terrain.light[(y+1)*xl+(x+1),i] :=
         round(terrain.light[(y+1)*xl+(x+1),i]*(1-a)+c[i]*a);
      end;
    if brushradius>1 then
      for y3 := Max(0,y-round(brushradius*3)) to Min(yl-1,y+round(brushradius*3)) do
        for x3 := Max(0,x-round(brushradius*3)) to Min(xl-1,x+round(brushradius*3)) do begin
          a := exp(-(sqr(x3-tvox[0])+sqr(y3-tvox[1]))/sqr(brushradius/2))*brushalpha;
          for i := 0 to 2 do
            terrain.light[y3*xl+x3,i] :=
              round(terrain.light[y3*xl+x3,i]*(1-a)+c[i]*a);
        end;
    Str(x,s1);
    Str(y,s2);
    st := 'X='+s1+' Y='+s2;
    StatusBar1.SimpleText := st;
    Draww;
//   Application.MessageBox(PChar(st),'Debug message')
  end;

procedure TForm2.EditTerrain(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  var
    a,s,t :real;
    xl,yl :longint;
    tvox :TGLArrayf3;
    h :single;
    s1,s2,st :string;
    x3,y3 :longint;
    dl :longint absolute shift;
  begin
    Str(x,s1);
    Str(y,s2);
    st := 'X='+s1+' Y='+s2;
    StatusBar1.SimpleText := st;
    if (ssCtrl in Shift) then begin
      FlyAround(Sender,Shift,X,Y);
      exit
    end;
    xl := terrain.xl;
    yl := terrain.yl;
    if not ((ssLeft in Shift) or (ssRight in Shift)) then begin
      Draww;
      exit
    end;
    tvox := GetTerrainVoxel(x,y);
    if tvox[2]<0 then begin
      Draww;
      exit
    end;
    x := trunc(tvox[0]);
    y := trunc(tvox[1]);
    s := tvox[0]-x;
    t := tvox[1]-y;
    if (ssRight in Shift) then begin
      if brushradius=0 then
        currentheight := terrain.height[round(tvox[1])*xl+round(tvox[0])]
      else
        currentheight :=
            terrain.height[ y   *xl+ x   ]*(1-s)*(1-t)
           +terrain.height[ y   *xl+(x+1)]*   s *(1-t)
           +terrain.height[(y+1)*xl+ x   ]*(1-s)*   t
           +terrain.height[(y+1)*xl+(x+1)]*   s *   t ;
      Edit3.Text := strsingle(currentheight);
      Draww;
      exit
    end;
    h := currentheight;
    if brushradius=0 then
      terrain.height[round(tvox[1])*xl+round(tvox[0])] := h*brushalpha
      +terrain.height[round(tvox[1])*xl+round(tvox[0])]*(1-brushalpha);
    if brushradius=1 then begin
      a := (1-s)*(1-t)*brushalpha;
      terrain.height[y*xl+x] := terrain.height[y*xl+x]*(1-a)+h*a;
      a := s*(1-t)*brushalpha;
      terrain.height[y*xl+(x+1)] := terrain.height[y*xl+(x+1)]*(1-a)+h*a;
      a := (1-s)*t*brushalpha;
      terrain.height[(y+1)*xl+x] := terrain.height[(y+1)*xl+x]*(1-a)+h*a;
      a := s*t*brushalpha;
      terrain.height[(y+1)*xl+(x+1)] := terrain.height[(y+1)*xl+(x+1)]*(1-a)+h*a;
    end;
    if brushradius>1 then
      for y3 := Max(0,y-round(brushradius*3)) to Min(yl-1,y+round(brushradius*3)) do
        for x3 := Max(0,x-round(brushradius*3)) to Min(xl-1,x+round(brushradius*3)) do begin
          a := exp(-(sqr(x3-tvox[0])+sqr(y3-tvox[1]))/sqr(brushradius/2))*brushalpha;
          terrain.height[y3*xl+x3] :=
            terrain.height[y3*xl+x3]*(1-a)+h*a;
        end;
    Str(x,s1);
    Str(y,s2);
    st := 'X='+s1+' Y='+s2;
    StatusBar1.SimpleText := st;
    if HeightBasedLight.CheckBox1.Checked then
      HeightBasedLight.ColorizeHeightbased(x-round(brushradius*3),y-round(brushradius*3),x+round(brushradius*3),y+round(brushradius*3));
    Draww;
//   Application.MessageBox(PChar(st),'Debug message')
  end;



procedure TForm2.PaintTriangles(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  const
    triamask :array[0..1,0..7,0..7] of byte=(
   ((0,1,2,3,4,5,6,7),
    (0,0,2,0,0,2,2,0),
    (0,1,0,0,0,1,1,0),
    (0,0,0,0,4,7,7,7),
    (0,0,0,3,0,3,3,0),
    (0,0,0,0,0,0,0,0),
    (0,0,0,0,0,0,0,0),
    (0,0,0,3,0,3,3,0)),

   ((0,1,2,3,4,5,6,7),
    (1,1,5,5,5,5,6,5),
    (2,5,2,5,5,5,6,5),
    (3,5,5,3,5,5,6,5),
    (4,5,5,5,4,5,6,7),
    (5,5,5,5,5,5,6,5),
    (6,5,5,5,5,5,6,5),
    (7,5,5,5,7,5,6,7)));
  var
    i,l :integer;
    x2,y2,a,s,t :real;
    xl,yl :longint;
    tvox :TGLArrayf3;
    c :TGLArrayf3;
    s1,s2,st :string;
    x3,y3 :longint;
    paintmode :longint;

  procedure ChangeVertex(x,y :integer;newstate :longint);
    begin
      if (x>=0) and (y>=0) and (x<xl-1) and (y<yl-1) then
        terrain.triangle[ y   *xl+ x   ] :=
        terrain.triangle[ y   *xl+ x   ] and 248 or
        triamask[newstate,1,terrain.triangle[ y   *xl+ x   ] and 7];
      if (x>=1) and (y>=1) and (x<xl) and (y<yl) then
        terrain.triangle[(y-1)*xl+(x-1)] :=
        terrain.triangle[(y-1)*xl+(x-1)] and 248 or
        triamask[newstate,2,terrain.triangle[(y-1)*xl+(x-1)] and 7];
      if (x>=1) and (y>=0) and (x<xl) and (y<yl-1) then
        terrain.triangle[ y   *xl+(x-1)] :=
        terrain.triangle[ y   *xl+(x-1)] and 248 or
        triamask[newstate,3,terrain.triangle[ y   *xl+(x-1)] and 7];
      if (x>=0) and (y>=1) and (x<xl-1) and (y<yl) then
        terrain.triangle[(y-1)*xl+ x   ] :=
        terrain.triangle[(y-1)*xl+ x   ] and 248 or
        triamask[newstate,7,terrain.triangle[(y-1)*xl+ x   ] and 7];
    end;

  function cornervalid(x,y :integer):boolean;
    begin
      if (x<0) or (y<0) or (x>=terrain.xl) or (y>=terrain.yl) then begin
        cornervalid := false;
        exit
      end;
      cornervalid :=
          (x>0)            and (y>0)            and (terrain.triangle[(y-1)*terrain.xl+(x-1)] and 7 in [2,3,4,5,6,7])
       or (x<terrain.xl-1) and (y>0)            and (terrain.triangle[(y-1)*terrain.xl+ x   ] and 7 in [1,2,4,5,6,7])
       or (x>0)            and (y<terrain.yl-1) and (terrain.triangle[ y   *terrain.xl+(x-1)] and 7 in [1,2,3,5,6])
       or (x<terrain.xl-1) and (y<terrain.yl-1) and (terrain.triangle[ y   *terrain.xl+ x   ] and 7 in [1,3,4,5,6,7])
    end;

  begin
    if (ssCtrl in Shift) then begin
      FlyAround(Sender,Shift,X,Y);
      exit
    end;
    xl := terrain.xl;
    yl := terrain.yl;
    if not ((ssLeft in Shift) or (ssRight in Shift)) then begin
      Draww;
      exit
    end;
    tvox := GetTerrainVoxel(x,y,true);
    if tvox[2]<0 then begin
      Draww;
      exit
    end;
    x3 := trunc(tvox[0]);
    y3 := trunc(tvox[1]);
    s := tvox[0]-x3;
    t := tvox[1]-y3;
    paintmode := ord(not (ssRight in Shift));
    if SpeedButton4.Down then begin
      if brushradius=0 then
        if s>0.5 then
          if t>0.5 then
            terrain.triangle[y3*xl+x3] := terrain.triangle[y3*xl+x3] and 248 or triamask[paintmode,2,terrain.triangle[y3*xl+x3] and 7]
          else
            terrain.triangle[y3*xl+x3] := terrain.triangle[y3*xl+x3] and 248 or triamask[paintmode,3,terrain.triangle[y3*xl+x3] and 7]
        else
          if t>0.5 then
            terrain.triangle[y3*xl+x3] := terrain.triangle[y3*xl+x3] and 248 or triamask[paintmode,7,terrain.triangle[y3*xl+x3] and 7]
          else
            terrain.triangle[y3*xl+x3] := terrain.triangle[y3*xl+x3] and 248 or triamask[paintmode,1,terrain.triangle[y3*xl+x3] and 7];
      if brushradius=1 then
        ChangeVertex(round(tvox[0]),round(tvox[1]),paintmode);
      if brushradius>1 then
        for y := -round(brushradius) to round(brushradius) do
          for x := -round(brushradius) to round(brushradius) do
            if sqr(x)+sqr(y)<sqr(brushradius) then
              ChangeVertex(round(tvox[0])+x,round(tvox[1])+y,paintmode);
    end;
    if SpeedButton5.Down then begin
      for y := -round(brushradius) to round(brushradius) do
        for x := -round(brushradius) to round(brushradius) do
          if (brushradius=0) or (sqr(x)+sqr(y)<sqr(brushradius)) then begin
            x3 := trunc(tvox[0])+x;
            y3 := trunc(tvox[1])+y;
            if (x3>=0) and (y3>=0) and (x3<xl-1) and (y3<yl-1) then
              if terrain.triangle[y3*terrain.xl+x3] and 7 in [5,6] then
                terrain.triangle[y3*terrain.xl+x3] :=
                  terrain.triangle[y3*terrain.xl+x3] and 248+5+paintmode;
          end;
    end;
    if SpeedButton6.Down then begin
      for y := -round(brushradius) to round(brushradius) do
        for x := -round(brushradius) to round(brushradius) do
          if (brushradius=0) or (sqr(x)+sqr(y)<sqr(brushradius)) then begin
            x3 := trunc(tvox[0])+x;
            y3 := trunc(tvox[1])+y;
            if (x3>=0) and (y3>=0) and (x3<xl-1) and (y3<yl-1) then
              if terrain.triangle[y3*terrain.xl+x3] and 7 in [5,6] then
                terrain.triangle[y3*terrain.xl+x3] :=
                  terrain.triangle[y3*terrain.xl+x3] and 248+5+
                  (ord(abs(terrain.height[y3*terrain.xl+(x3+1)]-terrain.height[(y3+1)*terrain.xl+x3])
                     >abs(terrain.height[(y3+1)*terrain.xl+(x3+1)]-terrain.height[y3*terrain.xl+x3]))
                  xor paintmode);
          end;
    end;
    if SpeedButton9.Down then begin
      for y := -round(brushradius) to round(brushradius) do
        for x := -round(brushradius) to round(brushradius) do
          if (brushradius=0) or (sqr(x)+sqr(y)<sqr(brushradius)) then begin
            x3 := trunc(tvox[0])+x;
            y3 := trunc(tvox[1])+y;
            if (x3>=0) and (y3>=0) and (x3<xl-1) and (y3<yl-1) then
              case ord(cornervalid(x3,y3))+2*ord(cornervalid(x3+1,y3))
                +4*ord(cornervalid(x3,y3+1))+8*ord(cornervalid(x3+1,y3+1)) of
                  0,1,2,4,8,6,9,3,5,10,12:; // piece was empty and stays empty
                  7:terrain.triangle[y3*terrain.xl+x3] :=
                    terrain.triangle[y3*terrain.xl+x3] and 248+1*paintmode;
                  11:terrain.triangle[y3*terrain.xl+x3] :=
                    terrain.triangle[y3*terrain.xl+x3] and 248+3*paintmode;
                  13:terrain.triangle[y3*terrain.xl+x3] :=
                    terrain.triangle[y3*terrain.xl+x3] and 248+7*paintmode;
                  14:terrain.triangle[y3*terrain.xl+x3] :=
                    terrain.triangle[y3*terrain.xl+x3] and 248+2*paintmode;
                  15:terrain.triangle[y3*terrain.xl+x3] :=
                    terrain.triangle[y3*terrain.xl+x3] and 248+5+
                    (ord(abs(terrain.height[y3*terrain.xl+(x3+1)]-terrain.height[(y3+1)*terrain.xl+x3])
                        >abs(terrain.height[(y3+1)*terrain.xl+(x3+1)]-terrain.height[y3*terrain.xl+x3]))
                  xor paintmode);
              end;
          end;
    end;
    Draww;
  end;


procedure TForm2.ColorPanelClick(Sender: TObject);
begin
  ColorDialog1.Color := ColorPanel.Color;
  if not ColorDialog1.Execute then
    exit;
  ColorPanel.Color := ColorDialog1.Color;
  UpdateColor;
end;

function angle(x,y :real):real;
  begin
    if x=0 then
      if y>0 then
        angle := pi/2
      else
        angle := 3*pi/2
    else
      if x>0 then
        if y>=0 then
          angle := arctan(y/x)
        else
          angle := arctan(y/x)+2*pi
      else
        angle := arctan(y/x)+pi
  end;

procedure TForm2.UpdateColor;
  var
    s :string;
  begin
    Str(ColorPanel.Color and 255,s);
    if s<>ColorRed.Text then
      ColorRed.Text := s;
    Str(ColorPanel.Color div 256 and 255,s);
    if s<>ColorGreen.Text then
      ColorGreen.Text := s;
    Str(ColorPanel.Color div 65536 and 255,s);
    if s<>ColorBlue.Text then
      ColorBlue.Text := s;
  end;

procedure TForm2.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);

begin
  if not (ssLeft in Shift) then
    exit;
  x := x*4 div 3;
  if x<0 then x := 0;
  if x>255 then x := 255;
  ColorPanel.Color := ColorPanel.Color and (255*(256+65536))+x and 255;
  UpdateColor;
end;

procedure TForm2.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if not (ssLeft in Shift) then
    exit;
  x := x*4 div 3;
  if x<0 then x := 0;
  if x>255 then x := 255;
  ColorPanel.Color := ColorPanel.Color and (255*(1+65536))+x*256 and (255*256);
  UpdateColor;
end;

procedure TForm2.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
 Y: Integer);
begin
  if not (ssLeft in Shift) then
    exit;
  x := x*4 div 3;
  if x<0 then x := 0;
  if x>255 then x := 255;
  ColorPanel.Color := ColorPanel.Color and (255*(1+256))+x*65536 and (255*65536);
  UpdateColor;
end;

procedure TForm2.ColorRedChange(Sender: TObject);
var
  v :longint;
  c :longint;
begin
  Val(ColorRed.Text,v,c);
  if (c=0) and (v>=0) and (v<=255) then begin
    ColorPanel.Color := ColorPanel.Color and (255*(256+65536))+v;
    UpdateColor
  end;
end;

procedure TForm2.ColorGreenChange(Sender: TObject);
var
  v :longint;
  c :longint;
begin
  Val(ColorGreen.Text,v,c);
  if (c=0) and (v>=0) and (v<=255) then begin
    ColorPanel.Color := ColorPanel.Color and (255*(1+65536))+v*256;
    UpdateColor
  end;
end;

procedure TForm2.ColorBlueChange(Sender: TObject);
var
  v :longint;
  c :longint;
begin
  Val(ColorBlue.Text,v,c);
  if (c=0) and (v>=0) and (v<=255) then begin
    ColorPanel.Color := ColorPanel.Color and (255*(1+256))+v*65536;
    UpdateColor
  end;
end;

procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1MouseMove(Sender,Shift,X,Y);
end;

procedure TForm2.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2MouseMove(Sender,Shift,X,Y);
end;

procedure TForm2.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3MouseMove(Sender,Shift,X,Y);
end;

procedure TForm2.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if mbLeft=Button then
    Shift := Shift + [ssLeft];
  if mbRight=Button then
    Shift := Shift + [ssRight];
  if mbMiddle=Button then
    Shift := Shift + [ssMiddle];
  mouseclickpos[0] := x;
  mouseclickpos[1] := y;
  if (SpeedButton8.Down) and not (ssCtrl in Shift) and not (ssShift in Shift) then
    self.EditObjects(Sender,Shift,X,Y, true)
  else
    Panel1.OnMouseMove(Sender,Shift,X,Y);
end;

procedure TForm2.Save1Click(Sender: TObject);
var
  reg :TRegistry;
  s,s2 :string;
  l :longword;
  i :integer;

begin
  if map.filename='' then begin
    NewOpenMapDialog.FilterIndex := 1;
    NewOpenMapDialog.Title := 'Save map as...';
    if not NewOpenMapDialog.Execute then exit;
    s := NewOpenMapDialog.FileName;
    map.filename := s;
    SaveMap1Click(sender);
    Caption := 'GiantsEdit 5.4 - '+s;
  end
  else begin
    if map.filename='' then
      Saveterrainas1Click(nil)
    else begin
      if FileExists(map.filename) then
        DeleteFile(map.filename);
      if not SaveMap then exit;
    end;
  end;
  // try to load the DLL
  reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  s := '';
  if Reg.OpenKey('\SOFTWARE\GMM',false) then begin
    s := Reg.ReadString('DESTDIR');
    Reg.CloseKey;
  end;
  if (s<>'') and (s[length(s)]<>'\') then
    s := s+'\';
  if (s='') or not DirectoryExists(s+'Modpacks\') then begin
    Application.MessageBox('GMM path not found! Make sure that you have the latest version of GMM installed (at least Beta 3).','Error');
    exit
  end;
  Application.Minimize;


  // ADD: check for valid path
  s2 := map.filename;
  i := length(s2);
  while (length(s2)>0) and (s2[i]<>'\') do
    dec(i);
  s2 := copy(s2,i+1,length(s));

  l := Windows.WinExec(PChar('"'+s+'GiantsModManager.exe'+'" -nogamespy -gmm_autohost -gmm_selectgck "'+s2+'"'),SW_SHOWDEFAULT);
  if l<=32 then begin
    Application.Restore;
    Str(l,s);
    Application.MessageBox(PChar(s),'Return value');
  end;
  exit;
end;


procedure TForm2.SaveAs1Click(Sender: TObject);
  var
    s :string;
    j :integer;
  begin
    SaveGTIDialog.InitialDir := giantsfolder+'bin\override\';
    if not SaveGTIDialog.Execute then
      exit;
    s := SaveGTIDialog.FileName;
    SaveGTI(s);
    j := length(s);
    while (j>0) and (s[j]<>'\') do
      dec(j);
    s := copy(s,j+1,length(s)-j);
    if (wrapper<>nil) and (upcases(s)<>upcases(fbase.getchildnode('[FileStart]').getchildleaf('GtiName').getString)) then
      if Application.MessageBox('Your terrain name differs from the one in the map file. Update map?','Question',MB_YESNO) = IDYES then
        fbase.getchildnode('[FileStart]').getchildleaf('GtiName').setString(s);
//    Caption := 'GiantsEdit 5.2 - '+SaveGTIDialog.FileName;
  end;


procedure TForm2.SaveGTI(filename :string);
  var
    data :tByteList;
    f :file;
  begin
    data := SaveGTIToStream;
    AssignFile(f,filename);
    Rewrite(f,1);
    BlockWrite(f,data[0],length(data));
    CloseFile(f);
    SetLength(data,0);
  end;


function TForm2.SaveGTIToStream:tByteList;
  var
    b :byte;
    x,y,n,j,xl,yl,i :longint;
    nst :boolean;
    gtivoxel :array[0..127] of record
      height :single;
      color :array[0..3] of byte;
      unknown :byte;
    end;
    mask :array of boolean;
    data :tByteList;
    dataptr :integer;

  begin
    SetLength(data,terrain.xl*terrain.yl*9+100);
    xl := terrain.xl;
    yl := terrain.yl;

    terrainheader.xoffset := terrain.xoffset;
    terrainheader.yoffset := terrain.yoffset;
    terrainheader.stretch := terrain.stretch;
    terrainheader.xl := terrain.xl;
    terrainheader.yl := terrain.yl;
    if terrainheader.version=7 then
      terrainheader.version := 3;

    terrainheader.minheight := 1e20;
    terrainheader.maxheight := -1e20;
    for y := 0 to terrain.yl-1 do
      for x := 0 to terrain.xl-1 do begin
        if terrain.height[y*terrain.xl+x]<terrainheader.minheight then
          terrainheader.minheight := terrain.height[y*terrain.xl+x];
        if terrain.height[y*terrain.xl+x]>terrainheader.maxheight then
          terrainheader.maxheight := terrain.height[y*terrain.xl+x];
      end;

    Move(terrainheader,data[0],96);
    dataptr := 96;

   // temporary creation of mask map
     SetLength(mask,xl*yl);
    for y := 1 to yl-1 do
      for x := 1 to xl-1 do
        mask[y*xl+x] :=
           (terrain.triangle[ y   *xl+ x   ] and 7 in [1,3,4,5,6,7])
        or (terrain.triangle[ y   *xl+(x-1)] and 7 in [1,2,4,5,6,7])
        or (terrain.triangle[(y-1)*xl+ x   ] and 7 in [1,2,3,5,6])
        or (terrain.triangle[(y-1)*xl+(x-1)] and 7 in [2,3,4,5,6,7]);
    for y := 1 to yl-1 do
      for x := 0 to 0 do
        mask[y*xl+x] :=
           (terrain.triangle[ y   *xl+ x   ] and 7 in [1,3,4,5,6,7])
        or (terrain.triangle[(y-1)*xl+ x   ] and 7 in [1,2,3,5,6]);
    for y := 0 to 0 do
      for x := 1 to xl-1 do
        mask[y*xl+x] :=
           (terrain.triangle[ y   *xl+ x   ] and 7 in [1,3,4,5,6,7])
        or (terrain.triangle[ y   *xl+(x-1)] and 7 in [1,2,4,5,6,7]);
    mask[0] := terrain.triangle[0] and 7 in [1,3,4,5,6,7];

    nst := mask[0];
    n := 0;
    for y := 0 to yl-1 do
      for x := 0 to xl-1 do begin
        if (mask[y*xl+x]<>nst) or (n=128) then begin
          if nst then begin
            b := n-1;
            data[dataptr] := b;
{            if terrainheader.version=7 then begin
              for i := 0 to n-1 do
                move(gtivoxel[i],data[dataptr+1+9*i],9);
              inc(dataptr,9*n+1);
            end
            else begin}
            for i := 0 to n-1 do
              move(gtivoxel[i],data[dataptr+1+8*i],8);
            inc(dataptr,8*n+1);
{            end}
          end
          else begin
            b := 256-n;
            data[dataptr] := b;
            inc(dataptr);
          end;
          nst := mask[y*xl+x];
          n := 0;
        end;
        if nst then begin
          gtivoxel[n].height := terrain.height[y*xl+x];
          for j := 0 to 2 do
            gtivoxel[n].color[j+1] := terrain.light[y*xl+x,j];
          gtivoxel[n].color[0] := terrain.triangle[y*xl+x];
        end;
        inc(n);
      end;
    if nst then begin
      b := n-1;
      data[dataptr] := b;
      for i := 0 to n-1 do
        move(gtivoxel[i],data[dataptr+1+8*i],8);
      inc(dataptr,8*n+1);
    end
    else begin
      b := 256-n;
      data[dataptr] := b;
      inc(dataptr);
    end;
    SetLength(Result,dataptr);
    Move(data[0],Result[0],dataptr);
    SetLength(data,0);
  end;


procedure TForm2.StretchMove1Click(Sender: TObject);
begin
  StretchDialog.showmodal;
end;

procedure TForm2.Crop1Click(Sender: TObject);
begin
  CropDlg.ShowModal;
end;

procedure TForm2.Addborders1Click(Sender: TObject);
begin
  AddBorderDlg.ShowModal;
end;

procedure TForm2.SpeedButton7Click(Sender: TObject);
begin
  SpeedButton7.Down := true;
  UpdateLowerPanel;
end;

procedure TForm2.UpdateLowerPanel;
  begin
    if MapObjectSelected then
      ClearMapObject;
    Panel5.Align := alClient;
    Panel6.Align := alClient;
    Panel7.Align := alClient;
    Panel4.Align := alClient;
    Panel5.Visible := SpeedButton3.Down;
    Panel6.Visible := SpeedButton2.Down;
    Panel7.Visible := SpeedButton8.Down;
    Panel4.Visible := SpeedButton7.Down;
  end;

procedure TForm2.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (SpeedButton1.Down) or (ssCtrl in Shift) then
    self.FlyAround(Sender,Shift,x,y)
  else begin
    if SpeedButton2.Down then
      self.EditTerrain(Sender,Shift,x,y);
    if SpeedButton3.Down then
      self.PaintTerrain(Sender,Shift,x,y);
    if SpeedButton7.Down then
      self.PaintTriangles(Sender,Shift,x,y);
    if SpeedButton8.Down then
      if (abs(mouseclickpos[0]-x)>4) or (abs(mouseclickpos[1]-y)>4) then
        self.EditObjects(Sender,Shift,x,y,false);
  end
end;

var
  nhrecc :boolean=false;

procedure TForm2.TrackBar1Change(Sender: TObject);
begin
  if nhrecc then exit;
  nhrecc := true;
  currentheight := minimumheight+(maximumheight-minimumheight)*trackbar1.Position/1000;
  Edit3.Text := StrSingle(currentheight);
  nhrecc := false;
end;

procedure TForm2.Edit1Change(Sender: TObject);
var
  code :integer;
  mh :single;
begin
  if nhrecc then exit;
  nhrecc := true;
  Val(Edit1.Text,mh,code);
  if (code=0) then begin
    if mh>=maximumheight then begin
      maximumheight := mh;
      Edit2.Text := StrSingle(maximumheight);
    end;
    minimumheight := mh;
    if currentheight < minimumheight then begin
      currentheight := minimumheight;
      Edit3.Text := StrSingle(currentheight);
    end;
    if currentheight > maximumheight then begin
      currentheight := maximumheight;
      Edit3.Text := StrSingle(currentheight);
    end;
    if minimumheight<>maximumheight then
      TrackBar1.Position := round((currentheight-minimumheight)/(maximumheight-minimumheight)*1000);
  end;
  nhrecc := false;
end;

procedure TForm2.Edit2Change(Sender: TObject);
var
  code :integer;
  mh :single;
begin
  if nhrecc then exit;
  nhrecc := true;
  Val(Edit2.Text,mh,code);
  if (code=0) then begin
    if mh<=minimumheight then begin
      minimumheight := mh;
      Edit1.Text := StrSingle(minimumheight);
    end;
    maximumheight := mh;
    if currentheight < minimumheight then begin
      currentheight := minimumheight;
      Edit3.Text := StrSingle(currentheight);
    end;
    if currentheight > maximumheight then begin
      currentheight := maximumheight;
      Edit3.Text := StrSingle(currentheight);
    end;
    if minimumheight<>maximumheight then
      TrackBar1.Position := round((currentheight-minimumheight)/(maximumheight-minimumheight)*1000);
  end;
  nhrecc := false;
end;


procedure TForm2.Edit3Change(Sender: TObject);
var
  code :integer;
  ch :single;
begin
  if nhrecc then exit;
  nhrecc := true;
  Val(Edit3.Text,ch,code);
  if (code=0) then begin
    if ch>=maximumheight then begin
      maximumheight := ch;
      Edit2.Text := StrSingle(maximumheight);
    end;
    if ch<=minimumheight then begin
      minimumheight := ch;
      Edit1.Text := StrSingle(minimumheight);
    end;
    currentheight := ch;
    if minimumheight<>maximumheight then
      TrackBar1.Position := round((currentheight-minimumheight)/(maximumheight-minimumheight)*1000);
  end;
  nhrecc := false;
end;

procedure TForm2.Exportlightmap1Click(Sender: TObject);
var
  pic :TPicture;
  x,y :integer;
begin
  if ExportMapDialog.Execute then begin
    pic := TPicture.Create;
    pic.bitmap.Width := terrain.xl;
    pic.bitmap.Height := terrain.yl;
    pic.bitmap.PixelFormat := pf24bit;
    for y := 0 to terrain.yl-1 do
      for x := 0 to terrain.xl-1 do
        pic.Bitmap.Canvas.Pixels[x,Terrain.yl-1-y] :=
          terrain.light[y*terrain.xl+x,0]
         +terrain.light[y*terrain.xl+x,1]*256
         +terrain.light[y*terrain.xl+x,2]*65536;
    pic.SaveToFile(ExportMapDialog.FileName);
    pic.Destroy;
  end;
end;

procedure TForm2.Exportheightmap1Click(Sender: TObject);
var
  s :string;
  pic :TPicture;
  i,x,y,h :integer;
  minheight,maxheight :single;
  fi :integer;
  pal: PLogPalette;
begin
  if not ExportHeightMapDialog.Execute then
    exit;
  minheight := 1e20;
  maxheight := -1e20;
  for y := 0 to terrain.yl-1 do
    for x := 0 to terrain.xl-1 do begin
      if terrain.height[y*terrain.xl+x]<minheight then
        minheight := terrain.height[y*terrain.xl+x];
      if terrain.height[y*terrain.xl+x]>maxheight then
        maxheight := terrain.height[y*terrain.xl+x];
    end;
  if ExportHeightMapDialog.FilterIndex=4 then begin
    Application.MessageBox('You must select a valid image type!','Error');
    exit
  end;
  pic := TPicture.Create;
  pic.bitmap.Width := terrain.xl;
  pic.bitmap.Height := terrain.yl;
  fi := ExportHeightMapDialog.FilterIndex;
  case fi of
    1,2:pic.bitmap.PixelFormat := pf24bit;
    3:begin
      pic.bitmap.PixelFormat := pf8bit;
      GetMem(pal, sizeof(TLogPalette) + sizeof(TPaletteEntry) * 255);
      pal.palVersion := $300;
      pal.palNumEntries := 256;
      for i := 0 to 255 do begin
        pal.palPalEntry[i].peRed := i;
        pal.palPalEntry[i].peGreen := i;
        pal.palPalEntry[i].peBlue := i;
      end;
      pic.Bitmap.Palette := CreatePalette(pal^);
    end;
  end;
  for y := 0 to terrain.yl-1 do
    for x := 0 to terrain.xl-1 do begin
      h := round((terrain.height[y*terrain.xl+x]-minheight)/(maxheight-minheight)*16777215);
      if h<0 then h := 0;
      if h>16777215 then h := 16777215;
      case fi of
        1:pic.Bitmap.Canvas.Pixels[x,Terrain.yl-1-y] := h;
        2:pic.Bitmap.Canvas.Pixels[x,Terrain.yl-1-y] := h and 255*65536+h and (255*256)+h and (65536*255) div 65536;
        3:pic.Bitmap.Canvas.Pixels[x,Terrain.yl-1-y] := h div 65536+16777216;
      end;
    end;
  pic.SaveToFile(ExportHeightMapDialog.FileName);
  pic.Destroy;
  s := 'The minimum and maximum height values used for exporting are:'#13+StrSingle(MinHeight)+#13+StrSingle(MaxHeight);
  Application.MessageBox(PChar(s),'For your information');
end;

procedure TForm2.Exporttrianglemap1Click(Sender: TObject);
var
  pic :TPicture;
  i,x,y :integer;
  pal: PLogPalette;
begin
  if ExportMapDialog.Execute then begin
    pic := TPicture.Create;
    pic.bitmap.Width := terrain.xl;
    pic.bitmap.Height := terrain.yl;
    pic.bitmap.PixelFormat := pf8bit;
    GetMem(pal, sizeof(TLogPalette) + sizeof(TPaletteEntry) * 255);
    pal.palVersion := $300;
    pal.palNumEntries := 256;
    for i := 0 to 255 do begin
      pal.palPalEntry[i].peRed  := i;
      pal.palPalEntry[i].peGreen:= i;
      pal.palPalEntry[i].peBlue := i;
    end;
    pic.Bitmap.Palette := CreatePalette(pal^);
    for y := 0 to terrain.yl-1 do
      for x := 0 to terrain.xl-1 do
        pic.Bitmap.Canvas.Pixels[x,Terrain.yl-1-y] :=
          terrain.triangle[y*terrain.xl+x]+16777216;
    pic.SaveToFile(ExportMapDialog.FileName);
    pic.Destroy;
  end;
end;

procedure TForm2.Fixopenedges1Click(Sender: TObject);
begin
  FixEdgesDlg.showmodal;
end;

procedure TForm2.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.Lighting1Click(Sender: TObject);
begin
  LightingDlg.ShowModal;
end;

procedure TForm2.Heightbasedlight1Click(Sender: TObject);
begin
  Heightbasedlight.Show;
end;

procedure TForm2.Gotolocation1Click(Sender: TObject);
begin
  GotoLocationDlg.ShowModal;
end;

procedure TForm2.Markerreport1Click(Sender: TObject);
var
  leaf,node :tTreeHandle;
  isMarker :boolean;
  AIMode,TeamID :longint;
  hinttext,s1,s2 :string;

begin
  if wrapper<>nil then begin
    hinttext := 'The following markers were found in this map:'#13#13;
    node := wrapper.Tree;
    node.SearchInitNode;
    while node.SearchNextNode do
      if node.getName='<Objects>' then
        break;
    if node.getName='<Objects>' then begin
      node.SearchInitNode;
      while node.SearchNextNode do begin
        leaf := node;
        isMarker := false;
        AIMode := maxlongint;
        TeamID := maxlongint;
        leaf.SearchInitLeaf;
        while leaf.SearchNextLeaf do begin
          if leaf.getName='Type' then
            isMarker := leaf.getInt32=679;
          if leaf.getName='AIMode' then
            AIMode := leaf.getByte;
          if leaf.getName='TeamID' then
            TeamID := leaf.getInt32;
        end;
        if isMarker then begin
          Str(AIMode,s1);
          Str(TeamID,s2);
          if AIMode<>maxlongint then
            hinttext := hinttext+'AIMode='+s1+'  ';
          if TeamID<>maxlongint then
            hinttext := hinttext+'TeamID='+s2+'  ';
          hinttext := hinttext+#13;
        end
      end;
    end;
    Application.MessageBox(PChar(hinttext),'Info')
  end
end;

procedure TForm2.Viewobjectsthroughterrain1Click(Sender: TObject);
begin
  Viewobjectsthroughterrain1.Checked := not Viewobjectsthroughterrain1.Checked;
  Draww;
end;

procedure TForm2.SpeedButton8Click(Sender: TObject);
begin
  SpeedButton8.Down := true;
  if wrapper=nil then begin
    SpeedButton1.Down := true;
    Application.MessageBox('Load an objects file first!','Error')
  end;
  if Form3.Visible or Form10.Visible then begin
    SpeedButton1.Down := true;
    Application.MessageBox('Editing is not possible while map tree pane is visible','Error')
  end;
  UpdateLowerPanel;
end;

procedure TForm2.EditObjects(Sender :TObject; Shift: TShiftState;X,Y :Integer; click :boolean); pascal;
  // object hit detection works by assuming a sphere surrounding each object
  // and checking which one is hit first.
  // if the terrain was hit first no object was hit
  const
    threshold2=50;

  var
    xl,i,x4,y4 :longint;
    tvox :TGLArrayf3;
    hitdist,r,s,t,px,py,pz,zpos,x2,y2,fovfactor :single;
    hitnode :tTreeHandle;
    ishitnode :boolean;
    ray :TGLArrayf3;
    precision :boolean;

  procedure checkobjecthit;
    var
      a2,b2,c2,d2,r1,r2 :single;
      node,leaf :tTreeHandle;
      fovfactor,x2,y2 :single;
      ray :TGLArrayf3;
      i,n :longint;
      threshold :single;
    begin
      precision := DrawRealObjects1.Checked;
      fovfactor := 2*tan(fov/2/360*(2*pi))/Panel1.Height;
      x2 := -(x-Panel1.Width/2)*fovfactor;
      y2 := -(y-Panel1.Height/2)*fovfactor;
      for i := 0 to 2 do
        ray[i] := view[i]+x2*right[i]+y2*up[i];
      if Viewobjectsthroughterrain1.Checked then
        hitdist := 1e20
      else begin
        tvox := GetTerrainVoxel(x,y);
        if tvox[2]>0 then
          hitdist := tvox[2]
        else
          hitdist := 1e20
      end;
      ishitnode := false;
      for i := 0 to 1 do
      if ((i=0) and   wrapper.Tree.HasChildNode('<Objects>') and WorldObjectsEditable1.Checked and WorldObjectsVisible1.Checked)
      or ((i=1) and wmwrapper.Tree.HasChildNode('<Objects>') and MissionObjectsEditable1.Checked and MissionObjectsVisible1.Checked)  then begin
        if i=0 then
          node := wrapper.Tree.GetChildNode('<Objects>')
        else
          node := wmwrapper.Tree.GetChildNode('<Objects>');
        node.SearchInitNode;
        while node.SearchNextNode do begin
          leaf := node;
          leaf.ScanInitLeaf;
          if leaf.ScanLeaf('X') then
            px := leaf.getSingle-eye[0];
          if leaf.ScanLeaf('Y') then
            py := leaf.getSingle-eye[1];
          if leaf.ScanLeaf('Z') then
            pz := leaf.getSingle-eye[2];
          if leaf.ScanLeaf('Type') then
            n := leaf.getInt32;
          leaf.ScanDoneNohint;

          if (n<0) or (n>=2048) then
            continue;

          // test ray intersection... I need "r"

  //        (eye-p)²-threshold²+2*r*(ray*(eye-p))+r²*ray²=0

          if precision then
            threshold := boundrad[n]
          else
            threshold := threshold2;


          a2 := sqr(ray[0])+sqr(ray[1])+sqr(ray[2]);
          b2 := -2*(ray[0]*px+ray[1]*py+ray[2]*pz);
          c2 := sqr(px)+sqr(py)+sqr(pz)-sqr(threshold);
          d2 := sqr(b2)-4*a2*c2;

          if d2<0 then
            continue;
          d2 := sqrt(d2);
          r1 := (-b2-d2)/(2*a2);
          r2 := (-b2+d2)/(2*a2);
          if r2<0 then
            continue;
          if r1<0 then
            r1 := r2;

//      r1*ray is the distance vector


          if precision then begin
            if r1<hitdist then begin
              // here comes the tricky part: checking all triangles... hmm... but for now we use simple distance logic :)
              ishitnode := true;
              hitdist := r1;
              hitnode := node
            end
          end
          else
            if r1<hitdist then begin
              ishitnode := true;
              hitdist := r1;
              hitnode := node
            end;
        end;
      end;
    end;

  begin
    xl := terrain.xl;
//    yl := terrain.yl;
    if not ((ssLeft in Shift) or (ssRight in Shift)) then begin
      Draww;
      exit
    end;


    if (ssShift in Shift) then begin
      if not (ssLeft in Shift) or not MapObjectSelected then begin
        Draww;
        exit
      end;
      fovfactor := 2*tan(fov/2/360*(2*pi))/Panel1.Height;
      x2 := -(x-Panel1.Width/2)*fovfactor;
      y2 := -(y-Panel1.Height/2)*fovfactor;
      for i := 0 to 2 do
        ray[i] := view[i]+x2*right[i]+y2*up[i];
(*      (mapobject-eye+s*(0,0,1))*skyvec(ray)=0
      (mapobject-eye)*skyvec(ray)+s*(0,0,1)*skyvec(ray)=0
      (eye-mapobject)*skyvec(ray)=s*(0,0,1)*skyvec(ray)
      s=((mapobject-eye)*skyvec(ray))/(ray[0]²+ray[1]²)
      skyvec(ray) = (ray[2]*ray[0],ray[2]*ray[1],-ray[0]²-ray[1]²)*)


      s :=
       ((mapobject.GetChildLeaf('X').getSingle-eye[0])*(ray[2]*ray[0])
       +(mapobject.GetChildLeaf('Y').getSingle-eye[1])*(ray[2]*ray[1])
       +(mapobject.GetChildLeaf('Z').getSingle-eye[2])*(-sqr(ray[0])-sqr(ray[1])))
       /(sqr(ray[0])+sqr(ray[1]));
      if abs(s+mapobject.GetChildLeaf('Z').getSingle)>domerad then begin
        Draww;
        exit
      end;
      Obj_z.Text := StrSingle(s+mapobject.GetChildLeaf('Z').getSingle);
      Draww;
      exit
    end;

    tvox := GetTerrainVoxel(x,y);
    x4 := trunc(tvox[0]);
    y4 := trunc(tvox[1]);
    s := tvox[0]-x4;
    t := tvox[1]-y4;
    if ((ssLeft in Shift) or (ssRight in Shift))  and click then begin
      checkobjecthit;
      if ssLeft in Shift then
        if ishitnode then
          SetMapObject(hitnode)
        else
          ClearMapObject
      else begin
        if ishitnode then begin
          SetMapObject(hitnode);
          newobjlastobject := MapObject;
          newobjpos[0] := self.MapObject.GetChildLeaf('X').getSingle;
          newobjpos[1] := self.MapObject.GetChildLeaf('Y').getSingle;
          newobjpos[2] := self.MapObject.GetChildLeaf('Z').getSingle;
          DeleteObjectUnderCursor1.Enabled := true;
          CreateObjectCopy.Caption := 'Create copy of this object';
          CreateObjectCopy.Enabled := true;
          PopupMenu1.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
        end
        else begin
          newobjpos[0] := tvox[0]*terrain.stretch+terrain.xoffset;
          newobjpos[1] := tvox[1]*terrain.stretch+terrain.yoffset;
          x4 := trunc(tvox[0]);
          y4 := trunc(tvox[1]);
          s := tvox[0]-x4;
          t := tvox[1]-y4;
          newobjpos[2] :=
                terrain.height[ y4   *xl+ x4   ]*(1-s)*(1-t)
               +terrain.height[ y4   *xl+(x4+1)]*   s *(1-t)
               +terrain.height[(y4+1)*xl+ x4   ]*(1-s)*   t
               +terrain.height[(y4+1)*xl+(x4+1)]*   s *   t;

          DeleteObjectUnderCursor1.Enabled := false;
          CreateObjectCopy.Caption := 'Create copy of selected object';
          CreateObjectCopy.Enabled := self.MapObjectSelected;
          if CreateObjectCopy.Enabled then
            newobjlastobject := MapObject;
          ClearMapObject;
          PopupMenu1.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
        end;
      end

    end
    else if MapObjectSelected then begin
      if (tvox[2]>0) then
        zpos := terrain.height[ y4   *xl+ x4   ]*(1-s)*(1-t)
               +terrain.height[ y4   *xl+(x4+1)]*   s *(1-t)
               +terrain.height[(y4+1)*xl+ x4   ]*(1-s)*   t
               +terrain.height[(y4+1)*xl+(x4+1)]*   s *   t
      else
        zpos := -40;

      if (tvox[2]>0) and (zpos>-40) then begin
        Obj_x.Text := StrSingle(tvox[0]*terrain.stretch+terrain.xoffset);
        Obj_y.Text := StrSingle(tvox[1]*terrain.stretch+terrain.yoffset);
        Obj_z.Text := StrSingle(zpos);
      end
      else begin
        fovfactor := 2*tan(fov/2/360*(2*pi))/Panel1.Height;
        x2 := -(x-Panel1.Width/2)*fovfactor;
        y2 := -(y-Panel1.Height/2)*fovfactor;
        for i := 0 to 2 do
          ray[i] := view[i]+x2*right[i]+y2*up[i];
        if ray[2]<-1e-9 then begin
          r := (-40-eye[2])/ray[2];
          x2 := eye[0]+ray[0]*r;
          y2 := eye[1]+ray[1]*r;
          if sqr(x2)+sqr(y2)<sqr(domerad) then begin
            Obj_x.Text := StrSingle(x2);
            Obj_y.Text := StrSingle(y2);
            Obj_z.Text := StrSingle(-40);
          end
        end
      end
    end;
    Draww;

end;

procedure TForm2.Obj_xChange(Sender: TObject);
var
  s :single;
  c :longint;
  th :tTreeHandle;
begin
  Val(Obj_x.Text,s,c);
  if c<>0 then
    exit;
  th := MapObject.GetChildLeaf('X');
  th.setSingle(s);
end;

procedure TForm2.Obj_yChange(Sender: TObject);
var
  s :single;
  c :longint;
  th :tTreeHandle;
begin
  Val(Obj_y.Text,s,c);
  if c<>0 then
    exit;
  th := MapObject.GetChildLeaf('Y');
  th.setSingle(s);
end;

procedure TForm2.Obj_zChange(Sender: TObject);
var
  s :single;
  c :longint;
  th :tTreeHandle;
begin
  Val(Obj_z.Text,s,c);
  if c<>0 then
    exit;
  th := MapObject.GetChildLeaf('Z');
  th.setSingle(s);
end;

procedure TForm2.Obj_rot_chkClick(Sender: TObject);
var
  s :single;
begin
  if noevent then
    exit;
  if Obj_rot_chk.Checked then begin
    s := MapObject.GetChildLeaf('Angle').GetSingle;
    MapObject.GetChildLeaf('Angle').UnbindEdit;
    MapObject.GetChildLeaf('Angle').Delete;
    MapObject.AddSingle('Angle X',s).BindEdit(Obj_rot1);
    MapObject.AddSingle('Angle Y',0).BindEdit(Obj_rot2);
    MapObject.AddSingle('Angle Z',0).BindEdit(Obj_rot3);
  end
  else begin
    s := MapObject.GetChildLeaf('Angle X').GetSingle;
    MapObject.GetChildLeaf('Angle X').UnbindEdit;
    MapObject.GetChildLeaf('Angle Y').UnbindEdit;
    MapObject.GetChildLeaf('Angle Z').UnbindEdit;
    MapObject.GetChildLeaf('Angle X').Delete;
    MapObject.GetChildLeaf('Angle Y').Delete;
    MapObject.GetChildLeaf('Angle Z').Delete;
    MapObject.AddSingle('Angle',s).BindEdit(obj_rot1);
  end;
end;

procedure TForm2.SetMapObject(th :tTreeHandle);
  var
    i :longint;
  begin
    noevent := true;

    if _MapObjectSelected then
      ClearMapObject;
    _MapObjectSelected := true;
    _MapObject := th;


    for i := 0 to panel7.ControlCount-1 do
      panel7.Controls[i].Enabled := true;

    Obj_aimode.Enabled := false;
    Obj_aimode_chk.Checked := false;
    Obj_teamid.Enabled := false;
    Obj_teamid_chk.Checked := false;
    Obj_rot_chk.Checked := false;
    Obj_rot2.Enabled := false;
    obj_rot3.Enabled := false;
    Obj_scale_chk.Checked := false;
    Obj_scale.Enabled := false;
    for i := 0 to length(specactive)-1 do
      specactive[i] := false;

    th.ScanInitLeaf;
    th.ScanLeaf('Type'); th.BindEdit(Obj_type);
    th.ScanLeaf('X'); th.BindEdit(Obj_x);
    th.ScanLeaf('Y'); th.BindEdit(Obj_y);
    th.ScanLeaf('Z'); th.BindEdit(Obj_z);
    if th.ScanLeaf('Angle') then begin
      th.BindEdit(Obj_rot1);
    end
    else begin
      th.ScanLeaf('Angle X'); th.BindEdit(Obj_rot1);
      th.ScanLeaf('Angle Y'); th.BindEdit(Obj_rot2);
      th.ScanLeaf('Angle Z'); th.BindEdit(Obj_rot3);
      Obj_rot_chk.Checked := true;
    end;
    if th.ScanLeaf('AIMode') then begin
      th.BindEdit(Obj_aimode);
      Obj_aimode_chk.Checked := true;
    end;
    if th.ScanLeaf('TeamID') then begin
      th.BindEdit(Obj_teamID);
      Obj_teamid_chk.checked := true
    end;
    if th.ScanLeaf('Scale') then begin
      th.BindEdit(Obj_scale);
      Obj_scale_chk.checked := true;
    end;
    if th.ScanLeaf('OData 0') then begin
      specactive[SO_SPECIAL] := true;
                              th.BindEdit(Obj_special1);
      th.ScanLeaf('OData 1'); th.BindEdit(Obj_special2);
      th.ScanLeaf('OData 2'); th.BindEdit(Obj_special3);
    end;
    if th.ScanLeaf('LightColor 0') then begin
      specactive[SO_LIGHTING] := true;
                                   th.BindEdit(Obj_light1);
      th.ScanLeaf('LightColor 1'); th.BindEdit(Obj_light2);
      th.ScanLeaf('LightColor 2'); th.BindEdit(Obj_light3);
    end;
{      else begin
        Application.MessageBox('Warning: This value is unknown to this version of GiantsEdit.#13You may contact the author about this problem.',PChar(th.getName))
      end;}
    th.ScanDone;
    noevent := false;
    SpecUpdate;
  end;


procedure TForm2.ClearMapObject;
  var
    i,j :longint;
    th :tTreeHandle;
  begin
    if not _MapObjectSelected then
      exit;
    _MapObjectSelected := false;

    th := _MapObject;
    th.SearchInitLeaf;
    while th.searchnextleaf do
      th.UnbindEdit;

    for i := 0 to panel7.ControlCount-1 do
      panel7.Controls[i].Enabled := false;
    obj_type.Enabled := true;
    for i := 0 to length(spec)-1 do
      for j := 0 to length(spec[i])-1 do
        spec[i,j].Hide;
  end;

procedure TForm2.Obj_scale_chkClick(Sender: TObject);
begin
  if noevent then
    exit;
  if obj_scale_chk.Checked then begin
    MapObject.AddSingle('Scale',1.0).BindEdit(obj_scale);
  end
  else begin
    MapObject.GetChildLeaf('Scale').UnbindEdit;
    MapObject.GetChildLeaf('Scale').Delete;
  end;
end;

procedure TForm2.Obj_light_chkClick(Sender: TObject);
begin
  if noevent then
    exit;
  if specactive[SO_LIGHTING] then begin
    MapObject.AddSingle('LightColor 0',0.0).BindEdit(obj_light1);
    MapObject.AddSingle('LightColor 1',0.0).BindEdit(obj_light2);
    MapObject.AddSingle('LightColor 2',0.0).BindEdit(obj_light3);
  end
  else begin
    MapObject.GetChildLeaf('LightColor 0').UnbindEdit;
    MapObject.GetChildLeaf('LightColor 1').UnbindEdit;
    MapObject.GetChildLeaf('LightColor 2').UnbindEdit;
    MapObject.GetChildLeaf('LightColor 0').Delete;
    MapObject.GetChildLeaf('LightColor 1').Delete;
    MapObject.GetChildLeaf('LightColor 2').Delete;
  end;
end;

procedure TForm2.Obj_special_chkClick(Sender: TObject);
begin
  if noevent then
    exit;
  if specactive[SO_SPECIAL] then begin
    MapObject.AddSingle('OData 0',0.0).BindEdit(obj_special1);
    MapObject.AddSingle('OData 1',0.0).BindEdit(obj_special2);
    MapObject.AddSingle('OData 2',0.0).BindEdit(obj_special3);
  end
  else begin
    MapObject.GetChildLeaf('OData 0').UnbindEdit;
    MapObject.GetChildLeaf('OData 1').UnbindEdit;
    MapObject.GetChildLeaf('OData 2').UnbindEdit;
    MapObject.GetChildLeaf('OData 0').Delete;
    MapObject.GetChildLeaf('OData 1').Delete;
    MapObject.GetChildLeaf('OData 2').Delete;
  end;
end;

procedure TForm2.obj_aimode_chkClick(Sender: TObject);
begin
  if noevent then
    exit;
  if obj_aimode_chk.Checked then
    MapObject.AddByte('AIMode',0).BindEdit(obj_aimode)
  else begin
    MapObject.GetChildLeaf('AIMode').UnbindEdit;
    MapObject.GetChildLeaf('AIMode').Delete;
  end;
end;

procedure TForm2.obj_teamid_chkClick(Sender: TObject);
begin
  if noevent then
    exit;
  if obj_teamid_chk.Checked then
    MapObject.AddInt32('TeamID',0).BindEdit(obj_teamid)
  else begin
    MapObject.GetChildLeaf('TeamID').UnbindEdit;
    MapObject.GetChildLeaf('TeamID').Delete;
  end;
end;

procedure TForm2.SaveObjectsClick(Sender: TObject);
var
  bl :tByteList;
  f :file;
begin
  SaveGTIDialog.InitialDir := giantsfolder+'bin\';
  bl := nil;
  if MapObjectSelected then
    ClearMapObject;
  if Savew_bindialog.Execute then begin
    bl := SaveBinW;
    AssignFile(f,savew_bindialog.FileName);
    Rewrite(f,1);
    BlockWrite(f,bl[0],length(bl));
    CloseFile(f);
  end
end;

procedure TForm2.CreateNewObject(objectid,aimode :integer);
var
  s :string;
  node :tTreeHandle;
begin
  node := fbase.GetChildNode('<Objects>').AddNode('Object');
  node.AddInt32('Type',objectid);
  node.AddSingle('X',newobjpos[0]);
  node.AddSingle('Y',newobjpos[1]);
  node.AddSingle('Z',newobjpos[2]);
  node.AddSingle('Angle',0);
  if aimode<>-1 then
    node.AddByte('AIMode',aimode);
  SetMapObject(node);
  Draww;
end;

procedure TForm2.Deleteobjectundercursor1Click(Sender: TObject);
var
  node :TTreeHandle;
begin
  node := self.MapObject;
  ClearMapObject;
  node.Delete;
  Draww;
end;

procedure TForm2.CreateObjectCopyClick(Sender: TObject);
var
  node,newnode :TTreeHandle;
begin
  node := newobjlastobject;
  newnode := fbase.GetChildNode('<Objects>').AddNode(node.getName);
  node.SearchInitLeaf;
  while node.SearchNextLeaf do
    case node.getType of
      tprByte:newnode.AddByte(node.getName,node.getByte);
      tprInt32:newnode.AddInt32(node.getName,node.getInt32);
      tprString:newnode.AddStringL(node.getName,node.getString,node.getMaxLength);
      tprSingle:
        if node.getName='X' then
          newnode.AddSingle('X',newobjpos[0])
        else if node.getName='Y' then
          newnode.AddSingle('Y',newobjpos[1])
        else if node.getName='Z' then
          newnode.AddSingle('Z',newobjpos[2])
        else
          newnode.AddSingle(node.getName,node.getSingle);
    end;
  SetMapObject(newnode);
end;

procedure TForm2.Addincludefile1Click(Sender: TObject);
begin
  IncludefilesDlg.ShowModal;
end;

procedure TForm2.Copyincludefilelist1Click(Sender: TObject);
  var
    node :TTreeHandle;
    s :string;
  begin
    s := 'Includefiles'#13#10+map.wbinname+#13#10;
    node := fbase.GetChildNode('[includefiles]');
    node.searchinitleaf;
    while node.SearchNextLeaf do
      s := s+node.getString+#13#10;
    Clipboard.AsText := s;
  end;

procedure TForm2.Pasteincludefilelist1Click(Sender: TObject);
var
  s,s2 :string;
  node :TTreeHandle;
begin
  if map.wbinname='' then begin
    Application.MessageBox('No objects loaded','Error');
    exit
  end;
  if not Clipboard.HasFormat(CF_TEXT) then begin
    Application.MessageBox('No include files in clipboard!','Error');
    exit
  end;
  s := Clipboard.AsText;
  if copy(s,1,14)<>'Includefiles'#13#10 then begin
    Application.MessageBox('No include files in clipboard!','Error');
    exit
  end;
  s := copy(s,15,length(s));
  s2 := '';
  while (s<>'') and (s[1]>=#32) do begin
    s2 := s2+s[1];
    s := copy(s,2,length(s));
  end;
  while (s<>'') and (s[1]<#32) do
    s := copy(s,2,length(s));
  if Application.MessageBox(PChar('Do you want to replace this map''s include files with the ones from'#13+s2),'Question',mb_yesno)=idno then
    exit;
  fbase.GetChildNode('[includefiles]').Delete;
  node := fbase.AddNode('[includefiles]');
  while s<>'' do begin
    s2 := '';
    while (s<>'') and (s[1]>=#32) do begin
      s2 := s2+s[1];
      s := copy(s,2,length(s));
    end;
    while (s<>'') and (s[1]<#32) do
      s := copy(s,2,length(s));
    if s2='' then
      continue;
    node.AddStringL('String',s2,32);
  end;
end;

procedure TForm2.TrackBar2Change(Sender: TObject);
  var
    rad :single;
    s :string;
  begin
(*    bmp := TBitmap.Create;
    bmp.Width := 36;
    bmp.Height := 36;
    bmp.PixelFormat := pf32bit;*)
    rad := trackbar2.Position;
    brushradius := rad;
(*    for y := 0 to 35 do
      for x := 0 to 35 do begin
        b := round(192-192*exp(-(sqr(x-17.5)+sqr(y-17.5))/sqr(rad)));
        bmp.Canvas.Pixels[x,y] := b*(1+256+65536)
      end;
    SpeedButton6.Glyph := bmp;*)
    Str(round(rad),s);
    Edit4.Text := s;
  end;

procedure TForm2.SpeedButton4Click(Sender: TObject);
begin
  TrackBar2.Visible := false
end;

procedure TForm2.SpeedButton5Click(Sender: TObject);
begin
  TrackBar2.Visible := false
end;

procedure TForm2.SpeedButton6Click(Sender: TObject);
begin
  TrackBar2.Visible := true
end;

procedure TForm2.TrackBar3Change(Sender: TObject);
  var
    s :string;
  begin
    if brushalpha=-1 then exit;
    brushalpha := -1;
    Str(TrackBar3.Position,s);
    Edit5.Text := s;
    brushalpha := TrackBar3.Position/100;
  end;

procedure TForm2.expertmodeClick(Sender: TObject);
begin
(*  if not expertmode.Checked then begin
    if Application.MessageBox('Warning: Enabling expert mode is only recommended for experienced users.'#13#13'This mode enables some further options which may cause bad behaviour when used improperly.'#13'Still continue?','Question',mb_yesno)=idno then
      exit;
  end;
  expertmode.Checked := not expertmode.Checked;*)
end;

procedure TForm2.Openmap1Click(Sender: TObject);
  var
    sr:TSearchRec;
    overridden :array of string;
    i,j,k :longint;
    tli :TListItem;
    gtidata :tMemFile;
    s :string;
    f :file;
  begin
    EasyGTIDialog.ListView1.Items.Clear;
    // look in override folder
    if DirectoryExists(giantsfolder+'bin\override') then begin
      if FindFirst(giantsfolder+'bin\override\*.gti',$27,sr)=0 then repeat
        j := length(overridden);
        SetLength(overridden,j+1);
        overridden[j] := upcases(sr.Name);

        tli := EasyGTIDialog.ListView1.Items.Add;
        tli.Caption := sr.Name;
        tli.SubItems.Clear;
        tli.SubItems.Add('<override>');
        tli.SubItems.Add('');
      until FindNext(sr)<>0;
      FindClose(sr);
    end;
    // look in GZP files
    for i := 0 to length(gzpentry)-1 do begin
      if (length(gzpentry[i].name)<4) or (copy(gzpentry[i].name,length(gzpentry[i].name)-3,4)<>'.GTI') then
        continue;
      k := 1;
      for j := 0 to length(overridden)-1 do
        if upcases(gzpentry[i].name)=overridden[j] then begin
          k := 0;
          break
        end;
      if k=0 then
        continue;
      tli := EasyGTIDialog.ListView1.Items.Add;
      tli.Caption := gzpentry[i].Name;
      tli.SubItems.Clear;
      s := gzpentry[i].source;
      j := length(s);
      while (j>0) and (s[j]<>'\') do
        dec(j);
      s := copy(s,j+1,length(s)-j);
      tli.SubItems.Add(s);
      tli.SubItems.Add('');
    end;
    case EasyGTIDialog.ShowModal of
      mrCancel:exit;
      mrRetry:begin
        OpenGTIDialog.FilterIndex := 3;
        if not OpenGTIDialog.Execute then
          exit;
        FileMode := 0;
        AssignFile(f,OpenGTIDialog.Filename);
        Reset(f,1);
        SetLength(gtidata,FileSize(f));
        BlockRead(f,gtidata[0],length(gtidata));
        CloseFile(f);
        DecodeGTI(gtidata);
        map.gtiname := 'default.gti';
        exit
      end;
    end;
    tli := EasyGTIDialog.ListView1.Selected;
    if tli=nil then
      exit;
    gtidata := LoadGZPFile(tli.Caption);
    DecodeGTI(gtidata);
    map.gtiname := 'default.gti';
  end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm2.Showconsole1Click(Sender: TObject);
begin
  ConsoleFrame.Show;
end;

procedure TForm2.Createweirdmatrix1Click(Sender: TObject);
  var
    x,y :integer;
  begin
    for y := 0 to 15 do
      for x := 0 to 15 do begin
        terrain.triangle[(y-8+terrain.yl div 2)*terrain.xl+(x-24+terrain.xl div 2)] := x+y*16;
        terrain.triangle[(y-8+terrain.yl div 2)*terrain.xl+(x+8+terrain.xl div 2)] := x+y*16;
      end;
  end;

procedure TForm2.objects1Click(Sender: TObject);
  var
    sr :TSearchRec;
    tli :TListItem;
  begin
    EasyGTIDialog.ListView1.Items.Clear;
    // look in override folder
    if FindFirst(giantsfolder+'bin\w_*.bin',$27,sr)=0 then repeat
      tli := EasyGTIDialog.ListView1.Items.Add;
      tli.Caption := sr.Name;
      tli.SubItems.Clear;
    until FindNext(sr)<>0;
    FindClose(sr);
    case EasyGTIDialog.ShowModal of
      mrCancel:exit;
      mrRetry:begin
        OpenGTIDialog.FilterIndex := 2;
        if not OpenGTIDialog.Execute then
          exit;
        if not LoadWBin(OpenGTIDialog.FileName) then
          Application.MessageBox('This is not a valid map file','Error');
        exit
      end;
    end;
    tli := EasyGTIDialog.ListView1.Selected;
    if tli=nil then
      exit;
    if not LoadWBin(giantsfolder+'bin\'+tli.Caption) then begin
      Application.MessageBox('This is not a valid map file','Error');
      exit
    end;
    map.wbinname := 'w_default.bin';
  end;

procedure TForm2.Createinverseparabolicshape1Click(Sender: TObject);
var
  x,y :integer;
begin
  for y := 0 to terrain.yl-1 do
    for x := 0 to terrain.xl-1 do
      terrain.height[y*terrain.xl+x] :=
        sqr(x-terrain.xl div 2-0.5)+sqr(y-terrain.yl div 2-0.5);
end;

procedure TForm2.Edit4Change(Sender: TObject);
var
  code :integer;
  s :single;
begin
  Val(Edit4.Text,s,code);
  if (code=0) then begin
    if s<0 then begin
      Edit4.Text := '0';
      s := 0;
    end;
    if s>21 then begin
      Edit4.Text := '21';
      s := 21;
    end;
    Edit4.Color := $FFFFFF;
    brushradius := s;
    TrackBar2.Position := round(brushradius);
  end
  else
    Edit4.Color := $C0C0FF;
end;

procedure TForm2.Edit5Change(Sender: TObject);
var
  code :integer;
  s :single;
begin
  if brushalpha=-1 then exit;
  Val(Edit5.Text,s,code);
  if (code=0) then begin
    if s<0 then begin
      Edit5.Text := '0';
      s := 0;
    end;
    if s>100 then begin
      Edit5.Text := '100';
      s := 100;
    end;
    Edit5.Color := $FFFFFF;
    brushalpha := -1;
    TrackBar3.Position := round(s);
    brushalpha := s/100;
  end
  else
    Edit5.Color := $C0C0FF;
end;

procedure TForm2.Savemap1Click(Sender: TObject);
  begin
    if map.filename='' then
      Saveterrainas1Click(nil)
    else begin
      if FileExists(map.filename) then
        DeleteFile(map.filename);
      SaveMap;
    end;
  end;

function TForm2.Savemap:boolean;
  var
    data :tByteList;
    gmmtext,s :string;
    i,j,k,l,m :integer;
    th,th2,th3 :tTreeHandle;

  begin
    savemap := false;
    fbase.getChildNode('[includefiles]').Delete;
    th := fbase.AddNode('[includefiles]');

    th.AddStringL('Name','tx_lev1',32);
    th.AddStringL('Name','vo_sfx',32);
    th.AddStringL('Name','sfxlev1',32);

    if map.maptype and 2=0 then
      th.AddStringL('Name','xx_mecclev1',32);

    if map.maptype and 4=0 then
      th.AddStringL('Name','xx_reaperlev1',32);

    if map.maptype and 8=0 then begin
      th.AddStringL('Name','xx_kabutolev1',32);
      th.AddStringL('Name','xx_kab_stuff',32);
    end;

    th.AddStringL('Name','xx_rpman_weapons',32);
    th.AddStringL('Name','xx_permanentaliens',32);
    th.AddStringL('Name','xx_effects',32);
    th.AddStringL('Name','xx_efx',32);

    if map.maptype and 4=0 then
      th.AddStringL('Name','xx_seamonster',32);

    th.AddStringL('Name','xx_smartie',32);
    th.AddStringL('Name','xx_smborjoyzee',32);
    th.AddStringL('Name','xx_smyan',32);
    th.AddStringL('Name','xx_smartie_stuff_multi',32);

    if map.maptype and 2=0 then
      th.AddStringL('Name','xx_mecc_base',32);
    if map.maptype and 4=0 then
      th.AddStringL('Name','xx_reaper_base',32);
    if map.maptype and 8=0 then
      th.AddStringL('Name','xx_offspring',32);

    th.AddStringL('Name','xx_vimp',32);
    th.AddStringL('Name','xx_plants',32);
    th.AddStringL('Name','xx_ptree',32);
    th.AddStringL('Name','xx_rocks',32);
    th.AddStringL('Name','xx_tools',32);
    th.AddStringL('Name','xx_ambient',32);

    th2 := fbase.GetChildNode('<Objects>');
    th2.SearchInitNode;
    while th2.SearchNextNode do begin
      i := th2.getchildleaf('Type').getInt32;
      for j := 0 to length(includelist)-1 do
        if (includelist[j].n=i) then begin
          k := j;
          while (k<length(includelist)-1) and (includelist[k+1].n=i) do
            inc(k);
          // j thru k are all possible include files
          th3 := th;
          th3.SearchInitLeaf;
          while th3.SearchNextLeaf do
            for l := j to k do
              if includelist[l].name=th3.getString then
                i := 0;
          if i=0 then break; // done 'cause already included
          for m := 0 to length(prefer)-1 do if i<>0 then
            for l := j to k do
              if includelist[l].name=prefer[m] then begin
                th.AddStringL('Name',prefer[m],32);
                i := 0;
                break;
              end;
          if i=0 then break; // preferable file was found
          th.AddStringL('Name',includelist[j].name,32);
          break
        end;
    end;
    if not map.isopen then begin
      Application.MessageBox('Currently there''s no map open','Error');
      exit
    end;

    ZipMaster1.Load_Zip_Dll;
    ZipMaster1.ZipFileName := map.filename;

    if FileExists(ZipMaster1.ZipFileName) then begin
      ZipMaster1.FSpecArgsExcl.Clear;
      ZipMaster1.FSpecArgs.Clear;
      ZipMaster1.FSpecArgs.Add('w_*.bin');
      ZipMaster1.FSpecArgs.Add('*.gti');
      ZipMaster1.FSpecArgs.Add('*.gmm');
      ZipMaster1.FSpecArgs.Add('*.abx');
      ZipMaster1.Delete;
    end;

    if map.gtiname='' then
      map.gtiname := 'default.gti';
    if map.gtiname<>'' then begin
      data := SaveGTIToStream;
      ZipMaster1.ZipStream.SetPointer(@data[0],length(data));
      ZipMaster1.AddStreamToFile(map.gtiname);
      fbase.getchildnode('[FileStart]').getchildleaf('GtiName').setString(map.gtiname);
    end;

    if map.wbinname='' then
      map.wbinname := 'w_default.bin';
    if map.wbinname<>'' then begin
      data := SaveBinW;
      ZipMaster1.ZipStream.SetPointer(@data[0],length(data));
      ZipMaster1.AddStreamToFile(map.wbinname);
    end;

    gmmtext := '';
    if map.wbinname<>'' then begin
      gmmtext := gmmtext+'Modinfo_BinName='+map.wbinname+#13#10;
      Str(map.maptype,s);
      gmmtext := gmmtext+'Modinfo_BinType='+s+#13#10;
    end;
    if map.shareable then
      gmmtext := gmmtext+'Modinfo_Shareable'+#13#10;
    if map.usermessage<>'' then
      gmmtext := gmmtext+'Modinfo_UserMessage='+map.usermessage+#13#10;

    if map.gmmname='' then
      map.gmmname := 'default.gmm';

    for i := 0 to length(map.othertags)-1 do
      gmmtext := gmmtext+map.othertags[i]+#13#10;
      
    ZipMaster1.ZipStream.SetPointer(@gmmtext[1],length(gmmtext));
    ZipMaster1.AddStreamToFile(map.gmmname);

    for i := 0 to length(map.otherfiles)-1 do begin
      ZipMaster1.ZipStream.SetPointer(@map.otherfiles[i][0],length(map.otherfiles[i]));
      ZipMaster1.AddStreamToFile(map.otherfilenames[i]);
    end;

    SetLength(data,0);
    ZipMaster1.ZipFileName := '';
    ZipMaster1.Unload_Zip_Dll;
    savemap := true;
  end;

procedure TForm2.Saveterrainas1Click(Sender: TObject);
var
  s :string;
begin
  NewOpenMapDialog.FilterIndex := 1;
  NewOpenMapDialog.Title := 'Save map as...';
  if not NewOpenMapDialog.Execute then exit;
  s := NewOpenMapDialog.FileName;
  map.filename := s;
  ZipMaster1.ZipFileName := s;
  SaveMap1Click(sender);
  Caption := 'GiantsEdit 5.4 - '+s;
end;

procedure TForm2.ZipMaster1Message(Sender: TObject; ErrCode: Integer;
  msg: String);
  var
    s :string;
  begin
    if ErrCode=0 then begin
      if verbose then ConsoleFrame.WriteMessage('Zip: '+msg)
    end
    else begin
      if ErrCode=1279 then
        exit;
      Str(ErrCode,s);
      ConsoleFrame.WriteMessage('Zip error '+s+': '+msg);
    end
  end;

procedure TForm2.Optimizemapnoedges1Click(Sender: TObject);
  var
    x3,y3 :integer;
  begin
    for y3 := 0 to terrain.yl-2 do
      for x3 := 0 to terrain.xl-2 do
        if terrain.triangle[y3*terrain.xl+x3] and 7 in [5,6] then
          terrain.triangle[y3*terrain.xl+x3] :=
            terrain.triangle[y3*terrain.xl+x3] and 248+6-
            (ord(abs(terrain.height[y3*terrain.xl+(x3+1)]-terrain.height[(y3+1)*terrain.xl+x3])
               >abs(terrain.height[(y3+1)*terrain.xl+(x3+1)]-terrain.height[y3*terrain.xl+x3])));
  end;

procedure TForm2.Softenmapincludingedges1Click(Sender: TObject);

  function cornervalid(x,y :integer):boolean;
    begin
      if (x<0) or (y<0) or (x>=terrain.xl) or (y>=terrain.yl) then begin
        cornervalid := false;
        exit
      end;
      cornervalid :=
          (x>0)            and (y>0)            and (terrain.triangle[(y-1)*terrain.xl+(x-1)] and 7 in [2,3,4,5,6,7])
       or (x<terrain.xl-1) and (y>0)            and (terrain.triangle[(y-1)*terrain.xl+ x   ] and 7 in [1,2,4,5,6,7])
       or (x>0)            and (y<terrain.yl-1) and (terrain.triangle[ y   *terrain.xl+(x-1)] and 7 in [1,2,3,5,6])
       or (x<terrain.xl-1) and (y<terrain.yl-1) and (terrain.triangle[ y   *terrain.xl+ x   ] and 7 in [1,3,4,5,6,7])
    end;

  var
    x3,y3 :integer;
  begin
    for y3 := 0 to terrain.yl-2 do
      for x3 := 0 to terrain.xl-2 do
        case ord(cornervalid(x3,y3))+2*ord(cornervalid(x3+1,y3))
          +4*ord(cornervalid(x3,y3+1))+8*ord(cornervalid(x3+1,y3+1)) of
            0,1,2,4,8,6,9,3,5,10,12:; // piece was empty and stays empty
            7:terrain.triangle[y3*terrain.xl+x3] :=
              terrain.triangle[y3*terrain.xl+x3] and 248+1;
            11:terrain.triangle[y3*terrain.xl+x3] :=
              terrain.triangle[y3*terrain.xl+x3] and 248+3;
            13:terrain.triangle[y3*terrain.xl+x3] :=
              terrain.triangle[y3*terrain.xl+x3] and 248+7;
            14:terrain.triangle[y3*terrain.xl+x3] :=
              terrain.triangle[y3*terrain.xl+x3] and 248+2;
            15:terrain.triangle[y3*terrain.xl+x3] :=
              terrain.triangle[y3*terrain.xl+x3] and 248+6-
              (ord(abs(terrain.height[y3*terrain.xl+(x3+1)]-terrain.height[(y3+1)*terrain.xl+x3])
                  >abs(terrain.height[(y3+1)*terrain.xl+(x3+1)]-terrain.height[y3*terrain.xl+x3])));
        end;
  end;

procedure TForm2.Clearterrain2Click(Sender: TObject);
  const
    TriaTab :array[false..true,false..true] of byte=((0,3),(7,5));
    trshp :array[0..3] of byte=(2,7,3,1);
  var
    i,x,y :longint;
    x1,y1,x2,y2,x1_,y1_,x2_,y2_ :single;
    c00,c01,c10,c11 :boolean;
  begin
    if NewMapDialog.ShowModal<>mrOk then
      exit;
    with terrainheader do begin
      signature := -1802088445;
      u0 := 0;
      minheight := -40;
      maxheight := 1000;
      xl := NewMapDialog.xl;
      yl := NewMapDialog.yl;
      u1 := 0.5;
      u2 := 0.5;
      u3 := 1.25e-4;
      u4 := 1.25e-4;
      version := 3;
      u6 := 1;
      u7 := 0;
      u8 := 1;
      texture := 'useless';
    end;
    with terrain do begin
      stretch := 40;
      xoffset := xl*stretch*-0.5;
      yoffset := yl*stretch*-0.5;
    end;
    UpdateTerrainHeader;
    Terrain.SetSize(terrainheader.xl,terrainheader.yl);
    Terrain.Clear;
    case NewMapDialog.filltype of
      0:for i := 0 to terrain.xl*terrain.yl-1 do
          terrain.triangle[i] := 0;
      1:;
      2:for y := 0 to terrain.yl-2 do
          for x := 0 to terrain.xl-2 do begin
            // imagine a big circle which touches all 4 outer edges.
            // check each cell against the circle.
            // completely coverd/outside? => fill/clear cell
            // otherwise check the two points at which the circle enters/leaves the cell
            // (when there are more than 2 points ignore the in-between points)
            // bring each point to the closest corner
            // when both are on the same edge fill/clear the cell otherwise put in a triangle

            // all cells sit in one "quadrant". cells which sit in-between are always filled.
            if (x*2+2=terrain.xl) or (y*2+2=terrain.yl) then begin
              terrain.triangle[y*terrain.xl+x] := 5;
              continue
            end;

            // this gets a box in the first quadrant on the circle x²+y²=1
            if x*2+2>terrain.xl then begin
              x1 := ((x+0)/(terrain.xl-1))*2-1;
              x2 := ((x+1)/(terrain.xl-1))*2-1;
            end
            else begin
              x1 := ((terrain.xl-1-(x+1))/(terrain.xl-1))*2-1;
              x2 := ((terrain.xl-1-(x+0))/(terrain.xl-1))*2-1;
            end;

            if y*2+2>terrain.yl then begin
              y1 := ((y+0)/(terrain.yl-1))*2-1;
              y2 := ((y+1)/(terrain.yl-1))*2-1;
            end
            else begin
              y1 := ((terrain.yl-1-(y+1))/(terrain.yl-1))*2-1;
              y2 := ((terrain.yl-1-(y+0))/(terrain.yl-1))*2-1;
            end;

            // is box completely inside/outside circle?
            if (sqr(x1)+sqr(y1)>1) then begin
              terrain.triangle[y*terrain.xl+x] := 0;
              continue
            end;
            if (sqr(x2)+sqr(y2)<1) then begin
              terrain.triangle[y*terrain.xl+x] := 5;
              continue
            end;

            // we know that box hits circle. Go get the collision points!
            c00 := false;
            c01 := false;
            c10 := false;
            c11 := false;

            y1_ := sqrt(1-sqr(x1));
            x1_ := sqrt(1-sqr(y1));
            y2_ := sqrt(1-sqr(x2));
            x2_ := sqrt(1-sqr(y2));

            // (x1,y1_) (x1_,y1) (x2,y2_) (x2_,y2) are possible collision points. check them!
            if (y1<y1_) and (y1_<y2) then
              if y1_<(y1+y2)/2 then
                c00 := true
              else
                c01 := true;
            if (y1<y2_) and (y2_<y2) then
              if y2_<(y1+y2)/2 then
                c10 := true
              else
                c11 := true;

            if (x1<x1_) and (x1_<x2) then
              if x1_<(x1+x2)/2 then
                c00 := true
              else
                c10 := true;
            if (x1<x2_) and (x2_<x2) then
              if x2_<(x1+x2)/2 then
                c01 := true
              else
                c11 := true;
            case ord(c00)+2*ord(c10)+4*ord(c01)+8*ord(c11) of
              3,5:terrain.triangle[y*terrain.xl+x] := 0;
              1:terrain.triangle[y*terrain.xl+x] := 0;
              8:terrain.triangle[y*terrain.xl+x] := 5;
              10,12:terrain.triangle[y*terrain.xl+x] := 5;
              6,9:terrain.triangle[y*terrain.xl+x] := trshp[ord(x*2+1>terrain.xl)+2*ord(y*2+1>terrain.yl)];
              else begin
                Application.MessageBox('There was a problem constructing this shape.'#13'Please contact the author and don''t forget to specify'#13'the choices you made','Error');
                terrain.triangle[y*terrain.xl+x] := 0
              end;
            end;
          end;
(*            terrain.triangle[y*terrain.xl+x] := triatab[
              sqr((x+1/3)/(terrain.xl-1)-0.5)+sqr((y+2/3)/(terrain.yl-1)-0.5)<=0.25,
              sqr((x+2/3)/(terrain.xl-1)-0.5)+sqr((y+1/3)/(terrain.yl-1)-0.5)<=0.25];*)
    end;
  end;

procedure TForm2.Clearterrain1Click(Sender: TObject);
begin
  fbase.GetChildNode('<Objects>').Delete;
  fbase.AddNode('<Objects>');
end;

procedure TForm2.Setmaptype1Click(Sender: TObject);
begin
  MapNamesDlg.ShowModal;
end;

procedure TForm2.Closemap1Click(Sender: TObject);
begin
  if map.isopen then
    case Application.MessageBox('Save map before closing?','Question',MB_YESNOCANCEL) of
      IDYES:Savemap1Click(nil);
      IDCANCEL:exit
    end;
  mapclose
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if map.isopen then
    case Application.MessageBox('Save map before closing?','Question',MB_YESNOCANCEL) of
      IDYES:begin
        Savemap1Click(nil);
        CanClose := true
      end;
      IDCANCEL:CanClose := false;
      IDNO:CanClose := true;
    end
  else
    CanClose := true;
end;

procedure TForm2.Displaynonerrormessages1Click(Sender: TObject);
begin
  Displaynonerrormessages1.Checked := not Displaynonerrormessages1.Checked;
  verbose := Displaynonerrormessages1.Checked;
end;

procedure TForm2.Placeallobjectonsurface1Click(Sender: TObject);
  var
    node :tTreeHandle;
    x,y,z,z2 :single;
    xi,yi :integer;
    b :byte;
  begin
    node := wrapper.Tree.getChildNode('<Objects>');
    node.SearchInitNode;
    while node.SearchNextNode do begin
      x := node.GetChildLeaf('X').getSingle;
      y := node.GetChildLeaf('Y').getSingle;
      z := node.GetChildLeaf('Z').getSingle;
      if z<0 then z := 0;
      if (x<terrain.xoffset) or (y<terrain.yoffset) or
       (x>terrain.xoffset+terrain.stretch*(terrain.xl-1)) or
       (y>terrain.yoffset+terrain.stretch*(terrain.yl-1)) then begin
      end
      else begin
        x := (x-terrain.xoffset)/terrain.stretch;
        y := (y-terrain.yoffset)/terrain.stretch;
        xi := trunc(x);
        if xi>=terrain.xl-1 then xi := terrain.xl-2;
        if xi<0 then xi := 0;
        x := x-xi;
        yi := trunc(y);
        if yi>=terrain.yl-1 then yi := terrain.yl-2;
        if yi<0 then yi := 0;
        y := y-yi;

        z2 := 0;
        b := terrain.triangle[yi*terrain.xl+xi] and 7;
        if (b=4) or (b=5) or (b=7) then
          if (y-x>=0) then
            z2 := terrain.height[(yi  )*terrain.xl+(xi  )]*(1-y)
                 +terrain.height[(yi+1)*terrain.xl+(xi  )]*(y-x)
                 +terrain.height[(yi+1)*terrain.xl+(xi+1)]*x;
        if (b=5) or (b=3) then
          if (y-x<=0) then
            z2 := terrain.height[(yi  )*terrain.xl+(xi  )]*(1-x)
                 +terrain.height[(yi  )*terrain.xl+(xi+1)]*(x-y)
                 +terrain.height[(yi+1)*terrain.xl+(xi+1)]*y;
        if (b=1) or (b=6) then
          if (y+x<1) then
            z2 := terrain.height[(yi  )*terrain.xl+(xi  )]*(1-x-y)
                 +terrain.height[(yi+1)*terrain.xl+(xi  )]*y
                 +terrain.height[(yi  )*terrain.xl+(xi+1)]*x;
        if (b=2) or (b=6) then
          if (y+x>=1) then
            z2 := terrain.height[(yi+1)*terrain.xl+(xi  )]*(1-x)
                 +terrain.height[(yi  )*terrain.xl+(xi+1)]*(1-y)
                 +terrain.height[(yi+1)*terrain.xl+(xi+1)]*(x+y-1);
        if z2>z then z := z2;
      end;
      node.GetChildLeaf('Z').setSingle(z);
    end;
    Draww;
  end;

procedure TForm2.Mapnames1Click(Sender: TObject);
begin
  MapNamesDlg.showmodal;
end;

procedure TForm2.Cameramode1Click(Sender: TObject);
begin
  SpeedButton1Click(nil);
end;

procedure TForm2.Heighteditor1Click(Sender: TObject);
begin
  SpeedButton2Click(nil);
end;

procedure TForm2.Lighteditor1Click(Sender: TObject);
begin
  SpeedButton3Click(nil);
end;

procedure TForm2.riangleeditor1Click(Sender: TObject);
begin
  SpeedButton7Click(nil);
end;

procedure TForm2.Objecteditingmode1Click(Sender: TObject);
begin
  SpeedButton8Click(nil);
end;

procedure TForm2.SpecUpdate;
  const
    startx = 536;
    xlen = 60;
    tflen = 55;
    ylev1 = 4;
    ylev2 = 26;
  var
    i,j,x :integer;
  begin
    Button1.Enabled := true;
    apLight.Checked := specactive[0];
    apSpecial.Checked := specactive[1];
    apVimp.Checked := specactive[2];
    apMeccShop.Checked := specactive[3];
    apReaperShop.Checked := specactive[4];
    x := startx;
    for i := 0 to length(specactive)-1 do
      if specactive[i] then begin
        for j := 0 to length(spec[i])-1 do begin
          spec[i,j].Show;
          spec[i,j].Left := x+xlen*(j mod ((length(spec[i])+1) div 2));
          if j<((length(spec[i])+1) div 2) then
            spec[i,j].Top := ylev1
          else
            spec[i,j].Top := ylev2;
          if j>=1 then
            spec[i,j].Width := tflen;
        end;
        inc(x,xlen*((length(spec[i])+1) div 2));
      end
      else begin
        for j := 0 to length(spec[i])-1 do
          spec[i,j].Hide;
      end;
  end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Button1.PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TForm2.aplightClick(Sender: TObject);
  begin
    specactive[0] := not specactive[0];
    if specactive[0] then begin
      MapObject.AddSingle('LightColor 0',0).BindEdit(Obj_light1);
      MapObject.AddSingle('LightColor 1',0).BindEdit(Obj_light2);
      MapObject.AddSingle('LightColor 2',0).BindEdit(Obj_light3);
    end
    else begin
      MapObject.GetChildLeaf('LightColor 0').UnbindEdit;
      MapObject.GetChildLeaf('LightColor 1').UnbindEdit;
      MapObject.GetChildLeaf('LightColor 2').UnbindEdit;
      MapObject.GetChildLeaf('LightColor 0').Delete;
      MapObject.GetChildLeaf('LightColor 1').Delete;
      MapObject.GetChildLeaf('LightColor 2').Delete;
    end;
    SpecUpdate;
  end;

procedure TForm2.Missions1Click(Sender: TObject);
  begin
    Form11.Show;
    Form11.BringToFront;
  end;

procedure TForm2.Missionobjectstreeview1Click(Sender: TObject);
  begin
    if wmbaseidx=-1 then begin
      Application.MessageBox('Mission tree is not available when no mission is active. Go to "Missions..." and select one.','Error',MB_OK);
      exit
    end;
    Form10.Show;
    Form10.BringToFront;
  end;

procedure TForm2.Worldobjectsvisible1Click(Sender: TObject);
  begin
    WorldObjectsVisible1.Checked := not WorldObjectsVisible1.Checked;
    drawwobjects := WorldObjectsVisible1.Checked;
  end;

procedure TForm2.Worldobjectseditable1Click(Sender: TObject);
  begin
    Worldobjectseditable1.Checked := not Worldobjectseditable1.Checked;
    editwobjects := Worldobjectseditable1.Checked;
  end;

procedure TForm2.Missionobjectsvisible1Click(Sender: TObject);
  begin
    Missionobjectsvisible1.Checked := not Missionobjectsvisible1.Checked;
    drawwmobjects := Missionobjectsvisible1.Checked;
  end;

procedure TForm2.Missionobjectseditable1Click(Sender: TObject);
  begin
    Missionobjectseditable1.Checked := not Missionobjectseditable1.Checked;
    editwmobjects := Missionobjectseditable1.Checked;
  end;

procedure TForm2.Exporttestfeature1Click(Sender: TObject);
var
  pic :TPicture;
  i,x,y :integer;
  pal: PLogPalette;
begin
{  if ExportMapDialog.Execute then begin
    pic := TPicture.Create;
    pic.bitmap.Width := terrain.xl;
    pic.bitmap.Height := terrain.yl;
    pic.bitmap.PixelFormat := pf8bit;
    GetMem(pal, sizeof(TLogPalette) + sizeof(TPaletteEntry) * 255);
    pal.palVersion := $300;
    pal.palNumEntries := 256;
    for i := 0 to 255 do begin
      pal.palPalEntry[i].peRed  := i;
      pal.palPalEntry[i].peGreen:= i;
      pal.palPalEntry[i].peBlue := i;
    end;
    pic.Bitmap.Palette := CreatePalette(pal^);
    for y := 0 to terrain.yl-1 do
      for x := 0 to terrain.xl-1 do
        pic.Bitmap.Canvas.Pixels[x,Terrain.yl-1-y] :=
          terrain.unknown[y*terrain.xl+x]+16777216;
    pic.SaveToFile(ExportMapDialog.FileName);
    pic.Destroy;
  end;}
end;

procedure TForm2.Drawrealobjects1Click(Sender: TObject);
  begin
    DrawRealObjects1.Checked := not DrawRealObjects1.Checked;
    DrawRealObjects :=  DrawRealObjects1.Checked;
  end;

procedure TForm2.ExporttoAGSPTmapformat1Click(Sender: TObject);
  var
    vTop,vLeft,vBottom,vRight :integer;
    terrain2 :tMap;
    x,y,n,i :longint;
  begin
    x := terrain.xl-1;
    n := 0;
    while x>0 do begin
      x := x shr 1;
      inc(n)
    end;
    for i := 0 to n do
      x := x * 2;
    x := terrain.yl-1;
    n := 0;
    while y>0 do begin
      y := y shr 1;
      inc(n)
    end;
    for i := 0 to n do
      y := y * 2;
    vTop := (y-terrain.yl) div 2;
    vBottom := (y-terrain.yl+1) div 2;
    vLeft := (x-terrain.xl) div 2;
    vRight := (x-terrain.xl+1) div 2;

    // apply the changes
    terrain2 := tMap.Create;
    terrain2.SetSize(x,y);
    terrain2.Clear;
    terrain2.stretch := terrain.stretch;
    terrain2.xoffset := terrain.xoffset-terrain.stretch*vLeft;
    terrain2.yoffset := terrain.yoffset-terrain.stretch*vTop;
    for y := 0 to terrain.yl-1 do
      for x := 0 to terrain.xl-1 do begin
        terrain2.light[(y+vTop)*terrain2.xl+(x+vLeft)] := terrain.light[y*terrain.xl+x];
        terrain2.height[(y+vTop)*terrain2.xl+(x+vLeft)] := terrain.height[y*terrain.xl+x];
      end;

    for y := 0 to terrain.yl-2 do
      for x := 0 to terrain.xl-2 do
        terrain2.triangle[(y+vTop)*terrain2.xl+(x+vLeft)] := terrain.triangle[y*terrain.xl+x];

    terrain.Destroy;
    terrain := terrain2;

    (*** export light map and height map here ***)
  end;

procedure TForm2.Viewterrainmesh1Click(Sender: TObject);
begin
  ViewTerrainMesh1.Checked := not ViewTerrainMesh1.Checked;
end;

procedure TForm2.Modeldebugger1Click(Sender: TObject);
begin
  Form12.Show;
end;

end.
