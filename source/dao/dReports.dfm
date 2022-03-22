object dmReports: TdmReports
  OldCreateOrder = False
  Height = 150
  Width = 215
  object qryRelatorio: TFDQuery
    Connection = dmConexao.Conexao
    Left = 40
    Top = 16
    object qryRelatorioData: TWideStringField
      FieldName = 'Data'
      Origin = 'Data'
      Size = 32767
    end
    object qryRelatorioCombustivel: TStringField
      FieldName = 'Combustivel'
      Origin = 'Combustivel'
      Required = True
      Size = 50
    end
    object qryRelatorioTanqueId: TIntegerField
      FieldName = 'TanqueId'
      Origin = 'TanqueId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryRelatorioTanque: TStringField
      FieldName = 'Tanque'
      Origin = 'Tanque'
      Size = 50
    end
    object qryRelatorioBombaId: TIntegerField
      FieldName = 'BombaId'
      Origin = 'BombaId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryRelatorioBomba: TStringField
      FieldName = 'Bomba'
      Origin = 'Bomba'
      Size = 50
    end
    object qryRelatorioTotalPagar: TFloatField
      FieldName = 'TotalPagar'
      Origin = 'TotalPagar'
    end
    object qryRelatorioValorImposto: TFloatField
      FieldName = 'ValorImposto'
      Origin = 'ValorImposto'
    end
  end
end
