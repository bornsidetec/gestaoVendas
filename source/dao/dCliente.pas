unit dCliente;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  Datasnap.DBClient, Datasnap.Provider, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, dConexao, mCliente;

type
  TdmCliente = class(TDataModule)
    qryCliente: TFDQuery;
    dspCliente: TDataSetProvider;
    cdsCliente: TClientDataSet;
    cdsClienteId: TIntegerField;
    cdsClienteNome: TStringField;
    qryInserir: TFDQuery;
    qryAlterar: TFDQuery;
    qryExcluir: TFDQuery;
    cdsClienteCidade: TStringField;
    cdsClienteUF: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pesquisar(sDescricao: string);
    procedure CarregarCliente(oCliente: TCliente; iId: Integer);
    function Inserir(oCliente: TCliente; out sErro: string): Boolean;
    function Alterar(oCliente: TCliente; out sErro: string): Boolean;
    function Excluir(iId: Integer; out sErro: string): Boolean;
  end;

var
  dmCliente: TdmCliente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmCliente }

function TdmCliente.Alterar(oCliente: TCliente; out sErro: string): Boolean;
begin

  qryAlterar.SQL.Clear;
  qryAlterar.SQL.Text :=
    ' UPDATE Clientes ' +
    ' SET Nome = :Nome, Cidade = :Cidade, UF = :UF ' +
    ' WHERE Id = :Id ';
  qryAlterar.ParamByName('Id').AsInteger := oCliente.Id;
  qryAlterar.ParamByName('Nome').AsString := oCliente.Nome;
  qryAlterar.ParamByName('Cidade').AsString := oCliente.Cidade;
  qryAlterar.ParamByName('UF').AsString := oCliente.UF;

  dmConexao.Conexao.StartTransaction;

  try
    qryAlterar.ExecSQL;
    dmConexao.Conexao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      dmConexao.Conexao.Rollback;
      sErro := 'Erro ao alterar Clientes: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmCliente.CarregarCliente(oCliente: TCliente; iId: Integer);
var
  qryCarregaCliente: TFDQuery;
begin

  qryCarregaCliente := TFDQuery.Create(nil);
  try
    qryCarregaCliente.Connection := dmConexao.Conexao;
    qryCarregaCliente.SQL.Add('SELECT * FROM Clientes WHERE Id = :id');
    qryCarregaCliente.ParamByName('id').AsInteger := iId;
    qryCarregaCliente.Open;

    oCliente.Id := qryCarregaCliente.FieldByName('Id').AsInteger;
    oCliente.Nome := qryCarregaCliente.FieldByName('Nome').AsString;
    oCliente.Cidade := qryCarregaCliente.FieldByName('Cidade').AsString;
    oCliente.UF := qryCarregaCliente.FieldByName('UF').AsString;
  finally
    FreeAndNil(qryCarregaCliente);
  end;

end;

function TdmCliente.Excluir(iId: Integer; out sErro: string): Boolean;
begin

  qryExcluir.SQL.Clear;
  qryExcluir.SQL.Text :=
    ' DELETE FROM Clientes ' +
    ' WHERE Id = :Id ';
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
      sErro := 'Erro ao excluir Clientes: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

function TdmCliente.Inserir(oCliente: TCliente; out sErro: string): Boolean;
begin

  qryInserir.SQL.Clear;
  qryInserir.SQL.Text :=
    ' INSERT Clientes ' +
    ' (Nome, Cidade, UF) ' +
    ' VALUES (:Nome, :Cidade, :UF) ';
  qryInserir.ParamByName('Nome').AsString := oCliente.Nome;
  qryInserir.ParamByName('Cidade').AsString := oCliente.Cidade;
  qryInserir.ParamByName('UF').AsString := oCliente.UF;

  dmConexao.Conexao.StartTransaction;

  try
    qryInserir.ExecSQL;
    dmConexao.Conexao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      dmConexao.Conexao.Rollback;
      sErro := 'Erro ao inserir Clientes: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmCliente.Pesquisar(sDescricao: string);
begin
  if cdsCliente.Active then
    cdsCliente.Close;

  cdsCliente.Params[0].AsString := '%' + sDescricao + '%';
  cdsCliente.Open;
  cdsCliente.First;

end;

end.
