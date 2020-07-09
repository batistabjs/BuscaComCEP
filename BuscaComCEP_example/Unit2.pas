unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TForm2 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    procedure LabeledEdit1Exit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  untBuscaComCEP;


{$R *.dfm}

procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TForm2.LabeledEdit1Exit(Sender: TObject);
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

end.
