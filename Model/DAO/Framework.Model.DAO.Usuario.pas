unit Framework.Model.DAO.Usuario;

interface

uses
  Data.DB,
  SimpleInterface,
  Framework.Model.DAO.Interfaces,
  Framework.Model.DAO.Connection.Interfaces,
  Framework.Model.Entity.Usuario;

type
  TModelDAOUsuario = class(TInterfacedObject, IModelDAOUsuario)
    private
      FEntity : TUsuario;
      FConn : IModelDAOConnection;
      FDAO  : iSimpleDAO<TUsuario>;
    protected
      constructor Create(aDataSource : TDataSource);
    public
      destructor Destroy; override;
      class function New(aDataSource : TDataSource) : IModelDAOUsuario;

      function Entity : TUsuario;
      function DAO : iSimpleDAO<TUsuario>;
  end;

implementation

uses
  SimpleDAO,
  Framework.Model.Entity,
  Framework.Model.DAO.Connection;

{ TModelDAOUsuario }

constructor TModelDAOUsuario.Create(aDataSource : TDataSource);
begin
  FEntity := TModelEntity.New.Usuario;
  FConn := TModelDAOConnection.New;
  FDAO  := TSimpleDAO<TUsuario>.New(FConn.Query).DataSource(aDataSource);
end;

function TModelDAOUsuario.DAO: iSimpleDAO<TUsuario>;
begin
  Result := FDAO;
end;

destructor TModelDAOUsuario.Destroy;
begin
  FEntity.DisposeOf;
  inherited;
end;

function TModelDAOUsuario.Entity: TUsuario;
begin
  Result := FEntity;
end;

class function TModelDAOUsuario.New(aDataSource : TDataSource) : IModelDAOUsuario;
begin
  Result := Self.Create(aDataSource);
end;

end.
