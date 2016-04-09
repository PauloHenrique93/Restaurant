object Form1: TForm1
  Left = 192
  Top = 125
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 633
  ClientWidth = 1172
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object restaurantPanel: TPanel
    Left = 40
    Top = 8
    Width = 569
    Height = 401
    Caption = 'restaurantPanel'
    TabOrder = 0
    object localScrollBox: TScrollBox
      Left = -16
      Top = -16
      Width = 585
      Height = 417
      HorzScrollBar.Visible = False
      TabOrder = 0
    end
  end
  object addLocalButton: TButton
    Left = 160
    Top = 464
    Width = 41
    Height = 25
    Caption = 'Add'
    TabOrder = 1
    OnClick = addLocalButtonClick
  end
  object localNameEdit: TEdit
    Left = 32
    Top = 464
    Width = 121
    Height = 21
    TabOrder = 2
    OnKeyDown = localNameEditKeyDown
  end
  object newLocalButton: TButton
    Left = 32
    Top = 432
    Width = 75
    Height = 25
    Caption = 'Novo Local'
    TabOrder = 3
    OnClick = newLocalButtonClick
  end
end
