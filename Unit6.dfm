object Form3: TForm3
  Left = 574
  Top = 326
  Width = 510
  Height = 378
  Caption = 'Map objects tree view (for experts only)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnHide = FormHide
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter4: TSplitter
    Left = 259
    Top = 0
    Width = 3
    Height = 332
    Cursor = crHSplit
    OnMoved = Splitter4Moved
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 259
    Height = 332
    Align = alLeft
    BevelInner = bvNone
    Indent = 19
    PopupMenu = PopupMenu1
    ReadOnly = True
    RightClickSelect = True
    TabOrder = 0
    Items.Data = {
      01000000330000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
      1A456D70747920286C6F616420612066696C652066697273742129}
  end
  object ScrollBox1: TScrollBox
    Left = 262
    Top = 0
    Width = 240
    Height = 332
    HorzScrollBar.Visible = False
    Align = alClient
    BevelInner = bvNone
    BorderStyle = bsNone
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 332
    Width = 502
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Map object files (W_*.BIN)|w_*.bin|All files (*.*)|*.*'
    Left = 240
    Top = 176
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 256
    Top = 232
    object Delete1: TMenuItem
      Caption = 'Delete'
    end
    object Insertchild1: TMenuItem
      Caption = 'Insert child...'
    end
    object Sortchilds1: TMenuItem
      Caption = 'Sort childs'
    end
    object Cut1: TMenuItem
      Caption = 'Cut'
      OnClick = Cut1Click
    end
    object Pasteasnewchild1: TMenuItem
      Caption = 'Paste as new child'
      OnClick = Pasteasnewchild1Click
    end
  end
end
