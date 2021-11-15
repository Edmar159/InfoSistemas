unit UConsomeApi;

interface

uses idHTTP, system.json, idSSLOpenSSL,System.Classes, System.SysUtils, Vcl.Dialogs;

type
  TConsomeApi = class
  private
   function GetCEPCalculo(sCep: string): TJSONObject;
  public
   function GetCEP(sCEP: string): TJSONObject;

  end;

  const
  C_SYS_CEP = '<<CEP>>';
  C_SYS_HTTP_URL = 'https://viacep.com.br/ws/'+C_SYS_CEP + '/json';
  C_MSG_CEP_NAO_ENCONTRADO = 'CEP não encontrado';
  C_MSG_CEP_INVALIDO = 'CEP inválido!';

implementation

  { TConsomeApi }

function TConsomeApi.GetCEPCalculo(sCEP: string): TJSONObject;
var
  idHttp: TidHTTP;
  idSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  ssRetorno: TStringStream;
  LJsonObj: TJsonObject;
begin
  try
    Result := nil;

    idHttp := TidHttp.Create;
    idSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
    idHttp.IOHandler := idSSLHandler;
    idSSLHandler.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

    ssRetorno := TStringStream.Create('');

    idHttp.Get(StringReplace(C_SYS_HTTP_URL,C_SYS_CEP,sCEP, [rfReplaceAll, rfIgnoreCase]), ssRetorno);

    if(idHTTP.ResponseCode = 200) and
      (not (Utf8ToAnsi(ssRetorno.DataString) = '{'#$A'   "erro": true'#$A'}')) then
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Utf8ToAnsi(ssRetorno.DataString)),0) as TJSONObject;


  finally
    FreeAndNil(idHttp);
    FreeAndNil(idSSLHandler);
    ssRetorno.Destroy;
  end;

end;

function TConsomeApi.GetCEP(sCep: string): TJSONObject;
var  LJsonObj: TJsonObject;
begin
  result := nil;

  if Length(sCep) <> 8 then
    ShowMessage(C_MSG_CEP_INVALIDO)
  else
  begin
     LJsonObj := GetCepCalculo(sCep);

    if LJsonOBJ <> nil then
      result := LJsonObj
    else
      ShowMessage(C_MSG_CEP_NAO_ENCONTRADO);
  end;
end;

end.
