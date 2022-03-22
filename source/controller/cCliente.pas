unit cCliente;

interface

uses
  mCliente, dCliente, System.SysUtils;

type
  TClienteController = class
  public
    procedure Pesquisar(sDescricao: string);
    procedure CarregarCliente(oCliente: TCliente; iId: Integer);
    function Inserir(oCliente: TCliente; var sErro: string): Boolean;
    function Alterar(oCliente: TCliente; var sErro: string): Boolean;
    function Excluir(iId: Integer; var sErro: string): Boolean;
  end;

implementation

{ TClienteController }

function TClienteController.Alterar(oCliente: TCliente;
  var sErro: string): Boolean;
begin
  Result := dmCliente.Alterar(oCliente, sErro);
end;

procedure TClienteController.CarregarCliente(oCliente: TCliente; iId: Integer);
begin
  dmCliente.CarregarCliente(oCliente, iId);
end;

function TClienteController.Excluir(iId: Integer; var sErro: string): Boolean;
begin
  Result := dmCliente.Excluir(iId, sErro);
end;

function TClienteController.Inserir(oCliente: TCliente;
  var sErro: string): Boolean;
begin
  Result := dmCliente.Inserir(oCliente, sErro);
end;

procedure TClienteController.Pesquisar(sDescricao: string);
begin
  dmCliente.Pesquisar(sDescricao);
end;

end.
