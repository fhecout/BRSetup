unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Registry, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure AlterarTodasAsPastas;
    procedure AlterarRegistro(const AKey: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.AlterarTodasAsPastas;
var
  Reg: TRegistry;    // Objeto utilizado para acessar o registro do Windows
  KeyList: TStringList;   // Lista de nomes de chaves do registro
  i: Integer;
begin
  Reg := TRegistry.Create;
  KeyList := TStringList.Create;
  try
    Reg.RootKey := HKEY_USERS;

    // Abre a chave raiz em modo somente leitura
    if Reg.OpenKeyReadOnly('') then
    begin
      // Obtém a lista de nomes de chaves dentro da chave raiz
      Reg.GetKeyNames(KeyList);

      // Itera sobre cada nome de chave na lista
      for i := 0 to KeyList.Count - 1 do
      begin
        AlterarRegistro(KeyList[i]);   // Chama o procedimento para alterar as configurações da chave
      end;
    end;
  finally
    Reg.Free;   // Libera o objeto TRegistry
    KeyList.Free;   // Libera a lista de chaves
  end;
end;

procedure TForm3.AlterarRegistro(const AKey: string);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_USERS;   // Define a raiz do registro como HKEY_USERS

    // Abre a chave especificada e cria se não existir
    if Reg.OpenKey(AKey + '\Control Panel\International', True) then
    begin

      Reg.WriteString('sShortDate', 'dd/MM/yyyy');
      Reg.WriteString('LocaleName','pt-BR');
      Reg.WriteString('sLanguage', 'PTB');
      reg.WriteString('sCurrency','R$');

      showmessage(aKey);   // Exibe uma mensagem com o nome da chave

      Reg.CloseKey;    // Fecha a chave do registro
    end;
  finally
    Reg.Free;
  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  AlterarTodasAsPastas;
end;

end.

