unit walk;

interface

uses
  OpenGL, Winapi.Windows;

type
  Twalker = class
  private
    x, y: Double;
  public
    constructor Create(width, height: Double);
    procedure display();
    procedure step();
  end;

implementation

{ Twalker }

procedure point(x, y: double);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glLoadIdentity;
  glTranslatef(0.0, 0.0, 0.0);
  glPointSize(2);
  glBegin(GL_POINTS);
  glVertex2f(x, y);  //draw a point
  glEnd;
  SwapBuffers(wglGetCurrentDC);
end;

constructor Twalker.Create(width, height: double);
begin
//  x := width / 2;
//  y := height / 2;
  x := 0;
  y := 0;
end;

procedure Twalker.display();
begin
  point(x, y);
end;

procedure Twalker.step;
var
  p: integer;
  d: Double;
begin
  d := 0.01;
  Randomize;
  p := Random(4);
  if p = 0 then
    x := x + d;
  if p = 1 then
    x := x - d;
  if p = 2 then
    y := y + d;
  if p = 3 then
    y := y - d;
  exit;
  if x > 1 then
    x := x - d;
  if x < -1 then
    x := x + d;
  if y > 1 then
    y := y - d;
  if y < -1 then
    y := y + d;
end;

end.
