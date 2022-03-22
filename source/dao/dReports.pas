unit dReports;

interface

uses
  System.SysUtils, System.Classes, dConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmReports = class(TDataModule)
    qryRelatorio: TFDQuery;
    qryRelatorioData: TWideStringField;
    qryRelatorioTanqueId: TIntegerField;
    qryRelatorioTanque: TStringField;
    qryRelatorioBombaId: TIntegerField;
    qryRelatorioBomba: TStringField;
    qryRelatorioTotalPagar: TFloatField;
    qryRelatorioValorImposto: TFloatField;
    qryRelatorioCombustivel: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmReports: TdmReports;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
