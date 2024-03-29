unit dPedido;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  Datasnap.DBClient, Datasnap.Provider, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, dConexao, mPedido;

type
  TdmPedidos = class(TDataModule)
    qryPedidos: TFDQuery;
    dspPedidos: TDataSetProvider;
    cdsPedidos: TClientDataSet;
    qryPedidoProdutos: TFDQuery;
    dspPedidoProdutos: TDataSetProvider;
    cdsPedidoProdutos: TClientDataSet;
    qryInserir: TFDQuery;
    qryAlterar: TFDQuery;
    qryExcluir: TFDQuery;
    cdsPedidosId: TIntegerField;
    cdsPedidosEmissao: TDateTimeField;
    cdsPedidosCliente: TIntegerField;
    cdsPedidosValorTotal: TFloatField;
    cdsPedidosClienteNome: TStringField;
    query: TFDQuery;
    cdsPedidoProdutosProdutoDescricao: TStringField;
    cdsPedidoProdutosValorUnitario: TFloatField;
    cdsPedidoProdutosQuantidade: TIntegerField;
    cdsPedidoProdutosValorTotal: TFloatField;
    cdsPedidoProdutosId: TAutoIncField;
    cdsPedidoProdutosProduto: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
    iIdPedido: Integer;
    function GerarId: Integer;
    procedure Pesquisar(dData: TDateTime); overload;
    procedure Pesquisar(iId: Integer; out bEmpty: Boolean); overload;
    procedure CarregarPedido(oPedido: TPedido; iId: Integer);
    function Inserir(oPedido: TPedido; out sErro: string): Boolean;
    function Alterar(oPedido: TPedido; out sErro: string): Boolean;
    function Excluir(iId: Integer; out sErro: string): Boolean;

    procedure ListarClientes;

    procedure PesquisarProdutos(iId: Integer);
    procedure CarregarProdutos(oPedidoProduto: TPedidoProduto; iId: Integer);
    function InserirProduto(oPedidoProduto: TPedidoProduto; out sErro: string): Boolean;
    function AlterarProduto(oPedidoProduto: TPedidoProduto; out sErro: string): Boolean;
    function ExcluirProduto(iId: Integer; out sErro: string): Boolean;

  end;

var
  dmPedidos: TdmPedidos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmPedidos }

function TdmPedidos.Alterar(oPedido: TPedido; out sErro: string): Boolean;
begin

  qryAlterar.SQL.Clear;
  qryAlterar.SQL.Text :=
    ' UPDATE pedidos ' +
    ' SET ValorTotal = :ValorTotal ' +
    ' WHERE Id = :Id ';
  qryAlterar.ParamByName('Id').AsInteger := oPedido.Id;
  qryAlterar.ParamByName('ValorTotal').AsFloat := oPedido.ValorTotal;

  dmConexao.Conexao.StartTransaction;

  try
    qryAlterar.ExecSQL;
    dmConexao.Conexao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      dmConexao.Conexao.Rollback;
      sErro := 'Erro ao alterar Produtos: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

function TdmPedidos.AlterarProduto(oPedidoProduto: TPedidoProduto;
  out sErro: string): Boolean;
begin

  qryAlterar.SQL.Clear;
  qryAlterar.SQL.Text :=
    ' UPDATE pedido_produtos ' +
    ' SET Quantidade = :Quantidade, ' +
    '    ValorUnitario = :ValorUnitario, ' +
    '    ValorTotal = :ValorTotal ' +
    ' WHERE Id = :Id ';
  qryAlterar.ParamByName('Id').AsInteger := oPedidoProduto.Id;
  qryAlterar.ParamByName('Quantidade').AsInteger := oPedidoProduto.Quantidade;
  qryAlterar.ParamByName('ValorUnitario').AsFloat := oPedidoProduto.ValorUnitario;
  qryAlterar.ParamByName('ValorTotal').AsFloat := oPedidoProduto.ValorTotal;

  dmConexao.Conexao.StartTransaction;

  try
    qryAlterar.ExecSQL;
    dmConexao.Conexao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      dmConexao.Conexao.Rollback;
      sErro := 'Erro ao alterar Produtos: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmPedidos.CarregarPedido(oPedido: TPedido; iId: Integer);
var
  qryCarregaPedido: TFDQuery;
begin

  qryCarregaPedido := TFDQuery.Create(nil);
  try
    qryCarregaPedido.Connection := dmConexao.Conexao;
    qryCarregaPedido.SQL.Text :=
      ' SELECT pedidos.*, clientes.Nome as ClienteNome ' +
      ' FROM pedidos ' +
      ' INNER JOIN clientes ON clientes.Id = pedidos.Cliente ' +
      ' WHERE pedidos.Id = :id ';
    qryCarregaPedido.ParamByName('id').AsInteger := iId;
    qryCarregaPedido.Open;

    oPedido.Id := qryCarregaPedido.FieldByName('Id').AsInteger;
    oPedido.Emissao := qryCarregaPedido.FieldByName('Emissao').AsDateTime;
    oPedido.Cliente := qryCarregaPedido.FieldByName('Cliente').AsInteger;
    oPedido.ClienteNome := qryCarregaPedido.FieldByName('ClienteNome').AsString;
    oPedido.ValorTotal := qryCarregaPedido.FieldByName('ValorTotal').AsFloat;
  finally
    FreeAndNil(qryCarregaPedido);
  end;

end;

procedure TdmPedidos.CarregarProdutos(oPedidoProduto: TPedidoProduto;
  iId: Integer);
var
  qryCarregaProduto: TFDQuery;
begin

  qryCarregaProduto := TFDQuery.Create(nil);
  try
    qryCarregaProduto.Connection := dmConexao.Conexao;
    qryCarregaProduto.SQL.Text :=
      ' SELECT pedido_produtos.*, produtos.Descricao as ProdutoDescricao ' +
      ' FROM pedido_produtos ' +
      ' INNER JOIN pedidos ON pedidos.Id = pedido_produtos.Pedido ' +
      ' INNER JOIN produtos ON produtos.Id = pedido_produtos.Produto ' +
      ' WHERE pedido_produtos.Id = :id ';
    qryCarregaProduto.ParamByName('id').AsInteger := iId;
    qryCarregaProduto.Open;

    oPedidoProduto.Id := qryCarregaProduto.FieldByName('Id').AsInteger;
    oPedidoProduto.Pedido := qryCarregaProduto.FieldByName('Pedido').AsInteger;
    oPedidoProduto.Produto := qryCarregaProduto.FieldByName('Produto').AsInteger;
    oPedidoProduto.Quantidade := qryCarregaProduto.FieldByName('Quantidade').AsInteger;
    oPedidoProduto.ValorUnitario := qryCarregaProduto.FieldByName('ValorUnitario').AsFloat;
    oPedidoProduto.ValorTotal := qryCarregaProduto.FieldByName('ValorTotal').AsFloat;
    oPedidoProduto.ProdutoDescricao := qryCarregaProduto.FieldByName('ProdutoDescricao').AsString;

  finally
    FreeAndNil(qryCarregaProduto);
  end;

end;

function TdmPedidos.Excluir(iId: Integer; out sErro: string): Boolean;
begin

  query.SQL.Clear;
  query.SQL.Text :=
    ' DELETE FROM Pedido_Produtos WHERE Pedido = :Id; ';
  query.Params[0].AsInteger := iId;

  qryExcluir.SQL.Clear;
  qryExcluir.SQL.Text :=
    ' DELETE FROM Pedidos WHERE Id = :Id; ';
  qryExcluir.Params[0].AsInteger := iId;

  dmConexao.Conexao.StartTransaction;

  try
    query.ExecSQL;
    qryExcluir.ExecSQL;
    dmConexao.Conexao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      dmConexao.Conexao.Rollback;
      sErro := 'Erro ao excluir Pedido: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

function TdmPedidos.ExcluirProduto(iId: Integer; out sErro: string): Boolean;
begin

  qryExcluir.SQL.Clear;
  qryExcluir.SQL.Text :=
    ' DELETE FROM pedido_produtos WHERE Id = :Id ';
  qryExcluir.Params[0].AsInteger := iId;

  dmConexao.Conexao.StartTransaction;

  try
    qryExcluir.ExecSQL;
    dmConexao.Conexao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      dmConexao.Conexao.Rollback;
      sErro := 'Erro ao excluir Produto: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

function TdmPedidos.GerarId: Integer;
var
  qrySeq: TFDQuery;
begin

  qrySeq := TFDQuery.Create(nil);
  try
    qrySeq.Connection := dmConexao.Conexao;
    qrySeq.SQL.Add('SELECT IFNULL(max(id), 0) + 1 as Seq FROM Pedidos');
    qrySeq.Open;
    iIdPedido := qrySeq.FieldByName('Seq').AsInteger;
    Result := iIdPedido;
  finally
    FreeAndNil(qrySeq);
  end;

end;

function TdmPedidos.Inserir(oPedido: TPedido; out sErro: string): Boolean;
begin

  qryInserir.SQL.Clear;
  qryInserir.SQL.Text :=
    ' INSERT Pedidos ' +
    ' (Id, Emissao, Cliente) ' +
    ' VALUES (:Id, :Emissao, :Cliente) ';
  qryInserir.ParamByName('Id').AsInteger := GerarId;
  qryInserir.ParamByName('Emissao').AsDateTime := oPedido.Emissao;
  qryInserir.ParamByName('Cliente').AsInteger := oPedido.Cliente;

  dmConexao.Conexao.StartTransaction;

  try
    qryInserir.ExecSQL;
    dmConexao.Conexao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      dmConexao.Conexao.Rollback;
      sErro := 'Erro ao inserir Produtos: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

function TdmPedidos.InserirProduto(oPedidoProduto: TPedidoProduto;
  out sErro: string): Boolean;
begin

  qryInserir.SQL.Clear;
  qryInserir.SQL.Text :=
    ' INSERT pedido_produtos ' +
    ' (Pedido, Produto, Quantidade, ValorUnitario, ValorTotal) ' +
    ' VALUES (:Pedido, :Produto, :Quantidade, :ValorUnitario, :ValorTotal) ';
  qryInserir.ParamByName('Pedido').AsInteger := oPedidoProduto.Pedido;
  qryInserir.ParamByName('Produto').AsInteger := oPedidoProduto.Produto;
  qryInserir.ParamByName('Quantidade').AsInteger := oPedidoProduto.Quantidade;
  qryInserir.ParamByName('ValorUnitario').AsFloat := oPedidoProduto.ValorUnitario;
  qryInserir.ParamByName('ValorTotal').AsFloat := oPedidoProduto.ValorTotal;

  dmConexao.Conexao.StartTransaction;

  try
    qryInserir.ExecSQL;
    dmConexao.Conexao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      dmConexao.Conexao.Rollback;
      sErro := 'Erro ao inserir Produtos: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmPedidos.ListarClientes;
begin
  if query.Active then
    query.Close;

  query.SQL.Clear;
  query.SQL.Text :=
    ' SELECT * FROM clientes order by Id ';
  query.Open;
  query.First;
end;

procedure TdmPedidos.Pesquisar(dData: TDateTime);
begin

  if cdsPedidos.Active then
    cdsPedidos.Close;

  cdsPedidos.Params[1].AsDateTime := Trunc(dData);

  if dData > 0 then
    cdsPedidos.Params[0].AsInteger := 0
  else
    cdsPedidos.Params[0].AsInteger := 1;

  cdsPedidos.Open;
  cdsPedidos.First;

end;

procedure TdmPedidos.Pesquisar(iId: Integer; out bEmpty: Boolean);
begin

  query.SQL.Clear;
  query.SQL.Text :=
    ' SELECT Pedidos.Id FROM Pedidos ' +
    ' WHERE Pedidos.Id = :Id ';
  query.ParamByName('Id').AsInteger := iId;
  query.Open;

  bEmpty := query.IsEmpty;

end;

procedure TdmPedidos.PesquisarProdutos(iId: Integer);
begin
  if cdsPedidoProdutos.Active then
    cdsPedidoProdutos.Close;

  cdsPedidoProdutos.Params[0].AsInteger := iId;
  cdsPedidoProdutos.Open;
  cdsPedidoProdutos.First;
end;

end.
