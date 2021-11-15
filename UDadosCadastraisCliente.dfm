object frmDadosCadastraisCliente: TfrmDadosCadastraisCliente
  Left = 0
  Top = 0
  Caption = 'Dados Cadastrais'
  ClientHeight = 429
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnFundo: TPanel
    Left = 0
    Top = 0
    Width = 506
    Height = 429
    Align = alClient
    TabOrder = 0
    object lbNome: TLabel
      Left = 12
      Top = 36
      Width = 77
      Height = 13
      Caption = 'Nome completo:'
    end
    object lbCPF: TLabel
      Left = 12
      Top = 84
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object lbRG: TLabel
      Left = 260
      Top = 84
      Width = 18
      Height = 13
      Caption = 'RG:'
    end
    object lbTelefone: TLabel
      Left = 12
      Top = 132
      Width = 46
      Height = 13
      Caption = 'Telefone:'
    end
    object lbEmail: TLabel
      Left = 260
      Top = 132
      Width = 24
      Height = 13
      Caption = 'Email'
    end
    object lbPessoais: TLabel
      Left = 8
      Top = 16
      Width = 41
      Height = 13
      Caption = 'Pessoais'
    end
    object bvPessoais: TBevel
      Left = 53
      Top = 25
      Width = 200
      Height = 2
    end
    object bvEndereco: TBevel
      Left = 57
      Top = 200
      Width = 196
      Height = 2
    end
    object lbEndereco: TLabel
      Left = 8
      Top = 191
      Width = 45
      Height = 13
      Caption = 'Endere'#231'o'
    end
    object lbCEP: TLabel
      Left = 12
      Top = 212
      Width = 19
      Height = 13
      Caption = 'CEP'
    end
    object lbLogradouro: TLabel
      Left = 100
      Top = 212
      Width = 55
      Height = 13
      Caption = 'Logradouro'
    end
    object lbNumero: TLabel
      Left = 410
      Top = 212
      Width = 16
      Height = 13
      Caption = 'N'#176':'
    end
    object lbComplemento: TLabel
      Left = 12
      Top = 260
      Width = 65
      Height = 13
      Caption = 'Complemento'
    end
    object lbBairro: TLabel
      Left = 12
      Top = 308
      Width = 28
      Height = 13
      Caption = 'Bairro'
    end
    object lbCidade: TLabel
      Left = 260
      Top = 308
      Width = 37
      Height = 13
      Caption = 'Cidade:'
    end
    object lbEstado: TLabel
      Left = 12
      Top = 357
      Width = 37
      Height = 13
      Caption = 'Estado:'
    end
    object lbPais: TLabel
      Left = 100
      Top = 357
      Width = 23
      Height = 13
      Caption = 'Pais:'
    end
    object dbeNome: TDBEdit
      Left = 12
      Top = 55
      Width = 486
      Height = 21
      DataField = 'NOME'
      DataSource = dmDadosCadastrais.dsPessoas
      TabOrder = 0
    end
    object dbeCPF: TDBEdit
      Left = 12
      Top = 103
      Width = 238
      Height = 21
      DataField = 'cpf_cnpj'
      DataSource = dmDadosCadastrais.dsPessoas
      MaxLength = 14
      TabOrder = 1
      OnExit = dbeCPFExit
    end
    object dbeRG: TDBEdit
      Left = 260
      Top = 103
      Width = 238
      Height = 21
      DataField = 'RG'
      DataSource = dmDadosCadastrais.dsPessoas
      TabOrder = 2
    end
    object dbeTelefone: TDBEdit
      Left = 12
      Top = 151
      Width = 238
      Height = 21
      DataField = 'TELEFONE'
      DataSource = dmDadosCadastrais.dsPessoas
      TabOrder = 3
    end
    object dbeEmail: TDBEdit
      Left = 260
      Top = 151
      Width = 238
      Height = 21
      DataField = 'EMAIL'
      DataSource = dmDadosCadastrais.dsPessoas
      TabOrder = 4
      OnExit = dbeEmailExit
    end
    object dbeCEP: TDBEdit
      Left = 12
      Top = 231
      Width = 78
      Height = 21
      DataField = 'CEP'
      DataSource = dmDadosCadastrais.dsPessoas
      MaxLength = 14
      TabOrder = 5
      OnExit = dbeCEPExit
    end
    object dbeLogradouro: TDBEdit
      Left = 100
      Top = 231
      Width = 300
      Height = 21
      DataField = 'LOGRADOURO'
      DataSource = dmDadosCadastrais.dsPessoas
      MaxLength = 14
      TabOrder = 6
    end
    object dbeNumero: TDBEdit
      Left = 410
      Top = 231
      Width = 88
      Height = 21
      DataField = 'NUMERO'
      DataSource = dmDadosCadastrais.dsPessoas
      MaxLength = 14
      TabOrder = 7
    end
    object dbeComplemento: TDBEdit
      Left = 12
      Top = 279
      Width = 486
      Height = 21
      DataField = 'COMPLEMENTO'
      DataSource = dmDadosCadastrais.dsPessoas
      MaxLength = 14
      TabOrder = 8
    end
    object dbeBairro: TDBEdit
      Left = 12
      Top = 327
      Width = 238
      Height = 21
      DataField = 'BAIRRO'
      DataSource = dmDadosCadastrais.dsPessoas
      MaxLength = 14
      TabOrder = 9
    end
    object dbeCidade: TDBEdit
      Left = 260
      Top = 327
      Width = 238
      Height = 21
      DataField = 'CIDADE'
      DataSource = dmDadosCadastrais.dsPessoas
      MaxLength = 14
      TabOrder = 10
    end
    object dbeEstado: TDBEdit
      Left = 12
      Top = 376
      Width = 78
      Height = 21
      DataField = 'ESTADO'
      DataSource = dmDadosCadastrais.dsPessoas
      MaxLength = 14
      TabOrder = 11
    end
    object dbePais: TDBEdit
      Left = 100
      Top = 376
      Width = 78
      Height = 21
      DataField = 'PAIS'
      DataSource = dmDadosCadastrais.dsPessoas
      MaxLength = 14
      TabOrder = 12
    end
    object Button1: TButton
      Left = 310
      Top = 387
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 13
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 410
      Top = 387
      Width = 75
      Height = 25
      Caption = 'Button2'
      TabOrder = 14
      OnClick = Button2Click
    end
  end
end
