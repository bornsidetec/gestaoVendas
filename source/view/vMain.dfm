object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'Gest'#227'o de Vendas'
  ClientHeight = 583
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 564
    Width = 833
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 200
      end>
  end
  object MainMenu: TMainMenu
    Left = 392
    Top = 8
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Clientes1: TMenuItem
        Action = actClientes
      end
      object Produtos1: TMenuItem
        Action = actProdutos
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object Pedidos1: TMenuItem
        Action = actPedidos
      end
    end
    object Ajuda1: TMenuItem
      Caption = 'Ajuda'
      object Sobre1: TMenuItem
        Action = actSobre
      end
    end
  end
  object ActionList: TActionList
    Left = 464
    Top = 8
    object actImpostos: TAction
      Caption = '&Impostos'
    end
    object actCombustiveis: TAction
      Caption = '&Combustiveis'
    end
    object actTanques: TAction
      Caption = '&Tanques'
    end
    object actBombas: TAction
      Caption = '&Bombas'
    end
    object actAbastecimentos: TAction
      Caption = '&Abastecimentos'
    end
    object actRelAbastecimentos: TAction
      Caption = '&Abastecimentos'
    end
    object actSobre: TAction
      Caption = '&Sobre'
      OnExecute = actSobreExecute
    end
    object actClientes: TAction
      Caption = '&Clientes'
      OnExecute = actClientesExecute
    end
    object actProdutos: TAction
      Caption = '&Produtos'
      OnExecute = actProdutosExecute
    end
    object actPedidos: TAction
      Caption = '&Pedidos'
      OnExecute = actPedidosExecute
    end
  end
end
