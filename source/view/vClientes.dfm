inherited fClientes: TfClientes
  Caption = 'Cadastro de Clientes'
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
        object edtNome: TEdit
          Left = 16
          Top = 83
          Width = 601
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 50
          TabOrder = 2
        end
        object edtCidade: TEdit
          Left = 16
          Top = 132
          Width = 441
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
