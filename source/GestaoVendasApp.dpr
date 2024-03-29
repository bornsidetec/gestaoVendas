program GestaoVendasApp;

uses
  Vcl.Forms, MidasLib,
  vMain in 'view\vMain.pas' {fMain},
  dConexao in 'dao\dConexao.pas' {dmConexao: TDataModule},
  vCadastro in 'view\vCadastro.pas' {fCadastro},
  hEdit in 'helper\hEdit.pas',
  hComboBox in 'helper\hComboBox.pas',
  uCalculos in 'unit\uCalculos.pas',
  vRelatorio in 'view\vRelatorio.pas' {fRelatorio},
  dReports in 'dao\dReports.pas' {dmReports: TDataModule},
  uValidacoes in 'unit\uValidacoes.pas',
  vSobre in 'view\vSobre.pas' {fSobre},
  mProduto in 'model\mProduto.pas',
  dProduto in 'dao\dProduto.pas' {dmProduto: TDataModule},
  cProduto in 'controller\cProduto.pas',
  vProdutos in 'view\vProdutos.pas' {fProdutos},
  mCliente in 'model\mCliente.pas',
  dCliente in 'dao\dCliente.pas' {dmCliente: TDataModule},
  cCliente in 'controller\cCliente.pas',
  vClientes in 'view\vClientes.pas' {fClientes},
  vPedidos in 'view\vPedidos.pas' {fPedidos},
  mPedido in 'model\mPedido.pas',
  dPedido in 'dao\dPedido.pas' {dmPedidos: TDataModule},
  cPedido in 'controller\cPedido.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TdmConexao, dmConexao);
  if dmConexao.Conexao.Connected then
    Application.Run
  else
    Application.Terminate;

end.
