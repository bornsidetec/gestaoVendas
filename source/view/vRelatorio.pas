unit vRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons;

type
  TfRelatorio = class(TForm)
    pnlFiltros: TPanel;
    pnlAcoes: TPanel;
    ImageList: TImageList;
    ActionList: TActionList;
    actFechar: TAction;
    actVisualizar: TAction;
    btnFechar: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actFecharExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fRelatorio: TfRelatorio;

implementation

{$R *.dfm}

procedure TfRelatorio.actFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  fRelatorio := nil;
end;

end.
