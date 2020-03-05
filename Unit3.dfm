object Form3: TForm3
  Left = 1071
  Top = 161
  Width = 379
  Height = 410
  Caption = 'GTI header editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 364
    Width = 371
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ValueListEditor1: TValueListEditor
    Left = 0
    Top = 0
    Width = 371
    Height = 364
    Align = alClient
    Strings.Strings = (
      '')
    TabOrder = 1
    OnExit = ValueListEditor1Exit
    OnKeyPress = ValueListEditor1KeyPress
    OnSelectCell = ValueListEditor1SelectCell
    ColWidths = (
      150
      215)
  end
end
