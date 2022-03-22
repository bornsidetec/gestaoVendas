unit mProduto;

interface

uses
  System.SysUtils;

type
  TProduto = class
  private
    FDescricao: string;
    Fid: Integer;
    FValorVenda: Double;
    procedure SetDescricao(const Value: string);
  public
    property Id: Integer read Fid write Fid;
    property Descricao: string read FDescricao write SetDescricao;
    property ValorVenda: Double read FValorVenda write FValorVenda;
  end;

implementation

{ TProduto }

procedure TProduto.SetDescricao(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('Descrição não informada');

  FDescricao := Value;
end;

end.
