unit vPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.UITypes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask,
  dPedido, cPedido, mPedido, hComboBox, hEdit, uCalculos, Vcl.Menus,
  FireDAC.Stan.Param;

type
  TTipoPesquisa = (tpHoje, tpTodos);
  TAcao = (acInsere, acInsereProduto, acAlteraProduto, acLista, acAltera);

  TfPedidos = class(TForm)
    ActionList: TActionList;
    actFechar: TAction;
    actInserir: TAction;
    actExcluir: TAction;
    actSalvar: TAction;
    actCancelar: TAction;
    ImageList: TImageList;
    pnlTop: TPanel;
    pnlBotom: TPanel;
    btnFechar: TBitBtn;
    PageControl: TPageControl;
    tsPedidos: TTabSheet;
    tsProdutos: TTabSheet;
    pnlAcoesGrid: TPanel;
    rbHoje: TRadioButton;
    rbTodos: TRadioButton;
    DBGrid1: TDBGrid;
    pnlProdutos: TPanel;
    Label4: TLabel;
    dsPesquisa: TDataSource;
    btnConfirmar: TBitBtn;
    pnlGrid: TPanel;
    pnlTotal: TPanel;
    DBGrid2: TDBGrid;
    pnlPedidos: TPanel;
    Label1: TLabel;
    cboCliente: TComboBox;
    btnSalvar: TBitBtn;
    Label3: TLabel;
    edtValor: TEdit;
    Label2: TLabel;
    edtQuantidade: TEdit;
    Label9: TLabel;
    edtTotalProduto: TEdit;
    Label5: TLabel;
    edtTotalPedido: TEdit;
    btnInserir: TBitBtn;
    edtProduto: TEdit;
    edtIdProduto: TEdit;
    actConfirmar: TAction;
    dsProdutos: TDataSource;
    actConcluir: TAction;
    btnConcluir: TBitBtn;
    pmProdutos: TPopupMenu;
    Excluir1: TMenuItem;
    btnCancelar: TBitBtn;
    actPedido: TAction;
    btnPedido: TBitBtn;
    pnlCarregaPedido: TPanel;
    edtPedido: TLabeledEdit;
    actAlterar: TAction;
    actVoltar: TAction;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    btnVoltar: TBitBtn;
    procedure rbHojeClick(Sender: TObject);
    procedure actInserirExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure actConfirmarExecute(Sender: TObject);
    procedure edtIdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtIdProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure actConcluirExecute(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actPedidoExecute(Sender: TObject);
    procedure cboClienteExit(Sender: TObject);
    procedure actVoltarExecute(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    procedure Pesquisar(tp: TTipoPesquisa);
    procedure HabilitarAcoes(aAcao: TAcao);
    procedure CarregarLista(cbLista: TComboBox);

    procedure Limpar;
    procedure LimparProduto(bFoco: Boolean = True);
    procedure LimparCalculos;
    procedure Validar(aAcao: TAcao);
    procedure Salvar;
    procedure Inserir;
    procedure Alterar;
    procedure Excluir;
    procedure CarregarId;
    procedure SalvarProduto(aAcao: TAcao);
    procedure InserirProduto;
    procedure ExcluirProduto;
    procedure PesquisarProduto;
    procedure CarregarProduto;
    procedure AlterarProduto;
    procedure CarregarPedido(const iId: integer = 0);
    function BuscarProduto(iId: Integer; var sDescricao: string): Double;
    function TotalizarPedido(iIdPedido: Integer): Double;
    function RetornaItem(sLista: TStrings; sParam: string): Integer;
    procedure AcoesPedido(const bAcao: Boolean);
    function PesquisarId(iId: integer): Boolean;
  public
    { Public declarations }
    FTipoPesquisa: TTipoPesquisa;
    FAcao: TAcao;
    iIdPedido: Integer;
  end;

var
  fPedidos: TfPedidos;

implementation

{$R *.dfm}

procedure TfPedidos.AcoesPedido(const bAcao: Boolean);
begin
  pnlCarregaPedido.Visible := bAcao;
  edtPedido.Clear;

  pnlPedidos.Visible := not bAcao;
  pnlProdutos.Visible := not bAcao;
  pnlGrid.Visible := not bAcao;

  if bAcao then
    edtPedido.SetFocus;
end;

procedure TfPedidos.actAlterarExecute(Sender: TObject);
begin

  if edtPedido.Text = EmptyStr then
  begin
    MessageDlg('Pedido n�o informado.', mtConfirmation, [mbOk], 0);
    Exit;
  end;

  if not PesquisarId(StrToIntDef(edtPedido.Text, 0)) then
  begin
    MessageDlg('Pedido n�o localizado.', mtConfirmation, [mbOk], 0);
    Exit;
  end;

  AcoesPedido(False);
  HabilitarAcoes(acAltera);
  CarregarPedido(StrToIntDef(edtPedido.Text, 0));
end;

procedure TfPedidos.actCancelarExecute(Sender: TObject);
begin
  HabilitarAcoes(acLista);
end;

procedure TfPedidos.actConcluirExecute(Sender: TObject);
begin
  Validar(acLista);
  HabilitarAcoes(acLista);
  Alterar;

  Pesquisar(tpHoje);
end;

procedure TfPedidos.actConfirmarExecute(Sender: TObject);
begin

  Validar(acInsereProduto);

  if btnConfirmar.Tag = 1 then
    begin
      SalvarProduto(acAlteraProduto);
      btnConfirmar.Tag := 0;
    end
  else
    SalvarProduto(acInsereProduto);

  HabilitarAcoes(acInsereProduto);
  PesquisarProduto;

end;

procedure TfPedidos.actExcluirExecute(Sender: TObject);
begin

  if edtPedido.Text = EmptyStr then
  begin
    MessageDlg('Pedido n�o informado.', mtConfirmation, [mbOk], 0);
    Exit;
  end;

  if not PesquisarId(StrToIntDef(edtPedido.Text, 0)) then
  begin
    MessageDlg('Pedido n�o localizado.', mtConfirmation, [mbOk], 0);
    Exit;
  end;

  iIdPedido := StrToIntDef(edtPedido.Text, 0);
  Excluir;
  AcoesPedido(False);
  HabilitarAcoes(acLista);
  Pesquisar(tpHoje);

end;

procedure TfPedidos.actFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfPedidos.actInserirExecute(Sender: TObject);
begin
  FAcao := acInsere;
  HabilitarAcoes(acInsere);
  Limpar;
end;

procedure TfPedidos.actPedidoExecute(Sender: TObject);
begin
  AcoesPedido(True);
end;

procedure TfPedidos.actSalvarExecute(Sender: TObject);
begin
  Validar(acInsere);
  Salvar;
  HabilitarAcoes(acInsereProduto);
end;

procedure TfPedidos.actVoltarExecute(Sender: TObject);
begin
  AcoesPedido(False);
end;

procedure TfPedidos.Alterar;
var
  oPedido: TPedido;
  oPedidoController: TPedidoController;
  sErro: string;
begin

  oPedido := TPedido.Create;
  oPedidoController := TPedidoController.Create;

  try

    oPedido.Id := iIdPedido;
    oPedido.ValorTotal := TotalizarPedido(iIdPedido);

    if not oPedidoController.Alterar(oPedido, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oPedidoController);
    FreeAndNil(oPedido);
  end;

end;

procedure TfPedidos.AlterarProduto;
var
  oPedidoProduto: TPedidoProduto;
  oPedidoProdutoController: TPedidoProdutoController;
  sErro: string;
begin

  oPedidoProduto := TPedidoProduto.Create;
  oPedidoProdutoController := TPedidoProdutoController.Create;

  try

    oPedidoProduto.Id := edtProduto.Tag;
    oPedidoProduto.Pedido := iIdPedido;
    oPedidoProduto.Produto := StrToInt(edtIdProduto.Text);
    oPedidoProduto.Quantidade := StrToInt(edtQuantidade.Text);
    oPedidoProduto.ValorUnitario := StrToFloat(edtValor.Text);
    oPedidoProduto.ValorTotal := StrToFloat(edtTotalProduto.Text);

    if not oPedidoProdutoController.AlterarProduto(oPedidoProduto, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oPedidoProdutoController);
    FreeAndNil(oPedidoProduto);
  end;

end;

procedure TfPedidos.btnCancelarClick(Sender: TObject);
begin
  HabilitarAcoes(acLista);
end;

function TfPedidos.BuscarProduto(iId: Integer; var sDescricao: string): Double;
begin

  dmPedidos.query.Close;
  dmPedidos.query.SQL.Clear;
  dmPedidos.query.SQL.Text :=
    ' SELECT Id, Descricao, ValorVenda FROM produtos WHERE Id = :idProduto ';
  dmPedidos.query.ParamByName('idProduto').AsInteger := iId;
  dmPedidos.query.Open;

  if dmPedidos.query.IsEmpty then
    Result := 0
  else
  begin
    sDescricao := dmPedidos.query.FieldByName('Descricao').AsString;
    Result := dmPedidos.query.FieldByName('ValorVenda').AsFloat;
  end;

end;

procedure TfPedidos.CarregarId;
begin
  iIdPedido := dmPedidos.iIdPedido;
end;

procedure TfPedidos.CarregarLista(cbLista: TComboBox);
var
  oPedidoController: TPedidoController;
begin

  oPedidoController := TPedidoController.Create;
  try
    oPedidoController.ListarClientes;

    cbLista.Items.Clear;
    while not dmPedidos.query.Eof do
    begin
      cbLista.Items.Add(dmPedidos.query.FieldByName('Id').AsString + '-'
        + dmPedidos.query.FieldByName('Nome').AsString);
      dmPedidos.query.Next;
    end;

  finally
    FreeAndNil(oPedidoController);
  end;

end;

procedure TfPedidos.CarregarPedido(const iId: integer = 0);
var
  oPedido: TPedido;
  oPedidoController: TPedidoController;
  iIdPed: integer;

begin

  oPedido := TPedido.Create;
  oPedidoController := TPedidoController.Create;

  try
    iIdPed := iId;
    if iId = 0 then
      iIdPed := dmPedidos.cdsPedidosId.AsInteger;

    oPedidoController.CarregarPedido(oPedido, iIdPed);
    iIdPedido := oPedido.Id;
    cboCliente.ItemIndex := RetornaItem(cboCliente.Items, oPedido.ClienteNome);

    PesquisarProduto;

    edtTotalPedido.Text :=
      FormatFloat('#0.00', TotalizarPedido(iIdPedido));

  finally
    FreeAndNil(oPedido);
    FreeAndNil(oPedidoController);
  end;

end;

procedure TfPedidos.CarregarProduto;
var
  oPedidoProduto: TPedidoProduto;
  oPedidoProdutoController: TPedidoProdutoController;
begin

  oPedidoProduto := TPedidoProduto.Create;
  oPedidoProdutoController := TPedidoProdutoController.Create;
  try
    oPedidoProdutoController.CarregarPedidoProduto(oPedidoProduto, dmPedidos.cdsPedidoProdutosId.AsInteger);
    edtProduto.Tag := oPedidoProduto.Id;
    edtIdProduto.Text := IntToStr(oPedidoProduto.Produto);
    edtProduto.Text := oPedidoProduto.ProdutoDescricao;
    edtValor.Text := FormatFloat('#0.00', oPedidoProduto.ValorUnitario);
    edtQuantidade.Text := IntToStr(oPedidoProduto.Quantidade);
    edtTotalProduto.Text := FormatFloat('#0.00', oPedidoProduto.ValorTotal);
  finally
    FreeAndNil(oPedidoProdutoController);
    FreeAndNil(oPedidoProduto);
  end;

end;

procedure TfPedidos.cboClienteExit(Sender: TObject);
begin
  btnPedido.Enabled := cboCliente.ItemIndex = -1
end;

procedure TfPedidos.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    HabilitarAcoes(acAltera);
    CarregarPedido;
  end;
end;

procedure TfPedidos.DBGrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    ExcluirProduto;

  if Key = VK_RETURN then
  begin
    HabilitarAcoes(acAlteraProduto);
    CarregarProduto;
  end;

end;

procedure TfPedidos.edtIdProdutoExit(Sender: TObject);
var
  s: string;
begin
  if edtIdProduto.Text <> EmptyStr then
  begin

    edtValor.Text :=
      FormatFloat('#0.00', BuscarProduto(StrToInt(edtIdProduto.Text), s));

    edtProduto.Text := s;
  end
  else
    LimparProduto(False);

end;

procedure TfPedidos.edtIdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0' .. '9', #8, #9]) then
    Key := #0;
end;

procedure TfPedidos.edtQuantidadeExit(Sender: TObject);
begin
  if edtQuantidade.Text = EmptyStr then
    edtQuantidade.Text := '1';

  if (edtQuantidade.Text <> EmptyStr) or
    (edtValor.Text <> EmptyStr) then

    edtTotalProduto.Text :=
      FormatFloat('#0.00',
        uCalculos.TCalculos.Valor(
        StrToIntDef(edtQuantidade.Text, 0),
        StrToFloatDef(edtValor.Text, 0)));
end;

procedure TfPedidos.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  edtValor.KeyPress(Key, edtValor.Text, edtValor.SelStart, 7, 2);
end;

procedure TfPedidos.Excluir;
var
  oPedidoController: TPedidoController;
  sErro: string;
begin

  oPedidoController := TPedidoController.Create;
  try

    if oPedidoController.Excluir(iIdPedido, sErro) = False
    then
      raise Exception.Create(sErro);
    Pesquisar(tpHoje);

  finally
    FreeAndNil(oPedidoController);
  end;

end;

procedure TfPedidos.Excluir1Click(Sender: TObject);
begin
  ExcluirProduto;
end;

procedure TfPedidos.ExcluirProduto;
var
  oPedidoProdutoController: TPedidoProdutoController;
  sErro: string;
begin

  oPedidoProdutoController := TPedidoProdutoController.Create;
  try
    if (dmPedidos.cdsPedidoProdutos.Active) and (dmPedidos.cdsPedidoProdutos.RecordCount > 0)
    then
    begin
      if MessageDlg('Confirma a exclus�o?', mtConfirmation, [mbYes, mbNo], 0) = IDYES
      then
      begin
        if oPedidoProdutoController.ExcluirProduto(dmPedidos.cdsPedidoProdutosId.AsInteger, sErro) = False
        then
          raise Exception.Create(sErro);
        PesquisarProduto;
        edtTotalPedido.Text :=
          FormatFloat('#0.00', TotalizarPedido(iIdPedido));

      end;
    end
    else
      raise Exception.Create('Nenhum registro selecionado');

  finally
    FreeAndNil(oPedidoProdutoController);
  end;

end;

procedure TfPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  fPedidos := nil;
end;

procedure TfPedidos.FormCreate(Sender: TObject);
begin
  dmPedidos := TdmPedidos.Create(nil);
end;

procedure TfPedidos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dmPedidos);
end;

procedure TfPedidos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then begin
    Key := #0;
    if (sender is TDBGrid) then
      TDBGrid(Sender).Perform(WM_KeyDown, VK_Tab, 0)
    else
      Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfPedidos.FormShow(Sender: TObject);
begin
  HabilitarAcoes(acLista);
  Pesquisar(FTipoPesquisa);
end;

procedure TfPedidos.HabilitarAcoes(aAcao: TAcao);
begin

  pnlCarregaPedido.Visible := False;

  case aAcao of
    acInsere, acInsereProduto, acAlteraProduto, acAltera:
      begin
        PageControl.ActivePage := tsProdutos;
        btnFechar.Enabled := False;
        btnInserir.Enabled := False;

        if aAcao = acInsere then
        begin
          btnSalvar.Enabled := True;
          cboCliente.Enabled := True;
          CarregarLista(cboCliente);
          Limpar;
          btnCancelar.Enabled := True;
          btnPedido.Enabled := True;
        end
        else
        begin
          btnSalvar.Enabled := False;
          btnCancelar.Enabled := False;
          pnlProdutos.Visible := True;
          pnlTotal.Visible := True;
          btnConfirmar.Enabled := True;
          cboCliente.Enabled := False;
          LimparProduto;
          edtQuantidade.Text := '1';
          edtIdProduto.ReadOnly := aAcao = acAlteraProduto;
        end;
        if aAcao = acAlteraProduto then
          btnConfirmar.Tag := 1
        else if aAcao = acAltera then
          CarregarLista(cboCliente);
      end;
    acLista:
      begin
        PageControl.ActivePage := tsPedidos;
        pnlProdutos.Visible := False;
        pnlTotal.Visible := False;
        btnFechar.Enabled := True;
        btnInserir.Enabled := True;
        btnSalvar.Enabled := False;
        btnCancelar.Enabled := False;
        rbHoje.Checked := True;
      end;
  end;

end;

procedure TfPedidos.Inserir;
var
  oPedido: TPedido;
  oPedidoController: TPedidoController;
  sErro: string;
begin

  oPedido := TPedido.Create;
  oPedidoController := TPedidoController.Create;

  try
    oPedido.Cliente := cboCliente.Id(cboCliente.Text, '-');
    oPedido.Emissao := Now;

    if not oPedidoController.Inserir(oPedido, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oPedidoController);
    FreeAndNil(oPedido);
  end;

end;

procedure TfPedidos.InserirProduto;
var
  oPedidoProduto: TPedidoProduto;
  oPedidoProdutoController: TPedidoProdutoController;
  sErro: string;
begin

  oPedidoProduto := TPedidoProduto.Create;
  oPedidoProdutoController := TPedidoProdutoController.Create;

  try
    oPedidoProduto.Pedido := iIdPedido;
    oPedidoProduto.Produto := StrToInt(edtIdProduto.Text);
    oPedidoProduto.Quantidade := StrToInt(edtQuantidade.Text);
    oPedidoProduto.ValorUnitario := StrToFloat(edtValor.Text);
    oPedidoProduto.ValorTotal := uCalculos.TCalculos.Valor(oPedidoProduto.Quantidade,oPedidoProduto.ValorUnitario);

    if not oPedidoProdutoController.InserirProduto(oPedidoProduto, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oPedidoProdutoController);
    FreeAndNil(oPedidoProduto);
  end;

end;

procedure TfPedidos.Limpar;
begin
  cboCliente.ItemIndex := -1;
  cboCliente.SetFocus;
  dmPedidos.cdsPedidoProdutos.Close;
  LimparCalculos;
end;

procedure TfPedidos.LimparCalculos;
begin
  edtTotalProduto.Clear;
  edtTotalPedido.Clear;
end;

procedure TfPedidos.LimparProduto(bFoco: Boolean = True);
begin
  edtIdProduto.Clear;
  edtProduto.Clear;
  edtValor.Clear;
  edtQuantidade.Clear;
  edtTotalProduto.Clear;
  if bFoco then
    edtIdProduto.SetFocus;
end;

procedure TfPedidos.PesquisarProduto;
var
  oPedidoProdutoController: TPedidoProdutoController;
begin
  oPedidoProdutoController := TPedidoProdutoController.Create;
  try
    oPedidoProdutoController.Pesquisar(iIdPedido);
  finally
    FreeAndNil(oPedidoProdutoController);
  end;
end;

procedure TfPedidos.Pesquisar(tp: TTipoPesquisa);
var
  oPedidoController: TPedidoController;
begin

  oPedidoController := TPedidoController.Create;
  try
    case tp of
      tpHoje:
      begin
        oPedidoController.Pesquisar(date);
        rbHoje.Checked;
      end;
      tpTodos:
      begin
        oPedidoController.Pesquisar(0);
        rbTodos.Checked;
      end;
    end;
  finally
    FreeAndNil(oPedidoController);
  end;

end;

function TfPedidos.PesquisarId(iId: integer): Boolean;
var
  oPedidoController: TPedidoController;
  bEmpty: Boolean;
begin

  oPedidoController := TPedidoController.Create;
  try
    oPedidoController.Pesquisar(iId, bEmpty);
    Result := not bEmpty

  finally
    FreeAndNil(oPedidoController);
  end;

end;

procedure TfPedidos.rbHojeClick(Sender: TObject);
begin
  if rbHoje.Checked then
    FTipoPesquisa := tpHoje
  else if rbTodos.Checked then
    FTipoPesquisa := tpTodos;

  Pesquisar(FTipoPesquisa);
end;

function TfPedidos.RetornaItem(sLista: TStrings; sParam: string): Integer;
var
  i: Integer;
begin

  Result := -1;

  for i := 0 to sLista.Count - 1 do
  begin
    if pos(sParam, sLista[i]) > 0 then
    begin
      Result := i;
      Break;
    end;
  end;

end;

procedure TfPedidos.Salvar;
begin
  Inserir;
  CarregarId;
end;

procedure TfPedidos.SalvarProduto(aAcao: TAcao);
begin

  case aAcao of
    acInsereProduto: InserirProduto;
    acAlteraProduto: AlterarProduto;
  end;

  edtTotalPedido.Text :=
    FormatFloat('#0.00', TotalizarPedido(iIdPedido));

end;

function TfPedidos.TotalizarPedido(iIdPedido: Integer): Double;
begin
  dmPedidos.query.Close;
  dmPedidos.query.SQL.Clear;
  dmPedidos.query.SQL.Text :=
    ' SELECT SUM(ValorTotal) as Total FROM pedido_produtos WHERE pedido = :id ';
  dmPedidos.query.ParamByName('id').AsInteger := iIdPedido;
  dmPedidos.query.Open;

  Result := dmPedidos.query.FieldByName('Total').AsFloat;
end;

procedure TfPedidos.Validar(aAcao: TAcao);
var
  s: string;
begin

  if (aAcao = acInsere) then
  begin
    if cboCliente.ItemIndex = -1 then
      raise Exception.Create('Cliente n�o informado');
  end
  else if (aAcao = acInsereProduto) then
  begin
    if edtIdProduto.Text = EmptyStr then
      raise Exception.Create('Produto n�o informado');

    if BuscarProduto(StrToInt(edtIdProduto.Text), s) = 0 then
      raise Exception.Create('Produto n�o encontrado');

    if edtQuantidade.Text = EmptyStr then
      raise Exception.Create('Quantidade n�o informado');
  end
  else if (aAcao = acLista) then
  begin
    if TotalizarPedido(iIdPedido) = 0 then
    begin
      Excluir;
      HabilitarAcoes(aAcao);
      raise Exception.Create('Nenhum produto informado');
    end;
  end;

end;

end.
