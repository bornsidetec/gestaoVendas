inherited fClientes: TfClientes
  Caption = 'Cadastro de Clientes'
  ClientHeight = 361
  ClientWidth = 645
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  inherited pnlBotom: TPanel
    Top = 316
    Width = 645
    ExplicitTop = 315
    ExplicitWidth = 641
    inherited btnFechar: TBitBtn
      Left = 546
      ExplicitLeft = 542
    end
  end
  inherited pnlClient: TPanel
    Width = 645
    Height = 316
    ExplicitWidth = 641
    ExplicitHeight = 315
    inherited PageControl: TPageControl
      ActivePage = tsListagem
      ExplicitWidth = 641
      ExplicitHeight = 315
      inherited tsListagem: TTabSheet
        inherited pnlFind: TPanel
          ExplicitWidth = 633
          inherited btnPesquisar: TBitBtn
            ExplicitLeft = 544
          end
          inherited edtPesquisar: TEdit
            ExplicitWidth = 414
          end
        end
        inherited pnlActionsList: TPanel
          ExplicitTop = 242
          ExplicitWidth = 633
          inherited btnInserir: TBitBtn
            ExplicitLeft = 388
          end
          inherited btnDetalhar: TBitBtn
            ExplicitLeft = 469
          end
          inherited btnExcluir: TBitBtn
            ExplicitLeft = 550
          end
        end
      end
      inherited tsDetalhes: TTabSheet
        object Label2: TLabel [1]
          Left = 16
          Top = 64
          Width = 27
          Height = 13
          Caption = 'Nome'
        end
        object Label3: TLabel [2]
          Left = 16
          Top = 113
          Width = 33
          Height = 13
          Caption = 'Cidade'
        end
        object Label4: TLabel [3]
          Left = 473
          Top = 113
          Width = 33
          Height = 13
          Caption = 'Estado'
        end
        inherited pnlActionsDetail: TPanel
          inherited btnAlterar: TBitBtn
            Left = 384
            ExplicitLeft = 384
          end
          inherited btnSalvar: TBitBtn
            Left = 465
            ExplicitLeft = 465
          end
          inherited btnCancelar: TBitBtn
            Left = 546
            ExplicitLeft = 546
          end
          inherited btnVoltar: TBitBtn
            Left = 303
            ExplicitLeft = 303
          end
        end
        object edtNome: TEdit
          Left = 16
          Top = 83
          Width = 593
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 50
          TabOrder = 2
        end
        object edtCidade: TEdit
          Left = 16
          Top = 132
          Width = 433
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 50
          TabOrder = 3
        end
        object cboUF: TComboBox
          Left = 473
          Top = 132
          Width = 144
          Height = 21
          Style = csDropDownList
          TabOrder = 4
          Items.Strings = (
            'AC'
            'AL'
            'AM'
            'AP'
            'BA'
            'CE'
            'DF'
            'ES'
            'GO'
            'MA'
            'MG'
            'MS'
            'MT'
            'PA'
            'PB'
            'PE'
            'PI'
            'PR'
            'RJ'
            'RN'
            'RO'
            'RR'
            'RS'
            'SC'
            'SE'
            'SP'
            'TO')
        end
      end
    end
  end
  inherited ActionList: TActionList
    Top = 216
    inherited actPesquisar: TAction
      OnExecute = actPesquisarExecute
    end
    inherited actExcluir: TAction
      OnExecute = actExcluirExecute
    end
  end
  inherited ImageList: TImageList
    Top = 216
  end
  inherited dsPesquisa: TDataSource
    DataSet = dmCliente.cdsCliente
    Top = 216
  end
end
