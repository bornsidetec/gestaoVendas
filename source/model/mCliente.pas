unit mCliente;

interface

uses
  System.SysUtils;

type
  TCliente = class
  private
    Fid: Integer;
    FNome: string;
    FCidade: string;
    FUF: string;
    procedure SetNome(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetUF(const Value: string);
  public
    property Id: Integer read Fid write Fid;
    property Nome: string read FNome write SetNome;
    property Cidade: string read FCidade write SetCidade;
    property UF: string read FUF write SetUF;
  end;

implementation

{ TCliente }

procedure TCliente.SetCidade(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('Cidade não informada');

  FCidade := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('Nome não informada');

  FNome := Value;
end;

procedure TCliente.SetUF(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('UF não informada');

  FUF := Value;
end;

end.
