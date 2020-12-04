object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = #1053#1086#1074#1086#1089#1090#1080
  ClientHeight = 674
  ClientWidth = 715
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlRCC: TPanel
    Left = 0
    Top = 0
    Width = 715
    Height = 617
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'pnlRCC'
    ShowCaption = False
    TabOrder = 0
    object lvRCC: TListView
      Left = 1
      Top = 1
      Width = 713
      Height = 615
      Align = alClient
      Columns = <
        item
        end>
      TabOrder = 0
      ViewStyle = vsReport
      ExplicitLeft = 2
      ExplicitTop = 4
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 617
    Width = 715
    Height = 57
    Align = alBottom
    BevelOuter = bvLowered
    Caption = 'pnlButtons'
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      715
      57)
    object btnShowNews: TBitBtn
      Left = 552
      Top = 8
      Width = 153
      Height = 41
      Anchors = [akRight, akBottom]
      Caption = #1055#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1085#1086#1074#1086#1089#1090#1080
      TabOrder = 0
      OnClick = btnShowNewsClick
    end
  end
end
