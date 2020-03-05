object ConsoleFrame: TConsoleFrame
  Left = 220
  Top = 134
  Width = 459
  Height = 358
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'GiantsEdit Console (can be resized)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 284
    Width = 451
    Height = 47
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      451
      47)
    object Edit1: TEdit
      Left = 0
      Top = 0
      Width = 451
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnKeyDown = Edit1KeyDown
    end
    object Button1: TButton
      Left = 0
      Top = 22
      Width = 121
      Height = 25
      Caption = 'Copy text to clipboard'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 330
      Top = 22
      Width = 121
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save text as...'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 128
      Top = 22
      Width = 195
      Height = 25
      Hint = 
        'Press this button if you want to stop debug messages from appear' +
        'ing'
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Pause'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 451
    Height = 284
    Align = alClient
    Color = 8396800
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clAqua
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 96
    Top = 144
  end
end
