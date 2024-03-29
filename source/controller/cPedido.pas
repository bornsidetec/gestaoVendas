unit cPedido;

interface

uses dPedido, mPedido;

type
  TPedidoController = class
  public
    procedure Pesquisar(dData: TDateTime); overload;
    procedure Pesquisar(iId: Integer; out bEmpty: Boolean); overload;
    procedure CarregarPedido(oPedido: TPedido; iId: Integer);
    function Inserir(oPedido: TPedido; var sErro: string): Boolean;
    function Alterar(oPedido: TPedido; var sErro: string): Boolean;
    function Excluir(iId: Integer; var sErro: string): Boolean;
    procedure ListarClientes;
  end;

  TPedidoProdutoController = class
  public
    procedure Pesquisar(iId: Integer);
    procedure CarregarPedidoProduto(oPedidoProduto: TPedidoProduto; iId: Integer);
    function InserirProduto(oPedidoProduto: TPedidoProduto; var sErro: string): Boolean;
    function AlterarProduto(oPedidoProduto: TPedidoProduto; var sErro: string): Boolean;
    function ExcluirProduto(iId: Integer; var sErro: string): Boolean;
  end;

implementation

{ TPedidoController }

function TPedidoController.Alterar(oPedido: TPedido;
  var sErro: string): Boolean;
begin
  Result := dmPedidos.Alterar(oPedido, sErro);
end;

procedure TPedidoController.CarregarPedido(oPedido: TPedido; iId: Integer);
begin
  dmPedidos.CarregarPedido(oPedido, iId);
end;

function TPedidoController.Excluir(iId: Integer; var sErro: string): Boolean;
begin
  Result := dmPedidos.Excluir(iId, sErro);
end;

function TPedidoController.Inserir(oPedido: TPedido;
  var sErro: string): Boolean;
begin
  Result := dmPedidos.Inserir(oPedido, sErro);
end;

procedure TPedidoController.ListarClientes;
begin
  dmPedidos.ListarClientes;
end;

procedure TPedidoController.Pesquisar(iId: Integer; out bEmpty: Boolean);
begin
  dmPedidos.Pesquisar(iId, bEmpty);
end;

procedure TPedidoController.Pesquisar(dData: TDateTime);
begin
  dmPedidos.Pesquisar(dData);
end;

{ TPedidoProdutoController }

function TPedidoProdutoController.AlterarProduto(oPedidoProduto: TPedidoProduto;
  var sErro: string): Boolean;
begin
  Result := dmPedidos.AlterarProduto(oPedidoProduto, sErro);
end;

procedure TPedidoProdutoController.CarregarPedidoProduto(
  oPedidoProduto: TPedidoProduto; iId: Integer);
begin
  dmPedidos.CarregarProdutos(oPedidoProduto, iId);
end;

function TPedidoProdutoController.ExcluirProduto(iId: Integer;
  var sErro: string): Boolean;
begin
  Result := dmPedidos.ExcluirProduto(iId, sErro);
end;

function TPedidoProdutoController.InserirProduto(oPedidoProduto: TPedidoProduto;
  var sErro: string): Boolean;
begin
  Result := dmPedidos.InserirProduto(oPedidoProduto, sErro);
end;

procedure TPedidoProdutoController.Pesquisar(iId: Integer);
begin
  dmPedidos.PesquisarProdutos(iId);
end;

end.
