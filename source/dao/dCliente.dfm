object dmCliente: TdmCliente
  OldCreateOrder = False
  Height = 165
  Width = 286
  object qryCliente: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'SELECT * FROM Clientes'
      'WHERE Nome like :nome')
    Left = 32
    Top = 16
    ParamData = <
      item
        Position = 1
        Name = 'Nome'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object dspCliente: TDataSetProvider
    DataSet = qryCliente
    Left = 32
    Top = 64
  end
  object cdsCliente: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'Nome'
        ParamType = ptInput
      end>
    ProviderName = 'dspCliente'
    Left = 32
    Top = 112
    object cdsClienteId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInWhere, pfInKey]
      Required = True
    end
    object cdsClienteNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 50
    end
    object cdsClienteCidade: TStringField
      FieldName = 'Cidade'
      Origin = 'Cidade'
      Size = 50
    end
    object cdsClienteUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      Size = 2
    end
  end
  object qryInserir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'INSERT INTO Clientes'
      '(Nome, Cidade, UF)'
      'VALUES (Nome, :Cidade, :UF)')
    Left = 96
    Top = 16
    ParamData = <
      item
        Name = 'CIDADE'
        ParamType = ptInput
      end
      item
        Name = 'UF'
        ParamType = ptInput
      end>
  end
  object qryAlterar: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'UPDATE Clientes'
      'SET Nome = :Nome, Cidade = :Cidade, UF = :UF'
      'WHERE Id = :Id')
    Left = 160
    Top = 16
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        Name = 'CIDADE'
        ParamType = ptInput
      end
      item
        Name = 'UF'
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
      'DELETE FROM Clientes'
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
