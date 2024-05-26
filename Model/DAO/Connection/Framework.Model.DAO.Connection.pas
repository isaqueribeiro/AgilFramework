unit Framework.Model.DAO.Connection;

interface

uses
  System.SysUtils,
  SimpleInterface,
  Framework.Model.DAO.Connection.Interfaces,
  Framework.Model.DAO.Connection.DataModule;

type
  TModelDAOConnection = class(TInterfacedObject, IModelDAOConnection)
    private
      FDataModule : TDataModuleConexao;
      FQuery : iSimpleQuery;
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function New : IModelDAOConnection;

      function Query : iSimpleQuery;
  end;

implementation

uses
  SimpleQueryFiredac;

{ TModelDAOConnection }

constructor TModelDAOConnection.Create;
begin
  FDataModule := TDataModuleConexao.Create(nil);
end;

destructor TModelDAOConnection.Destroy;
begin
  FDataModule.Conn.Connected := False;
  FDataModule.Free;
  inherited;
end;

class function TModelDAOConnection.New: IModelDAOConnection;
begin
  Result := Self.Create;
end;

function TModelDAOConnection.Query: iSimpleQuery;
begin
  Result := TSimpleQueryFiredac.Create(FDataModule.Conn);
end;

end.
