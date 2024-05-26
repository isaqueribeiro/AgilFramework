unit Framework.Model.Entity;

interface

uses
  Framework.Model.Entity.Usuario;

type
  IModelEntity = interface
    function Usuario : TUsuario;
  end;

  TModelEntity = class(TInterfacedObject, IModelEntity)
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function New : IModelEntity;

      function Usuario : TUsuario;
  end;

implementation

{ TModelEntity }

constructor TModelEntity.Create;
begin
  ;
end;

destructor TModelEntity.Destroy;
begin
  inherited;
end;

class function TModelEntity.New: IModelEntity;
begin
  Result := Self.Create;
end;

function TModelEntity.Usuario: TUsuario;
begin
  Result := TUsuario.Create;
end;

end.
