unit UHelpers;

interface
uses System.SysUtils,RegularExpressions;

type
  THelper = class
  private
    { Private declarations }
    function sequenciaInvalida(sCPF: string): Boolean;
    function gerarDigitosCPF(sPrefixo: String): String;
  public
    { Public declarations }
    function validarCPF(sCPF :string): Boolean;
    function retornarApenasNumeros(sTexto: string) : String;
    procedure gerarXML(caminhoAbsoluto, conteudo: string);
    function validarEmail(sEmail: string; bAceitaVazio: Boolean): Boolean;
    function recuperarDadosArquivo(caminhoAbsoluto: string): string;
  end;

implementation

{ THelper }

function THelper.gerarDigitosCPF(sPrefixo: String): String;
var
  retorno : string;
  j, k, i, iSoma : Integer;
  Dig : Byte;
begin
    for j := 1 to 2 do
    begin
	    K := 2;
	    iSoma := 0;
	    for i:=Length(sPrefixo+retorno) Downto 1 do
	    begin
		    iSoma := iSoma + (k * (byte((sPrefixo + retorno)[i]) - byte('0')) );
		    Inc(k);
	    end;

	    Dig := 11 - (iSoma mod 11);
	    if Dig > 9 then
        Dig := 0;

	    retorno := retorno + IntToStr(Dig);
    end;

    result := retorno;
end;

procedure THelper.gerarXML(caminhoAbsoluto, conteudo: string);
var
  Arq : string;
  Local : TextFile;
begin
  Arq := caminhoAbsoluto;
  AssignFile(Local, caminhoAbsoluto);
  if not FileExists(Arq) then
  begin
    Rewrite(Local, caminhoAbsoluto);
    Append(Local);
    WriteLn(Local, conteudo);
  end;
  CloseFile(Local);
end;

function THelper.recuperarDadosArquivo(caminhoAbsoluto: string): string;
var
  corpo, linha: string;
  arq: TextFile;
begin
  AssignFile(arq,caminhoAbsoluto);
  {$I-}
  Reset(arq);
  {$I+}

  if (IOResult <> 0) then
    corpo :='Erro na abertura do arquivo !'
  else
  begin
    while (not eof(arq)) do
    begin
     readln(arq, linha);

     corpo:= corpo + linha + #13#10;
    end;

    CloseFile(arq);
  end;

  result:= corpo;
end;

function THelper.retornarApenasNumeros(sTexto: string): String;
var i: Integer;
begin
    for i := 1 to Length(sTexto) do
		  if not (sTexto[i] in ['0'..'9']) then
		    Delete(sTexto,i,1);

    result:= sTexto;
end;

function THelper.sequenciaInvalida(sCPF: string): Boolean;
begin
  if ((sCPF = '00000000000') or
      (sCPF = '33333333333') or
      (sCPF = '11111111111') or
      (sCPF = '22222222222') or
      (sCPF = '44444444444') or
      (sCPF = '55555555555') or
      (sCPF = '66666666666') or
      (sCPF = '77777777777') or
      (sCPF = '88888888888') or
      (sCPF = '99999999999')) then
        Result := true;
end;

function THelper.validarCPF(sCPF: string): Boolean;
var
   sPrefixo, sCPFCompleto, sDigitos: String;
begin
    sPrefixo := Copy(sCPF,1,Length(sCPF)-2);
    sPrefixo := retornarApenasNumeros(sPrefixo);

    sCPFCompleto := sPrefixo + Copy(sCPF,Pos('-',sCPF)+1,2);

    if (sequenciaInvalida(sCPFCompleto)) then
    begin
        Result := false;
        Exit;
    end;

    sDigitos := gerarDigitosCPF(sPrefixo);

    Result := sDigitos = Copy(sCPF,Pos('-',sCPF)+1,2);
end;

function THelper.validarEmail(sEmail: string; bAceitaVazio: Boolean): Boolean;
var
  RegEx: TRegEx;
begin
  if (sEmail = emptyStr) then
  begin
    Result:= bAceitaVazio;
    Exit;
  end;

  RegEx := TRegex.Create('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]*[a-zA-Z0-9]+$');
  Result := RegEx.Match(sEmail).Success;
end;

end.
