object TestClientForm: TTestClientForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1050#1083#1080#1077#1085#1090' '#1076#1083#1103' '#1090#1077#1089#1090#1086#1074
  ClientHeight = 552
  ClientWidth = 827
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ResponseMemo: TMemo
    Left = 0
    Top = 432
    Width = 827
    Height = 120
    Align = alBottom
    TabOrder = 0
  end
  object RequestMemo: TMemo
    Left = 0
    Top = 327
    Width = 827
    Height = 105
    Align = alBottom
    TabOrder = 1
    OnDragDrop = RequestMemoDragDrop
    OnDragOver = RequestMemoDragOver
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 8
    Width = 481
    Height = 313
    TabOrder = 2
    OnMouseUp = StringGrid1MouseUp
    RowHeights = (
      24
      24
      24
      24
      24)
  end
  object StringGrid2: TStringGrid
    Left = 512
    Top = 8
    Width = 307
    Height = 313
    ScrollBars = ssVertical
    TabOrder = 3
    OnMouseUp = StringGrid2MouseUp
  end
  object HTTP: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 8
  end
  object MainMenu1: TMainMenu
    Left = 48
    object N1: TMenuItem
      Caption = #1052#1077#1085#1102
      OnClick = Menu
    end
    object N4: TMenuItem
      Caption = #1082#1091#1088#1100#1077#1088#1099
      object N7: TMenuItem
        Caption = #1042#1089#1077' '#1082#1091#1088#1100#1077#1088#1099
      end
      object N2: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1091#1088#1100#1077#1088#1072
      end
      object N3: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1091#1088#1100#1077#1088#1072
      end
      object id1: TMenuItem
        Caption = #1047#1072#1087#1080#1089#1100' '#1087#1086' id'
      end
      object N9: TMenuItem
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1082#1091#1088#1100#1077#1088#1072
      end
    end
    object N5: TMenuItem
      Caption = #1086#1087#1077#1088#1072#1090#1086#1088#1099
      object N12: TMenuItem
        Caption = #1042#1089#1077' '#1086#1087#1077#1088#1072#1090#1086#1088#1099
      end
      object N11: TMenuItem
        Caption = #1054#1087#1077#1088#1072#1090#1086#1088' '#1087#1086' id'
      end
      object N10: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
        OnClick = operatorAdd
      end
      object N13: TMenuItem
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
        OnClick = operatorUpdate
      end
      object N15: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
        OnClick = operatorDelete
      end
    end
    object N6: TMenuItem
      Caption = #1047#1072#1082#1072#1079#1099
      object N8: TMenuItem
        Caption = #1048#1089#1090#1086#1088#1080#1103' '#1079#1072#1082#1072#1079#1086#1074
      end
    end
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer
    Left = 792
    Top = 8
  end
end