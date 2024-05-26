unit Framework.Model.DAO;

interface

uses
  System.SysUtils,
  Data.DB,
  Framework.Model.DAO.Interfaces;

type
  TModelDAO = class(TInterfacedObject, IModelDAO)
    private
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function New : IModelDAO;

      function Usuario(aDataSource : TDataSource) : IModelDAOUsuario;
  end;

implementation

{ TModelDAO }

uses Framework.Model.DAO.Usuario;

constructor TModelDAO.Create;
begin
  ;
end;

destructor TModelDAO.Destroy;
begin
  inherited;
end;

class function TModelDAO.New: IModelDAO;
begin
  Result := Self.Create;
end;

function TModelDAO.Usuario(aDataSource : TDataSource) : IModelDAOUsuario;
begin
  Result := TModelDAOUsuario.New(aDataSource);
end;

end.
