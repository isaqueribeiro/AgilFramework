unit Framework.Model.DAO.Connection.Interfaces;

interface

uses
  SimpleInterface;

type
  IModelDAOConnection = interface
    ['{79B30AAF-C31F-4440-8F19-F0EF2FEAFE65}']
    function Query : iSimpleQuery;
  end;

implementation

end.
