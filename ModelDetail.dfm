object Form12: TForm12
  Left = 192
  Top = 103
  Width = 624
  Height = 318
  Caption = 'Model debugger'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 616
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 46
      Height = 13
      Caption = 'Model ID:'
    end
    object Edit1: TEdit
      Left = 56
      Top = 4
      Width = 81
      Height = 21
      TabOrder = 0
    end
    object Button1: TButton
      Left = 144
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Load'
      Default = True
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 33
    Width = 616
    Height = 239
    Align = alClient
    Columns = <
      item
        Caption = 'Name'
      end
      item
        Caption = 'Index'
      end
      item
        Caption = 'Texture'
      end
      item
        Caption = 'Bump texture'
      end
      item
        Caption = 'Falloff'
      end
      item
        Caption = 'Blend'
      end
      item
        Caption = 'Flags'
      end
      item
        Caption = 'Emissive'
      end
      item
        Caption = 'Ambient'
      end
      item
        Caption = 'Diffuse'
      end
      item
        Caption = 'Specular'
      end
      item
        Caption = 'Power'
      end>
    TabOrder = 1
    ViewStyle = vsReport
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 272
    Width = 616
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object CheckBox1: TCheckBox
    Left = 248
    Top = 8
    Width = 97
    Height = 17
    Caption = 'Clear on load'
    TabOrder = 3
  end
end
