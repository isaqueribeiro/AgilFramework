unit Framework.Controller.Interfaces;

interface

type
  IControllerLogin = interface
    ['{9EFCE354-3B9E-49CD-9671-8AE945F63EFE}']
    function UserName(Value : String) : IControllerLogin;
    function Password(Value : String) : IControllerLogin;
    //function Callback(Value : TEvent) : IControllerLogin;
    function Execute : IControllerLogin;
  end;

  IController = interface
    ['{168AE83B-2687-4D8B-9C0F-E72EACAD661E}']
    function Login : IControllerLogin;
  end;

implementation

end.
