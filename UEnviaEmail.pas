unit UEnviaEmail;

{
  ***********************************************************************************************************
  ***********************************************************************************************************
  ****                      Implementa envio de emails, autor: Adriano Santos                            ****
  **** https://portal.tdevrocks.com.br/2017/05/05/tutorial-como-enviar-e-mail-pelo-gmail-com-delphi-10/  ****
  ****                    Realizado leves adaptações para seguir a regra de negócio                      ****
  ***********************************************************************************************************
  ***********************************************************************************************************
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TEnviaEmail = class
  private
    { Private declarations }
  public
    { Public declarations }
    function EnviarEmail(const AAssunto, ADestino, AAnexo: String; ACorpo: String): Boolean;
  end;

implementation

uses IniFiles,IdTCPConnection,IdTCPClient,IdHTTP,IdBaseComponent,IdMessage,IdExplicitTLSClientServerBase,IdMessageClient,
     IdSMTPBase,IdSMTP,IdIOHandler,IdIOHandlerSocket,IdIOHandlerStack,IdSSL,IdSSLOpenSSL,IdAttachmentFile,IdText,
  UHelpers;

  { TEnviaEmail }

function TEnviaEmail.EnviarEmail(const AAssunto, ADestino, AAnexo: String;
  ACorpo: String): Boolean;
var
  DidException         : Boolean;
  IniFile              : TIniFile;
  sFrom                : String;
  sBccList             : String;
  sHost                : String;
  iPort                : Integer;
  sUserName            : String;
  sPassword            : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
begin
  try
    try
      IniFile                          := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config\Config.ini');
      sFrom                            := IniFile.ReadString('Email' , 'From'     , sFrom);
      sBccList                         := IniFile.ReadString('Email' , 'BccList'  , sBccList);
      sHost                            := IniFile.ReadString('Email' , 'Host'     , sHost);
      iPort                            := IniFile.ReadInteger('Email', 'Port'     , iPort);
      sUserName                        := IniFile.ReadString('Email' , 'UserName' , sUserName);
      sPassword                        := IniFile.ReadString('Email' , 'Password' , sPassword);

      //Configura os parâmetros necessários para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create();
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Variável referente a mensagem
      idMsg                            := TIdMessage.Create();
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'MEU ASSUNTO';
      idMsg.From.Address               := sFrom;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinatário(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;
      idMsg.CCList.EMailAddresses      := '';
      idMsg.BccList.EMailAddresses    := sBccList;
      idMsg.BccList.EMailAddresses    := ''; //Cópia Oculta

      //Variável do texto
      idText := TIdText.Create(idMsg.MessageParts);
      idText.Body.Add(ACorpo);
      idText.ContentType := 'text/xml; application/xml;';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create();
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := sUserName;
      IdSMTP.Password                  := sPassword;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      if AAnexo <> EmptyStr then
        if FileExists(AAnexo) then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      //Se a conexão foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            ShowMessage('Erro ao tentar enviar: ' + E.Message);
            DidException := true;
          end;
        end;
      end;

      if not DidException then
        Result := True;
    finally
      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      UnLoadOpenSSLLibrary;

      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;
end.
