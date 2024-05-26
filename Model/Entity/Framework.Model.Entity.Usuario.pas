unit Framework.Model.Entity.Usuario;

interface

uses
  System.SysUtils,
  System.Variants,
  SimpleAttributes;

type
  [Tabela('SYS_USUARIO usr')]
  TUsuario = class
  private
    FLastName: String;
    FPassword: String;
    FFirstName: String;
    FUserName: String;
    FTokenId: String;
    FCreatedAt: TDateTime;
    FUpdateAt: TDateTime;
    procedure SetFirstName(const Value: String);
    procedure SetLastName(const Value: String);
    procedure SetPassword(const Value: String);
    procedure SetUserName(const Value: String);
    procedure SetTokenId(const Value: String);
    procedure SetCreatedAt(const Value: TDateTime);
    procedure SetUpdateAt(const Value: TDateTime);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Limpar;
  published
    [Campo('usr.cd_usuario'), Pk, NotNull, Display('E-mail')]
    property UserName : String read FUserName write SetUserName;
    [Campo('usr.ds_senha'), NotNull, Display('Senha')]
    property Password : String read FPassword write SetPassword;
    [Campo('usr.ds_primeironome'), Display('Nome')]
    property FirstName : String read FFirstName write SetFirstName;
    [Campo('usr.ds_ultimonome'), Display('Sobrenome')]
    property LastName : String read FLastName write SetLastName;
    [Campo('usr.id_token')]
    property TokenId : String read FTokenId write SetTokenId;
    [Campo('usr.created_at'), Format('dd/mm/yyyy'), Display('Criado em')]
    property CreatedAt : TDateTime read FCreatedAt write SetCreatedAt;
    [Campo('usr.upated_at'), Format('dd/mm/yyyy'), Display('Atualizado em')]
    property UpdateAt : TDateTime read FUpdateAt write SetUpdateAt;

    [Ignore, Display('Usu�rio')]
    function Name : String;
  end;

implementation

{ TUsuario }

constructor TUsuario.Create;
begin
  Self.Limpar;
end;

destructor TUsuario.Destroy;
begin
  inherited;
end;

procedure TUsuario.Limpar;
begin
  FUserName  := EmptyStr;
  FPassword  := EmptyStr;
  FFirstName := EmptyStr;
  FLastName  := EmptyStr;
  FTokenId   := EmptyStr;
  FCreatedAt := Now;
end;

function TUsuario.Name: String;
var
  aFirstName,
  aLastName : String;
begin
  aFirstName := Copy(FFirstName.ToUpper, 1, 1) + Copy(FFirstName.ToLower, 2, FFirstName.Length);
  aLastName  := Copy(FLastName.ToUpper, 1, 1)  + Copy(FLastName.ToLower, 2, FLastName.Length);

  Result := Trim(aFirstName + ' ' + aLastName);
end;

procedure TUsuario.SetCreatedAt(const Value: TDateTime);
begin
  FCreatedAt := Value;
end;

procedure TUsuario.SetFirstName(const Value: String);
begin
  FFirstName := Value.Trim;
end;

procedure TUsuario.SetLastName(const Value: String);
begin
  FLastName := Value.Trim;
end;

procedure TUsuario.SetPassword(const Value: String);
begin
  FPassword := Value.Trim;
end;

procedure TUsuario.SetTokenId(const Value: String);
begin
  FTokenId := Value.Trim;
end;

procedure TUsuario.SetUpdateAt(const Value: TDateTime);
begin
  FUpdateAt := Value;
end;

procedure TUsuario.SetUserName(const Value: String);
begin
  FUserName := Value.Trim;
end;

end.