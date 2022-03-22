unit mPedido;

interface

uses
  System.SysUtils;

type
  TPedido = class
  private
    Fid: Integer;
    FEmissao: TDateTime;
    FCliente: Integer;
    FValorTotal: Double;
    FClienteNome: string;
    procedure SetClienteNome(const Value: string);
  public
    property Id: Integer read Fid write Fid;
    property Emissao: TDateTime read FEmissao write FEmissao;
    property Cliente: Integer read FCliente write FCliente;
    property ClienteNome: string read FClienteNome write SetClienteNome;
    property ValorTotal: Double read FValorTotal write FValorTotal;
  end;

  TPedidoProduto = class
  private
    Fid: Integer;
    FPedido: Integer;
    FProduto: Integer;
    FQuantidade: Integer;
    FValorUnitario: Double;
    FValorTotal: Double;
    FProdutoDescricao: string;
    procedure SetProdutoDescricao(const Value: string);
  public
    property Id: Integer read Fid write Fid;
    property Pedido: Integer read FPedido write FPedido;
    property Produto: Integer read FProduto write FProduto;
    property ProdutoDescricao: string read FProdutoDescricao write SetProdutoDescricao;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    property ValorTotal: Double read FValorTotal write FValorTotal;
  end;

implementation

{ TPedido }

procedure TPedido.SetClienteNome(const Value: string);
begin
  FClienteNome := Value;
end;

{ TPedidoProduto }

procedure TPedidoProduto.SetProdutoDescricao(const Value: string);
begin
  FProdutoDescricao := Value;
end;

end.
