program Info;

uses
  Vcl.Forms,
  UDadosCadastrais in 'UDadosCadastrais.pas' {frmDadosCadastrais},
  DadosCadastraisDM in 'DadosCadastraisDM.pas' {dmDadosCadastrais: TDataModule},
  UConsomeApi in 'UConsomeApi.pas',
  UHelpers in 'UHelpers.pas',
  UEnviaEmail in 'UEnviaEmail.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDadosCadastrais, frmDadosCadastrais);
  Application.Run;
end.
