unit uCalculos;

interface

type
  TCalculos = class
  public
    { public declarations }
    class function Valor(iQuantidade, dValor: Double): Double;
    class function Imposto(dAliquota, dValor: Double): Double;
    class function Total(dAliquota, dValor: Double): Double;
  end;

implementation

{ TCalculos }

class function TCalculos.Imposto(dAliquota, dValor: Double): Double;
begin
  Result := dValor * (dAliquota / 100);
end;

class function TCalculos.Total(dAliquota, dValor: Double): Double;
begin
  Result := dValor * (1 + (dAliquota / 100));
end;

class function TCalculos.Valor(iQuantidade, dValor: Double): Double;
begin
  Result := iQuantidade * dValor;
end;

end.
