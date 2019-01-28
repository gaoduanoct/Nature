object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = '_1_1_randomDistributton'
  ClientHeight = 201
  ClientWidth = 918
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tmr1: TTimer
    Interval = 50
    OnTimer = tmr1Timer
    Left = 532
    Top = 104
  end
end
