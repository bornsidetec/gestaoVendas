inherited fProdutos: TfProdutos
  Caption = 'Cadastro de Produtos'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClient: TPanel
    inherited PageControl: TPageControl
      inherited tsDetalhes: TTabSheet
        object Label2: TLabel [1]
          Left = 16
          Top = 64
          Width = 46
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        object Label3: TLabel [2]
          Left = 488
          Top = 64
          Width = 72
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Valor de Venda'
        end
        object edtDescricao: TEdit
          Left = 16
          Top = 83
          Width = 457
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 50
          TabOrder = 2
        end
        object edtValorVenda: TEdit
          Left = 487
          Top = 83
          Width = 122
          Height = 21
          Anchors = [akTop, akRight]
          TabOrder = 3
          OnKeyPress = edtValorVendaKeyPress
        end
      end
    end
  end
  inherited ActionList: TActionList
    inherited actPesquisar: TAction
      OnExecute = actPesquisarExecute
    end
    inherited actExcluir: TAction
      OnExecute = actExcluirExecute
    end
  end
  inherited dsPesquisa: TDataSource
    DataSet = dmProduto.cdsProduto
  end
end
