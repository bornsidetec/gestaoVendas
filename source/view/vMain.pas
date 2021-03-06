unit vMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls;

type
  TfMain = class(TForm)
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Movimentao1: TMenuItem;
    ActionList: TActionList;
    actImpostos: TAction;
    actCombustiveis: TAction;
    actTanques: TAction;
    actBombas: TAction;
    actAbastecimentos: TAction;
    actRelAbastecimentos: TAction;
    StatusBar: TStatusBar;
    actSobre: TAction;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    actClientes: TAction;
    actProdutos: TAction;
    actPedidos: TAction;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    Pedidos1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actSobreExecute(Sender: TObject);
    procedure actClientesExecute(Sender: TObject);
    procedure actProdutosExecute(Sender: TObject);
    procedure actPedidosExecute(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirForm(T: TFormClass; F: TForm);
    procedure CaminhoBD;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses vSobre, vProdutos, vClientes, vPedidos;

procedure TfMain.AbrirForm(T: TFormClass; F: TForm);
begin
  if not Assigned(F) then
    Application.CreateForm(T, F);
  F.Show;
end;

procedure TfMain.actClientesExecute(Sender: TObject);
begin
  AbrirForm(TFClientes, FClientes);
end;

procedure TfMain.actPedidosExecute(Sender: TObject);
begin
  AbrirForm(TFPedidos, FPedidos);
end;

procedure TfMain.actProdutosExecute(Sender: TObject);
begin
  AbrirForm(TFProdutos, FProdutos);
end;

procedure TfMain.actSobreExecute(Sender: TObject);
begin
  AbrirForm(TfSobre, fSobre);
end;

procedure TfMain.CaminhoBD;
var
  slAcesso: TStringList;
begin
  slAcesso := TStringList.Create;
  try
    slAcesso.LoadFromFile('acesso.config');
    StatusBar.Panels[0].Text := slAcesso[4];
    StatusBar.Panels[1].Text := slAcesso[2];
  finally
    FreeAndNil(slAcesso);
  end;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  for i := 0 to MDIChildCount - 1 do
    MDIChildren[i].close;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  CaminhoBD;
end;

end.
