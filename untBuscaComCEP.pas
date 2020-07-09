{** USO............: Liberado para cópia e alteração                      **
**  LINGUAGEM......: Delphi 10.3 Rio / Componentes Nativos                **
**  ----------------------------------------------------------------------**
**  DESENVOLVEDOR..: Bruno Batista                                        **
**  E-MAIL.........: batista.bjs@gmail.com                                ****  ----------------------------------------------------------------------**}

unit untBuscaComCEP;

interface

uses
  System.SysUtils, System.JSON, IdHTTP, IdSSLOpenSSL;

type
  TBuscaComCEP = class (TObject)
  strict private
    FCep: string;
    FLogradouro: string;
    FBairro: string;
    FCidade: string;
    FUF: string;
    FIBGE: string;
  private
    procedure proLocalizaCep;
  public
    constructor Create(const Cep: string); overload;
    property Cep: string read FCep;
    property Logradouro: string read FLogradouro;
    property Bairro: string read FBairro;
    property Cidade: string read FCidade;
    property UF: string read FUF;
    property IBGE: string read FIBGE;
  end;

implementation

{ TEndereco }

constructor TBuscaComCEP.Create(const Cep: string);
begin
  FCep := Cep;
  proLocalizaCep;
end;

procedure TBuscaComCEP.proLocalizaCep;
resourcestring
  __rINFORME_NR_CEP = 'Informe o número do cep.';
  __rCEP_INVALIDO = 'O número do CEP deve ser composto por 8 bytes.';
  __rCEP_NAO_ENCONTRADO = 'Cep não encontrado.';
const
  _rCep = 'cep';
  _rLogradouro = 'logradouro';
  _rBairro = 'bairro';
  _rLocalidade = 'localidade';
  _rUF = 'uf';
  _rWS = 'https://viacep.com.br/ws/';
  _rJSON = '/json/';
var
  idhttp1: TIdHTTP;
  idSSL: TIdSSLIOHandlerSocketOpenSSL;
  json: string;
  obj: TJSONObject;
begin
  FCep := StringReplace(Cep, '-', '', [rfReplaceAll]).Trim;
  if Cep.IsEmpty then
    raise Exception.Create(__rINFORME_NR_CEP);

  if Cep.Length <> 8 then
    raise Exception.Create(__rCEP_INVALIDO);

  IdHTTP1 := TIdHTTP.Create;
  try
    try
      idSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      idSSL.SSLOptions.Method := sslvSSLv3;
      idSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];

      //criação do request a API (uso necessário do atributo UserAgent)
      IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
      IdHTTP1.IOHandler := idSSL;
      //popula o json com os dados vindos da API
      json := IdHTTP1.Get(_rWS + Cep + _rJSON);
    finally
      idSSL.Free;
    end;
  finally
    IdHTTP1.Free;
  end;

  //Parse e Encode do Json para faciliar a captura de valores
  obj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(json),0) as TJSONObject;
  try
    if not obj.TryGetValue(_rCep, FCep) then
      raise Exception.Create(__rCEP_NAO_ENCONTRADO);

    //popula as variáveis do objeto TBuscaComCEP
    FCep := obj.GetValue<string>(_rCep);
    FLogradouro := obj.GetValue<string>(_rLogradouro);
    FBairro := obj.GetValue<string>(_rBairro);
    FCidade := obj.GetValue<string>(_rLocalidade);
    FUF := obj.GetValue<string>(_rUF);
  finally
   obj.Free;
  end;
end;

end.
