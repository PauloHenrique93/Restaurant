object Form1: TForm1
  Left = 192
  Top = 125
  Width = 1188
  Height = 672
  Caption = 'Form1'
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
    Width = 545
    Height = 401
    Caption = 'restaurantPanel'
    TabOrder = 0
  end
  object addLocalButton: TButton
    Left = 608
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Novo Local'
    TabOrder = 1
    OnClick = addLocalButtonClick
  end
end
