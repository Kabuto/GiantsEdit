object ABXmanager: TABXmanager
  Left = 75
  Top = 390
  Width = 783
  Height = 540
  Caption = 'ABXmanager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 475
    Width = 775
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 775
    Height = 475
    Align = alClient
    Columns = <
      item
        Caption = 'Name'
      end
      item
        Caption = 'LoD levels'
      end
      item
        Caption = 'First LoD level'
      end>
    TabOrder = 1
    ViewStyle = vsReport
    OnSelectItem = ListView1SelectItem
  end
  object MainMenu1: TMainMenu
    Left = 280
    Top = 112
    object Init1: TMenuItem
      Caption = 'Init'
      object CollectABXdata1: TMenuItem
        Caption = 'Collect ABX data...'
        OnClick = CollectABXdata1Click
      end
    end
    object Item1: TMenuItem
      Caption = 'Item'
      object Display1: TMenuItem
        Caption = 'Display'
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Giants bounding box (*.ABX)|*.abx|All files (*.*)|*.*'
    InitialDir = 'E:\spiele\giants\Bin'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 224
    Top = 184
  end
end
