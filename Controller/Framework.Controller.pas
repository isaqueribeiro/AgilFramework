unit Framework.Controller;

interface

uses
  System.SysUtils,
  Framework.Controller.Interfaces;

type
  TController = class(TInterfacedObject, IController)
    private
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function New : IController;

      function Login : IControllerLogin;
  end;

implementation

{ TController }

uses
  Framework.Controller.Login;

constructor TController.Create;
begin
  ;
end;

destructor TController.Destroy;
begin
  inherited;
end;

function TController.Login: IControllerLogin;
begin
  Result := TControllerLogin.New;
end;

class function TController.New: IController;
begin
  Result := Self.Create;
end;

end.
