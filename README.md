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
  LabeledEdit2.Clear;
  LabeledEdit3.Clear;
  LabeledEdit4.Clear;
  LabeledEdit5.Clear;
  LabeledEdit6.Clear;

  if LabeledEdit1.Text = EmptyStr then
    Exit;

  _rEndereco := TBuscaComCEP.Create(LabeledEdit1.Text);
  try
    LabeledEdit2.Text := _rEndereco.Logradouro;
    LabeledEdit4.Text := _rEndereco.Bairro;
    LabeledEdit5.Text := _rEndereco.Cidade;
    LabeledEdit6.Text := _rEndereco.UF;
  finally
    _rEndereco.Free;
  end;
end;
```

## Next Project Steps
Build a Delphi CEP_Search Edit Component
