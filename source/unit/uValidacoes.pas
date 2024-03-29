unit uValidacoes;

interface

uses
  System.SysUtils;

type
  TValidacoes = class
  private
    { private declarations }
  public
    { public declarations }
    class function ValidaDatas(sData1, sData2: string; out sErro: string;
      out dData1, dData2: TDateTime): Boolean;
  end;

implementation

{ TValidacoes }

class function TValidacoes.ValidaDatas(sData1, sData2: string;
  out sErro: string; out dData1, dData2: TDateTime): Boolean;
begin

  Result := True;
  sErro := '';

  if sData1 = '  /  /    ' then
  begin
    sErro := 'Data Inicial n�o preenchida';
    Result := False;
    Exit;
  end;

  try
    dData1 := StrToDate(sData1);
  except
    sErro := 'Data Inicial Inv�lida';
    Result := False;
    Exit;
  end;

  if sData2 = '  /  /    ' then
  begin
    sErro := 'Data Final n�o preenchida';
    Result := False;
    Exit;
  end;

  try
    dData2 := StrToDateTime(sData2 + ' 23:59:59');
  except
    sErro := 'Data Final Inv�lida';
    Result := False;
    Exit;
  end;

  if dData1 > dData2 then
  begin
    sErro := 'Data Inicial maior que a data Final';
    Result := False;
    Exit;
  end;

end;

end.
