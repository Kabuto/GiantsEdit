object ABXWhichLOD: TABXWhichLOD
  Left = 297
  Top = 125
  Width = 211
  Height = 270
  Caption = 'ABXWhichLOD'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 203
    Height = 243
    Align = alClient
    Columns = <
      item
        Caption = 'LODValue'
      end
      item
        Caption = 'Box'
      end>
    TabOrder = 0
    ViewStyle = vsReport
    OnSelectItem = ListView1SelectItem
  end
end
