unit Framework.View.DataModule.Resource;

interface

uses
  System.SysUtils,
  System.Classes,

  FMX.Forms,
  FMX.Types,
  FMX.Controls,

  Framework.Service.Message;

type
  TDataModuleResource = class(TDataModule)
    StyleBookDefault: TStyleBook;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FServiceMessage : IServiceMessage;
    procedure TratarErro(Sender: TObject; E: Exception);
  public
    { Public declarations }
    function ServiceMessage : IServiceMessage;
  end;

var
  DataModuleResource: TDataModuleResource;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  Framework.View.Assets.Exceptions;

{$R *.dfm}

{ TDataModuleResource }

procedure TDataModuleResource.DataModuleCreate(Sender: TObject);
begin
  Application.OnException := TratarErro;
end;

function TDataModuleResource.ServiceMessage: IServiceMessage;
begin
  if not Assigned(FServiceMessage) then
    FServiceMessage := TServiceMessage.New;

  Result := FServiceMessage;
end;

procedure TDataModuleResource.TratarErro(Sender: TObject; E: Exception);
var
  aError : HandleErrorException;
begin
  if E is HandleErrorException then
  begin
    case HandleErrorException(E).TypeException of
      TTypeException.teInformative :
        ServiceMessage.Inform(
          Application.MainForm,
          HandleErrorException(E).Title,
          HandleErrorException(E).Informative
        );

      TTypeException.teWarning     :
        ServiceMessage.Warning(
          Application.MainForm,
          HandleErrorException(E).Title,
          HandleErrorException(E).Informative
        );

      TTypeException.teError       :
        ServiceMessage.Error(
          Application.MainForm,
          HandleErrorException(E).Title,
          HandleErrorException(E).Informative
        );
    end;
  end
  else
  begin
    aError := HandleErrorException.Create('Erro não catalogado!', E.Message, TTypeException.teError, True);
    try
      ServiceMessage.Error(Application.MainForm, aError.Title, aError.Informative);
    finally
      aError.DisposeOf;
    end;
  end;
end;

end.
