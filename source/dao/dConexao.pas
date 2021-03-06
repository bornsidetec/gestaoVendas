unit dConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TdmConexao = class(TDataModule)
    Conexao: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Conectar;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmConexao }

{ TdmConexao }

procedure TdmConexao.Conectar;
var
  slAcesso: TStringList;
begin

  slAcesso := TStringList.Create;

  if FileExists('acesso.config') then
    slAcesso.LoadFromFile('acesso.config')
  else
  begin
    slAcesso.Add('DriverID=MySQL');
    slAcesso.Add('Port=3306');
    slAcesso.Add('Database=vendas');
    slAcesso.Add('Password=B182114o');
    slAcesso.Add('Server=localhost');
    slAcesso.Add('User_Name=root');

    slAcesso.SaveToFile('acesso.config');
  end;

  try

    Conexao.Params.Clear;
    Conexao.Params.Add(slAcesso[0]); //Driver
    Conexao.Params.Add(slAcesso[1]); //Port
    Conexao.Params.Add(slAcesso[2]); //Database
    Conexao.Params.Add(slAcesso[3]); //Password
    Conexao.Params.Add(slAcesso[4]); //Server
    Conexao.Params.Add(slAcesso[5]); //User_Name

    try
      Conexao.Connected := True;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
      end;

    end;

  finally
    FreeAndNil(slAcesso);
  end;

end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  Conexao.Connected := False;
  Conectar;
end;

end.
