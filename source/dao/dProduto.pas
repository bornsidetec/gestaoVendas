unit dProduto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  Datasnap.DBClient, Datasnap.Provider, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, dConexao, mProduto;

type
  TdmProduto = class(TDataModule)
    qryProduto: TFDQuery;
    dspProduto: TDataSetProvider;
    cdsProduto: TClientDataSet;
    qryInserir: TFDQuery;
    qryAlterar: TFDQuery;
    qryExcluir: TFDQuery;
    cdsProdutoId: TIntegerField;
    cdsProdutoDescricao: TStringField;
    cdsProdutoValorVenda: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pesquisar(sDescricao: string);
    procedure CarregarProduto(oProduto: TProduto; iId: Integer);
    function Inserir(oProduto: TProduto; out sErro: string): Boolean;
    function Alterar(oProduto: TProduto; out sErro: string): Boolean;
    function Excluir(iId: Integer; out sErro: string): Boolean;
  end;

var
  dmProduto: TdmProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmProduto }

function TdmProduto.Alterar(oProduto: TProduto; out sErro: string): Boolean;
begin

  qryAlterar.SQL.Clear;
  qryAlterar.SQL.Text :=
    ' UPDATE Produtos ' +
    ' SET Descricao = :Descricao, ValorVenda = :ValorVenda ' +
    ' WHERE Id = :Id ';
  qryAlterar.ParamByName('Id').AsInteger := oProduto.Id;
  qryAlterar.ParamByName('Descricao').AsString := oProduto.Descricao;
  qryAlterar.ParamByName('ValorVenda').AsFloat := oProduto.ValorVenda;

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

procedure TdmProduto.CarregarProduto(oProduto: TProduto; iId: Integer);
var
  qryCarregaProduto: TFDQuery;
begin

  qryCarregaProduto := TFDQuery.Create(nil);
  try
    qryCarregaProduto.Connection := dmConexao.Conexao;
    qryCarregaProduto.SQL.Add('SELECT * FROM Produtos WHERE Id = :id');
    qryCarregaProduto.ParamByName('id').AsInteger := iId;
    qryCarregaProduto.Open;

    oProduto.Id := qryCarregaProduto.FieldByName('Id').AsInteger;
    oProduto.Descricao := qryCarregaProduto.FieldByName('Descricao').AsString;
    oProduto.ValorVenda := qryCarregaProduto.FieldByName('ValorVenda').AsFloat;
  finally
    FreeAndNil(qryCarregaProduto);
  end;

end;

function TdmProduto.Excluir(iId: Integer; out sErro: string): Boolean;
begin

  qryExcluir.SQL.Clear;
  qryExcluir.SQL.Text :=
    ' DELETE FROM Produtos WHERE Id = :Id ';
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
      sErro := 'Erro ao excluir Produtos: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

function TdmProduto.Inserir(oProduto: TProduto; out sErro: string): Boolean;
begin

  qryInserir.SQL.Clear;
  qryInserir.SQL.Text :=
    ' INSERT Produtos ' +
    ' (Descricao, ValorVenda) ' +
    ' VALUES (:Descricao, :ValorVenda) ';
  qryInserir.ParamByName('Descricao').AsString := oProduto.Descricao;
  qryInserir.ParamByName('ValorVenda').AsFloat := oProduto.ValorVenda;

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

procedure TdmProduto.Pesquisar(sDescricao: string);
begin
  if cdsProduto.Active then
    cdsProduto.Close;

  cdsProduto.Params[0].AsString := '%' + sDescricao + '%';
  cdsProduto.Open;
  cdsProduto.First;
end;

end.
