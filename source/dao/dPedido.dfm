object dmPedidos: TdmPedidos
  OldCreateOrder = False
  Height = 165
  Width = 357
  object qryPedidos: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'select pedidos.*, clientes.Nome as ClienteNome'
      'from pedidos'
      'inner join clientes on clientes.id = pedidos.Cliente'
      'where :todos = 1 or pedidos.Emissao > :data'
      'order by pedidos.Emissao desc')
    Left = 32
    Top = 16
    ParamData = <
      item
        Position = 1
        Name = 'TODOS'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'DATA'
        DataType = ftDateTime
        ParamType = ptInput
      end>
  end
  object dspPedidos: TDataSetProvider
    DataSet = qryPedidos
    Left = 32
    Top = 64
  end
  object cdsPedidos: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'TODOS'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATA'
        ParamType = ptInput
      end>
    ProviderName = 'dspPedidos'
    Left = 32
    Top = 112
    object cdsPedidosId: TIntegerField
      FieldName = 'Id'
      Required = True
      Visible = False
    end
    object cdsPedidosEmissao: TDateTimeField
      DisplayLabel = 'Emiss'#227'o'
      FieldName = 'Emissao'
    end
    object cdsPedidosCliente: TIntegerField
      FieldName = 'Cliente'
      Visible = False
    end
    object cdsPedidosClienteNome: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'ClienteNome'
      ReadOnly = True
      Size = 50
    end
    object cdsPedidosValorTotal: TFloatField
      DisplayLabel = 'Valor Total'
      FieldName = 'ValorTotal'
      DisplayFormat = '#,##0.00'
    end
  end
  object qryPedidoProdutos: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'select '
      '   pedido_produtos.Id,'
      '   pedido_produtos.Produto,'
      '   produtos.Descricao ProdutoDescricao, '
      '   pedido_produtos.ValorUnitario,'
      '   pedido_produtos.Quantidade,'
      '   pedido_produtos.ValorTotal'
      'from pedido_produtos'
      '   inner join pedidos on pedidos.Id = pedido_produtos.Pedido'
      '   inner join produtos on produtos.Id = pedido_produtos.Produto'
      'where pedidos.Id = :id'
      'order by pedido_produtos.Id')
    Left = 104
    Top = 16
    ParamData = <
      item
        Position = 1
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object dspPedidoProdutos: TDataSetProvider
    DataSet = qryPedidoProdutos
    Left = 104
    Top = 64
  end
  object cdsPedidoProdutos: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end>
    ProviderName = 'dspPedidoProdutos'
    Left = 104
    Top = 112
    object cdsPedidoProdutosId: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
      Visible = False
    end
    object cdsPedidoProdutosProduto: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Produto'
    end
    object cdsPedidoProdutosProdutoDescricao: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'ProdutoDescricao'
      Size = 50
    end
    object cdsPedidoProdutosValorUnitario: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'ValorUnitario'
      DisplayFormat = '#,##0.00'
    end
    object cdsPedidoProdutosQuantidade: TIntegerField
      FieldName = 'Quantidade'
      DisplayFormat = '#,##0.00'
    end
    object cdsPedidoProdutosValorTotal: TFloatField
      DisplayLabel = 'Valor Total'
      FieldName = 'ValorTotal'
      DisplayFormat = '#,##0.00'
    end
  end
  object qryInserir: TFDQuery
    Connection = dmConexao.Conexao
    Left = 176
    Top = 16
  end
  object qryAlterar: TFDQuery
    Connection = dmConexao.Conexao
    Left = 240
    Top = 16
  end
  object qryExcluir: TFDQuery
    Connection = dmConexao.Conexao
    Left = 304
    Top = 16
  end
  object query: TFDQuery
    Connection = dmConexao.Conexao
    Left = 176
    Top = 64
  end
end
