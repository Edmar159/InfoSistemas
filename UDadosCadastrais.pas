unit UDadosCadastrais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls,system.json, dbClient, IdComponent, UHelpers;

type
  TfrmDadosCadastrais = class(TForm)
    pnFundo: TPanel;
    lbNome: TLabel;
    dbeNome: TDBEdit;
    dbeCPF: TDBEdit;
    lbCPF: TLabel;
    dbeRG: TDBEdit;
    lbRG: TLabel;
    dbeTelefone: TDBEdit;
    lbTelefone: TLabel;
    lbEmail: TLabel;
    dbeEmail: TDBEdit;
    lbPessoais: TLabel;
    bvPessoais: TBevel;
    bvEndereco: TBevel;
    lbEndereco: TLabel;
    lbCEP: TLabel;
    dbeCEP: TDBEdit;
    dbeLogradouro: TDBEdit;
    lbLogradouro: TLabel;
    dbeNumero: TDBEdit;
    lbNumero: TLabel;
    dbeComplemento: TDBEdit;
    lbComplemento: TLabel;
    dbeBairro: TDBEdit;
    lbBairro: TLabel;
    dbeCidade: TDBEdit;
    lbCidade: TLabel;
    dbeEstado: TDBEdit;
    lbEstado: TLabel;
    dbePais: TDBEdit;
    lbPais: TLabel;
    btnCancelar: TButton;
    btnFinalizar: TButton;
    procedure dbeCPFExit(Sender: TObject);
    procedure dbeEmailExit(Sender: TObject);
    procedure dbeCEPExit(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    var uHelper: THelper;
   procedure carregaCep(JSON: TJSONObject);
   procedure preparativosEmail;
  public
    { Public declarations }
  end;

var
  frmDadosCadastrais: TfrmDadosCadastrais;

implementation

{$R *.dfm}

uses DadosCadastraisDM, UConsomeApi, UEnviaEmail, IniFiles;

procedure TfrmDadosCadastrais.btnCancelarClick(Sender: TObject);
begin
  dmDadosCadastrais.limparCampos(true);
end;

procedure TfrmDadosCadastrais.btnFinalizarClick(Sender: TObject);
begin
  if (MessageDlg('Deseja salvar em arquivo XML e encaminhar e-mail?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    preparativosEmail;
end;

procedure TfrmDadosCadastrais.carregaCep(JSON: TJSONObject);
begin
  with (dmDadosCadastrais) do
  begin
    limparCamposEndereco(false);

    cdsDadosCOMPLEMENTO.AsString := Copy(JSON.Get('complemento').JsonValue.Value,0,99);
    cdsDadosLOGRADOURO.AsString := JSON.Get('logradouro').JsonValue.Value;
    cdsDadosBAIRRO.AsString := JSON.Get('bairro').JsonValue.Value;
    cdsDadosCIDADE.AsString := JSON.Get('localidade').JsonValue.Value;
    cdsDadosESTADO.AsString := JSON.Get('uf').JsonValue.Value;
    cdsDadosPAIS.AsString := 'BR';
  end;
end;

procedure TfrmDadosCadastrais.dbeCEPExit(Sender: TObject);
var LJsonObj: TJSONObject;
    ConsomeApi: TConsomeApi;
begin
   try
     ConsomeApi := TConsomeApi.Create();
     LJsonObj := ConsomeApi.GetCEP(uHelper.retornarApenasNumeros(dbeCep.Text));

     if(LJsonObj <> nil) then
        carregaCep(LJsonObj);
   finally
     if ConsomeApi <> nil then
        FreeAndNil(ConsomeApi);
   end;

end;

procedure TfrmDadosCadastrais.dbeCPFExit(Sender: TObject);
begin
  if not (uHelper.validarCPF(dbeCPF.Text)) then
  begin
    ShowMessage('CPF inválido!');
    dbeCpf.SetFocus;
  end;
end;

procedure TfrmDadosCadastrais.dbeEmailExit(Sender: TObject);
begin
  if not (uHelper.validarEmail(dbeEmail.text, true)) then
  begin
    ShowMessage('Email inválido!');
    dbeEmail.SetFocus;
  end;
end;

procedure TfrmDadosCadastrais.FormCreate(Sender: TObject);
begin
  ShowMessage('Para o funcionamento correto, faz-se necessário realizar as seguintes configurações: ' + #13#10 +
              ' - Ajustar parâmetros do SMTP no arquivo Config.ini em: raiz do projeto\Config' + #13#10 +
              ' - Caso não exista, criar pasta Output na raiz do projeto ');

  dmDadosCadastrais := TdmDadosCadastrais.Create(Application);
  dmDadosCadastrais.incluirNovoRegistro;

  uHelper := THelper.Create();
end;

procedure TfrmDadosCadastrais.preparativosEmail;
var email: TEnviaEmail;
    caminhoAbsoluto, destinatario, corpo: string;
begin
  InputQuery('Destinatário','Entre com destinatário do email:', destinatario);
  if uHelper.validarEmail(destinatario, false) then
  begin
    caminhoAbsoluto := ExtractFilePath(ParamStr(0)) +'Output\CdsTemp.xml';

    dmDadosCadastrais.salvarEmArquivo(caminhoAbsoluto);

    corpo:= uHelper.recuperarDadosArquivo(caminhoAbsoluto);

    try
      email := TEnviaEmail.Create();
      if email.EnviarEmail('Email com XML referente ao DataSet', destinatario, caminhoAbsoluto, corpo) then
        ShowMessage('Processo finalizado!');
    finally
      FreeAndNil(email);
    end;
  end
  else
    ShowMessage('Email inválido!');
end;

end.
