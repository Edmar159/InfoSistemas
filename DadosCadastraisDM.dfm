object dmDadosCadastrais: TdmDadosCadastrais
  OldCreateOrder = True
  Height = 192
  Width = 253
  object cdsDados: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDados'
    Left = 32
    Top = 64
    object cdsDadosNOME: TStringField
      FieldName = 'NOME'
      Size = 150
    end
    object cdsDadosRG: TStringField
      FieldName = 'RG'
    end
    object cdsDadosCPF: TStringField
      FieldName = 'CPF'
      EditMask = '000.000.000-00;1;_'
      Size = 14
    end
    object cdsDadosTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 19
    end
    object cdsDadosEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 50
    end
    object cdsDadosCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object cdsDadosLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 200
    end
    object cdsDadosNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 10
    end
    object cdsDadosCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 100
    end
    object cdsDadosBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object cdsDadosCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 30
    end
    object cdsDadosESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object cdsDadosPAIS: TStringField
      FieldName = 'PAIS'
      Size = 2
    end
  end
  object dsDados: TDataSource
    DataSet = cdsDados
    Left = 32
    Top = 16
  end
end
