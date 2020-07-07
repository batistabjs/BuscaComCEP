## BuscaComCEP
Delphi Unit to search address with Brazilian Zip-Code using viacep.com.br API

## How to Use
Download or Clone this repository with:
```
git clone https://github.com/batistabjs/BuscaComCEP.git
```
Import Unit _untBuscaComCEP.pas_ to your Delphi Project

## Example to use
```
//untMain
uses untBuscaComCEP;

procedure TfrmMain.editCEPExit(Sender: TObject);
var
  _rEndereco: TBuscaComCEP;
begin
  editEND.Clear;
  editBAIRRO.Clear;
  editCIDADE.Clear;
  editUF.Clear;

  if eCEP.Text = EmptyStr then
    Exit;

  _rEndereco := TBuscaComCEP.Create(editCEP.Text);
  try
    editEND.Text := _rEndereco.Logradouro;
    editBAIRRO.Text := _rEndereco.Bairro;
    editCIDADE.Text := _rEndereco.Cidade;
    editUF.Text := _rEndereco.UF;
  finally
    _rEndereco.Free;
  end;
end;
```

## Next Project Steps
Build a Delphi Edit CEP_Search Component
