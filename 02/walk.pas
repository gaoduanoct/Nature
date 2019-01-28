unit walk;

interface

uses
  OpenGL, Winapi.Windows, System.Classes, System.SysUtils, Vcl.Dialogs;

type
  Twalker = class
  private
  public
    x, y: Double;
    constructor Create(width, height: Double);
    procedure display();
    procedure step();
  end;

var
  pointsList: TStringlist;

implementation

{ Twalker }

procedure point(x, y: Double);
var
  n: integer;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glLoadIdentity;
  glTranslatef(0.0, 0.0, 0.0);
  glPointSize(0);
  glBegin(GL_POINTS);
  for n := 0 to pointsList.Count - 1 do
  begin
    x := strTofloat(copy(pointsList[n], 1, pos('|', pointsList[n]) - 1));
    y := strTofloat(copy(pointsList[n], pos('|', pointsList[n]) + 1, length(pointsList[n]) - pos('|', pointsList[n])));
    glVertex2f(x, y); // draw a point
  end;
  glEnd;
  SwapBuffers(wglGetCurrentDC);
end;

constructor Twalker.Create(width, height: Double);
begin
  x := 0.00001;
  y := 0.00001;
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
  p := Random(9);
  //right
  if p = 0 then
    x := x + d;
  //left
  if p = 1 then
    x := x - d;
  //up
  if p = 2 then
    y := y + d;
  //down
  if p = 3 then
    y := y - d;
  //right up    1
  if p = 4 then
  begin
    x := x + 1.41421 * d;
    y := y + 1.41421 * d;
  end;
  //left up    2
  if p = 5 then
  begin
    x := x - 1.41421 * d;
    y := y + 1.41421 * d;
  end;
  //left down   3
  if p = 6 then
  begin
    x := x - 1.41421 * d;
    y := y - 1.41421 * d;
  end;
  //right down   4
  if p = 7 then
  begin
    x := x + 1.41421 * d;
    y := y - 1.41421 * d;
  end;
  if p = 8 then
    ;
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

