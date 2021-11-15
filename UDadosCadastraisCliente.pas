unit UDadosCadastraisCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls,system.json, dbClient,
  IdComponent;

type
  TfrmDadosCadastraisCliente = class(TForm)
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
    Button1: TButton;
    Button2: TButton;
    procedure dbeCPFExit(Sender: TObject);
    procedure dbeEmailExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCEPExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
   procedure carregaCep(JSON: TJSONObject);
   procedure limparCampos;
  public
    { Public declarations }
  end;

var
  frmDadosCadastraisCliente: TfrmDadosCadastraisCliente;



implementation

{$R *.dfm}

uses DadosCadastraisDM, UConsomeApi, UEnviaEmail;

procedure TfrmDadosCadastraisCliente.Button1Click(Sender: TObject);
begin
  dmDadosCadastrais.limpaCampos;
//  dmDadosCadastrais.cdsDados.SaveToFile('C:\temp\temp.xml');
end;

procedure TfrmDadosCadastraisCliente.Button2Click(Sender: TObject);
var email: TEnviaEmail;
begin
  email := TEnviaEmail.Create();
  email.EnviarEmail('TESTE', 'dema159@msn.com','C:\temp\temp.xml','abc');
end;

procedure TfrmDadosCadastraisCliente.carregaCep(JSON: TJSONObject);
begin
  limparCampos;

  dmDadosCadastrais.cdsDados.Active := true;
  dmDadosCadastrais.cdsDados.Append;
  dmDadosCadastrais.cdsDadosCOMPLEMENTO.AsString := Copy(JSON.Get('complemento').JsonValue.Value,0,99);
  dmDadosCadastrais.cdsDadosLOGRADOURO.AsString := JSON.Get('logradouro').JsonValue.Value;
  dmDadosCadastrais.cdsDadosBAIRRO.AsString := JSON.Get('bairro').JsonValue.Value;
  dmDadosCadastrais.cdsDadosCIDADE.AsString := JSON.Get('localidade').JsonValue.Value;
  dmDadosCadastrais.cdsDadosESTADO.AsString := JSON.Get('uf').JsonValue.Value;
  dmDadosCadastrais.cdsDadosPAIS.AsString := 'BR';



  dbeComplemento.Text := Copy(JSON.Get('complemento').JsonValue.Value,0,99);
  dbeLogradouro.Text := JSON.Get('logradouro').JsonValue.Value;
  dbeBAIRRO.Text := JSON.Get('bairro').JsonValue.Value;
  dbeCidade.Text := JSON.Get('localidade').JsonValue.Value;
  dbeEstado.Text := JSON.Get('uf').JsonValue.Value;
  dbePAIS.Text := 'BR';

end;

procedure TfrmDadosCadastraisCliente.dbeCEPExit(Sender: TObject);
var LJsonObj: TJSONObject;
    ConsomeApi: TConsomeApi;
begin
   ConsomeApi := TConsomeApi.Create();
   LJsonObj := ConsomeApi.GetCEP(dbeCep.Text);

   if(LJsonObj <> nil) then
     carregaCep(LJsonObj);
end;

procedure TfrmDadosCadastraisCliente.dbeCPFExit(Sender: TObject);
begin
  if not (dmDadosCadastrais.validarCPF(dbeCPF.Text)) then
  begin
    ShowMessage('CPF inválido!');
    dbeCpf.SetFocus;
  end;
end;

procedure TfrmDadosCadastraisCliente.dbeEmailExit(Sender: TObject);
begin
  if not (dmDadosCadastrais.validarEmail(dbeEmail.text)) then
  begin
    ShowMessage('Email inválido!');
    dbeEmail.SetFocus;
  end;
end;

procedure TfrmDadosCadastraisCliente.FormCreate(Sender: TObject);
begin
  dmDadosCadastrais := TdmDadosCadastrais.Create(Application);
  dmDadosCadastrais.incluirNovoRegistro(true);
end;

procedure TfrmDadosCadastraisCliente.FormDestroy(Sender: TObject);
begin
  if Assigned(dmDadosCadastrais) then
    FreeAndNil(dmDadosCadastrais);
end;


procedure TfrmDadosCadastraisCliente.limparCampos;
begin     {
    dmDadosCadastrais.cdsDadosCOMPLEMENTO.Clear;
    dmDadosCadastrais.cdsDadosLOGRADOURO.Clear;
    dmDadosCadastrais.cdsDadosBAIRRO.Clear;
    dmDadosCadastrais.cdsDadosCIDADE.Clear;
    dmDadosCadastrais.cdsDadosESTADO.Clear;
    dmDadosCadastrais.cdsDadosPAIS.Clear;}
end;

end.
