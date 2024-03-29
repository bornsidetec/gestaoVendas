unit vProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.UITypes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, vCadastro, Data.DB, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  cProduto, mProduto, hEdit, dProduto;

type
  TfProdutos = class(TfCadastro)
    Label2: TLabel;
    Label3: TLabel;
    edtDescricao: TEdit;
    edtValorVenda: TEdit;
    procedure actPesquisarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actDetalharExecute(Sender: TObject);
    procedure actInserirExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtValorVendaKeyPress(Sender: TObject; var Key: Char);
    procedure actAlterarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
    procedure Carregar;
    procedure Alterar;
    procedure Excluir;
    procedure Inserir;
    procedure Salvar;
    procedure Limpar;
    procedure HabilitarEdits(aAcao: TAcao);
  public
    { Public declarations }
  end;

var
  fProdutos: TfProdutos;

implementation

{$R *.dfm}

procedure TfProdutos.actAlterarExecute(Sender: TObject);
begin
  inherited;
  HabilitarEdits(acAltera);
end;

procedure TfProdutos.actCancelarExecute(Sender: TObject);
begin
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfProdutos.actDetalharExecute(Sender: TObject);
begin
  Carregar;
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfProdutos.actExcluirExecute(Sender: TObject);
begin
  Excluir;
end;

procedure TfProdutos.actInserirExecute(Sender: TObject);
begin
  inherited;
  Limpar;
  HabilitarEdits(acInsere);
end;

procedure TfProdutos.actPesquisarExecute(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfProdutos.actSalvarExecute(Sender: TObject);
begin
  Salvar;
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfProdutos.Alterar;
var
  oProduto: TProduto;
  oProdutoController: TProdutoController;
  sErro: string;
begin

  oProduto := TProduto.Create;
  oProdutoController := TProdutoController.Create;

  try

    oProduto.Id := StrToInt(edtId.Text);
    oProduto.Descricao := edtDescricao.Text;
    oProduto.ValorVenda := StrToFloat(edtValorVenda.Text);

    if not oProdutoController.Alterar(oProduto, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oProdutoController);
    FreeAndNil(oProduto);
  end;

end;

procedure TfProdutos.Carregar;
var
  oProduto: TProduto;
  oProdutoController: TProdutoController;
begin

  oProduto := TProduto.Create;
  oProdutoController := TProdutoController.Create;
  try
    oProdutoController.CarregarProduto(oProduto,
      dsPesquisa.DataSet.FieldByName('Id').AsInteger);
    edtId.Text := IntToStr(oProduto.Id);
    edtDescricao.Text := oProduto.Descricao;
    edtValorVenda.Text := FormatFloat('#0.00', oProduto.ValorVenda);
  finally
    FreeAndNil(oProdutoController);
    FreeAndNil(oProduto);
  end;

end;

procedure TfProdutos.edtValorVendaKeyPress(Sender: TObject; var Key: Char);
begin
  edtValorVenda.KeyPress(Key, edtValorVenda.Text, edtValorVenda.SelStart, 7, 2);
end;

procedure TfProdutos.Excluir;
var
  oProdutoController: TProdutoController;
  sErro: string;
begin

  oProdutoController := TProdutoController.Create;
  try
    if (dmProduto.cdsProduto.Active) and (dmProduto.cdsProduto.RecordCount > 0)
    then
    begin
      if MessageDlg('Confirma a exclus�o?', mtConfirmation, [mbYes, mbNo], 0) = IDYES
      then
      begin
        if oProdutoController.Excluir(dmProduto.cdsProdutoId.AsInteger, sErro) = False
        then
          raise Exception.Create(sErro);
        Pesquisar;
      end;
    end
    else
      raise Exception.Create('Nenhum registro selecionado');

  finally
    FreeAndNil(oProdutoController);
  end;

end;

procedure TfProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  dmProduto := TdmProduto.Create(nil);
end;

procedure TfProdutos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dmProduto);
  inherited;
end;

procedure TfProdutos.FormShow(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TfProdutos.HabilitarEdits(aAcao: TAcao);
begin

  case aAcao of
    acInsere, acAltera:
      begin
        edtDescricao.ReadOnly := False;
        edtValorVenda.ReadOnly := False;
      end;
    acLista:
      begin
        edtDescricao.ReadOnly := True;
        edtValorVenda.ReadOnly := True;
      end;
  end;

end;

procedure TfProdutos.Inserir;
var
  oProduto: TProduto;
  oProdutoController: TProdutoController;
  sErro: string;
begin

  oProduto := TProduto.Create;
  oProdutoController := TProdutoController.Create;

  try
    oProduto.Descricao := edtDescricao.Text;
    oProduto.ValorVenda := StrToFloat(edtValorVenda.Text);

    if not oProdutoController.Inserir(oProduto, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oProdutoController);
    FreeAndNil(oProduto);
  end;

end;

procedure TfProdutos.Limpar;
begin

  case FAcao of
    acInsere:
      begin
        edtId.Clear;
        edtDescricao.Clear;
        edtValorVenda.Clear;
        edtDescricao.SetFocus;
      end;
  end;

end;

procedure TfProdutos.Pesquisar;
var
  oProdutoController: TProdutoController;
begin
  oProdutoController := TProdutoController.Create;
  try
    oProdutoController.Pesquisar(edtPesquisar.Text);
  finally
    FreeAndNil(oProdutoController);
  end;

end;

procedure TfProdutos.Salvar;
var
  oProdutoController: TProdutoController;
begin
  oProdutoController := TProdutoController.Create;

  try
    case FAcao of
      acInsere:
        Inserir;
      acAltera:
        Alterar;
    end;
    oProdutoController.Pesquisar(edtPesquisar.Text);
  finally
    FreeAndNil(oProdutoController);
  end;

end;

end.
