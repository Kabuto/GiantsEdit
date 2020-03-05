object Form11: TForm11
  Left = 416
  Top = 266
  Width = 204
  Height = 96
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Missions (right-click for further options)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 196
    Height = 69
    Align = alClient
    ItemHeight = 13
    Items.Strings = (
      '- none -')
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnClick = ListBox1Click
    OnDblClick = ListBox1DblClick
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 96
    Top = 8
    object Newmission1: TMenuItem
      Caption = 'New mission...'
      OnClick = Newmission1Click
    end
    object Importmission1: TMenuItem
      Caption = 'Import mission...'
      OnClick = Importmission1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Exportmission1: TMenuItem
      Caption = 'Export mission...'
    end
    object Deletemission1: TMenuItem
      Caption = 'Delete mission...'
      OnClick = Deletemission1Click
    end
  end
  object OpenMissionDlg: TOpenDialog
    Filter = 'Giants missions (WM_*.BIN)|wm_*.bin|All files (*.*)|*.*'
    Left = 24
    Top = 16
  end
  object SaveMissionDlg: TSaveDialog
    Filter = 'Giants missions (WM_*.BIN)|wm_*.bin|All files (*.*)|*.*'
    Left = 56
    Top = 16
  end
end
