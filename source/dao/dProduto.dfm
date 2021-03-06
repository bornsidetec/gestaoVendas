object dmProduto: TdmProduto
  OldCreateOrder = False
  Height = 166
  Width = 286
  object qryProduto: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'SELECT * FROM Produtos'
      'WHERE Descricao like :descricao')
    Left = 32
    Top = 16
    ParamData = <
      item
        Position = 1
        Name = 'DESCRICAO'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object dspProduto: TDataSetProvider
    DataSet = qryProduto
    Left = 32
    Top = 64
  end
  object cdsProduto: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'DESCRICAO'
        ParamType = ptInput
      end>
    ProviderName = 'dspProduto'
    Left = 32
    Top = 112
    object cdsProdutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Id'
      Required = True
    end
    object cdsProdutoDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
      Required = True
      Size = 50
    end
    object cdsProdutoValorVenda: TFloatField
      DisplayLabel = 'Valor de Venda'
      FieldName = 'ValorVenda'
      DisplayFormat = '#,##0.00'
    end
  end
  object qryInserir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'INSERT INTO Produtos'
      '(DESCRICAO, ValorVenda)'
      'VALUES (:Descricao, :ValorVenda)')
    Left = 96
    Top = 16
    ParamData = <
      item
        Name = 'DESCRICAO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALORVENDA'
        ParamType = ptInput
      end>
  end
  object qryAlterar: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'UPDATE Produtos'
      'SET Descricao = :Descricao, ValorVenda = :ValorVenda'
      'WHERE Id = :Id')
    Left = 160
    Top = 16
    ParamData = <
      item
        Name = 'DESCRICAO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALORVENDA'
        ParamType = ptInput
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryExcluir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'DELETE FROM Produtos'
      'WHERE Id = :Id')
    Left = 224
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
