unit cProduto;

interface

uses
  mProduto, dProduto, System.SysUtils;

type
  TProdutoController = class
  public
    procedure Pesquisar(sDescricao: string);
    procedure CarregarProduto(oProduto: TProduto; iId: Integer);
    function Inserir(oProduto: TProduto; var sErro: string): Boolean;
    function Alterar(oProduto: TProduto; var sErro: string): Boolean;
    function Excluir(iId: Integer; var sErro: string): Boolean;
  end;

implementation

{ TProdutoController }

function TProdutoController.Alterar(oProduto: TProduto;
  var sErro: string): Boolean;
begin
  Result := dmProduto.Alterar(oProduto, sErro);
end;

procedure TProdutoController.CarregarProduto(oProduto: TProduto; iId: Integer);
begin
  dmProduto.CarregarProduto(oProduto, iId);
end;

function TProdutoController.Excluir(iId: Integer; var sErro: string): Boolean;
begin
  Result := dmProduto.Excluir(iId, sErro);
end;

function TProdutoController.Inserir(oProduto: TProduto;
  var sErro: string): Boolean;
begin
  Result := dmProduto.Inserir(oProduto, sErro);
end;

procedure TProdutoController.Pesquisar(sDescricao: string);
begin
  dmProduto.Pesquisar(sDescricao);
end;

end.
