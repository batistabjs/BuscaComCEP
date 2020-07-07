## BuscaComCEP
Delphi Unit to search adress with Brazilian Zip-Code using viacep.com.br API

## How to Use
Download or Clone this repository with:
```
git clone https://github.com/batistabjs/BuscaComCEP.git
```
Import Unit _untBuscaComCEP.pas_ to your Delphi Project

## Sample to use
```
procedure TfrmMain.editCEPExit(Sender: TObject);
var
  _rEndereco: TBuscaComCEP;
begin
  eDS_END.Clear;
  eNM_BAIRRO.Clear;
  eNM_CIDADE.Clear;
  eDS_UF.Clear;

  if eCEP.Text = EmptyStr then
    Exit;

  _rEndereco := TBuscaComCEP.Create(editCEP.Text);
  try
    eDS_END.Text := _rEndereco.Logradouro;
    eNM_BAIRRO.Text := _rEndereco.Bairro;
    eNM_CIDADE.Text := _rEndereco.Cidade;
    eDS_UF.Text := _rEndereco.UF;
  finally
    _rEndereco.Free;
  end;
end;
```

## Next Project Steps
Build a Delphi Edit CEP Search Component