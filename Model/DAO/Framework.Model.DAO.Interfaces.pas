unit Framework.Model.DAO.Interfaces;

interface

uses
  Data.DB,
  SimpleInterface,
  Framework.Model.Entity.Usuario;

type
  IModelDAOUsuario = interface
    ['{9C1C71F5-639D-452B-A2C2-155B01D87FF6}']
    function Entity : TUsuario;
    function DAO : iSimpleDAO<TUsuario>;
  end;

  IModelDAO = interface
    ['{BABCD9D7-5821-4482-8013-BCBDF5D482E1}']
    function Usuario(aDataSource : TDataSource) : IModelDAOUsuario;
  end;

implementation

end.
