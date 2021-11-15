unit DadosCadastraisDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient ;

type
  TdmDadosCadastrais = class(TDataModule)
    cdsDados: TClientDataSet;
    dsDados: TDataSource;
    cdsDadosNOME: TStringField;
    cdsDadosRG: TStringField;
    cdsDadosCPF: TStringField;
    cdsDadosTELEFONE: TStringField;
    cdsDadosEMAIL: TStringField;
    cdsDadosCEP: TStringField;
    cdsDadosLOGRADOURO: TStringField;
    cdsDadosNUMERO: TStringField;
    cdsDadosCOMPLEMENTO: TStringField;
    cdsDadosBAIRRO: TStringField;
    cdsDadosCIDADE: TStringField;
    cdsDadosESTADO: TStringField;
    cdsDadosPAIS: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure limparCampos(bApagarCep: Boolean);
    procedure limparCamposEndereco(bApagarCep: Boolean);
    procedure incluirNovoRegistro(bCriarDataset: Boolean = true);
    procedure salvarEmArquivo(caminhoAbsoluto: string);
  end;

var
  dmDadosCadastrais: TdmDadosCadastrais;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmDadosCadastrais }

procedure TdmDadosCadastrais.incluirNovoRegistro(bCriarDataset: Boolean = true);
begin
  if bCriarDataset then
  begin
    cdsDados.CreateDataSet;
    cdsDados.Open;
  end;
  cdsDados.Insert;
end;

procedure TdmDadosCadastrais.limparCampos(bApagarCep: Boolean);
begin
  if((cdsDados.State <> dsInsert)) then
    cdsDados.Insert;

   cdsDadosNOME.Clear;
   cdsDadosRG.Clear;
   cdsDadosCPF.Clear;
   cdsDadosTELEFONE.Clear;
   cdsDadosEMAIL.Clear;

   limparCamposEndereco(bApagarCep);
   incluirNovoRegistro(false);
end;

procedure TdmDadosCadastrais.limparCamposEndereco(bApagarCep: Boolean);
begin
   if bApagarCep then
    cdsDadosCEP.Clear;

  cdsDadosCOMPLEMENTO.Clear;
  cdsDadosLOGRADOURO.Clear;
  cdsDadosBAIRRO.Clear;
  cdsDadosCIDADE.Clear;
  cdsDadosESTADO.Clear;
  cdsDadosPAIS.Clear;
end;

procedure TdmDadosCadastrais.salvarEmArquivo(caminhoAbsoluto: String);
begin
  cdsDados.SaveToFile(caminhoAbsoluto);
end;

end.
