{
  https://blog.csdn.net/QDseashore/article/details/7731240
  https://blog.csdn.net/u010579736/article/details/51880840
  http://edn.embarcadero.com/article/26401

}

unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  walk, OpenGL, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    tmr1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  aWalker: Twalker;
  Npoints: Integer;

implementation

{$R *.dfm}

procedure setupPixelFormat(DC: HDC);
const
  pfd: TPIXELFORMATDESCRIPTOR = (
    nSize: sizeof(TPIXELFORMATDESCRIPTOR); // size
    nVersion: 1; // version
    dwFlags: PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or PFD_DOUBLEBUFFER;
    // support double-buffering
    iPixelType: PFD_TYPE_RGBA; // color type
    cColorBits: 24; // preferred color depth
    cRedBits: 0;
    cRedShift: 0; // color bits (ignored)
    cGreenBits: 0;
    cGreenShift: 0;
    cBlueBits: 0;
    cBlueShift: 0;
    cAlphaBits: 0;
    cAlphaShift: 0; // no alpha buffer
    cAccumBits: 0;
    cAccumRedBits: 0; // no accumulation buffer,
    cAccumGreenBits: 0; // accum bits (ignored)
    cAccumBlueBits: 0;
    cAccumAlphaBits: 0;
    cDepthBits: 16; // depth buffer
    cStencilBits: 0; // no stencil buffer
    cAuxBuffers: 0; // no auxiliary buffers
    iLayerType: PFD_MAIN_PLANE; // main layer
    bReserved: 0;
    dwLayerMask: 0;
    dwVisibleMask: 0;
    dwDamageMask: 0;
    // no layer, visible, damage masks
  );
var
  pixelFormat: Integer;
begin
  pixelFormat := ChoosePixelFormat(DC, @pfd);
  if (pixelFormat = 0) then
    exit;
  if (SetPixelFormat(DC, pixelFormat, @pfd) <> TRUE) then
    exit;

end;

procedure GLInit;
begin
  // set viewing projection
  glMatrixMode(GL_PROJECTION);
  // glFrustum(-0.1, 0.1, -0.1, 0.1, 0.3, 25.0);
  glOrtho(-1, 1, -1, 1, 0, 0);
  // position viewer
  glMatrixMode(GL_MODELVIEW);
  glEnable(GL_DEPTH_TEST);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  aWalker.Free;
  pointsList.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  DC: HDC;
  RC: HGLRC;
begin
  DC := GetDC(Self.Handle); // Actually, you can use any windowed control here
  setupPixelFormat(DC);
  RC := wglCreateContext(DC); // makes OpenGL window out of DC
  wglMakeCurrent(DC, RC); // makes OpenGL window active
  GLInit; // initialize OpenGL
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  aWalker := Twalker.Create(1, 1);
  pointsList := TStringlist.Create;
  pointsList.Sorted := true;
  pointsList.Duplicates := dupIgnore;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
  aWalker.step;
  Npoints := pointsList.Count;
  if Npoints = High(Integer) - 1 then
    tmr1.Enabled := false;
  pointsList.Add(floatToStr(aWalker.x) + '|' + floatToStr(aWalker.y));
  Caption := IntToStr(pointsList.Count);
  aWalker.display;
end;

end.

