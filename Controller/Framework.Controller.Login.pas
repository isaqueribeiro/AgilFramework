unit Framework.Controller.Login;

interface

uses
  System.SysUtils,
  Data.DB,
  Framework.Controller.Interfaces,
  Framework.Model.DAO.Interfaces,
  Framework.Model.Entity.Usuario,
  Framework.Model.DAO.Usuario;

type
  TControllerLogin = class(TInterfacedObject, IControllerLogin)
    private
      FEntity : TUsuario;
      FModel  : IModelDAOUsuario;
      FDataSource : TDataSource;
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function New : IControllerLogin;

      function UserName(Value : String) : IControllerLogin;
      function Password(Value : String) : IControllerLogin;
      function Execute : IControllerLogin;
  end;

implementation

uses
  Framework.View.Assets.Exceptions;

{ TControllerLogin }

constructor TControllerLogin.Create;
begin
  FDataSource := TDataSource.Create(nil);
  FEntity := TUsuario.Create;
  FModel  := TModelDAOUsuario.New(FDataSource);
end;

destructor TControllerLogin.Destroy;
begin
  FDataSource.Free;
  FEntity.Free;
  inherited;
end;

function TControllerLogin.Execute: IControllerLogin;
begin
  Result := Self;
  FModel.DAO.Find('cd_usuario', FEntity.UserName);

  if FModel.Entity.UserName.IsEmpty then
    raise HandleErrorException.Create('Atenção', 'Usuário e senha inválidos!', TTypeException.teWarning);
end;

class function TControllerLogin.New: IControllerLogin;
begin
  Result := Self.Create;
end;

function TControllerLogin.Password(Value: String): IControllerLogin;
begin
  Result := Self;

  if Value.Trim.IsEmpty then
    raise HandleErrorException.Create('Atenção', 'Informe sua senha!', TTypeException.teWarning);

  FEntity.UserName := Value.Trim;
end;

function TControllerLogin.UserName(Value: String): IControllerLogin;
begin
  Result := Self;

  if Value.Trim.IsEmpty then
    raise HandleErrorException.Create('Atenção', 'Informe seu e-mail de acesso!', TTypeException.teWarning);

  FEntity.Password := Value.Trim;
end;

end.
