unit Framework.Service.Message;

interface

uses
  System.SysUtils,
  System.Classes,
  Framework.View.Assets.ComplexType,
  Framework.View.Message;

type
  IServiceMessage = interface
    ['{1AF67408-E5E8-4BB8-911F-AD7560687475}']
    procedure Inform(AOwner: TComponent; aMessage : String); overload;
    procedure Inform(AOwner: TComponent; aTitle, aMessage : String); overload;
    procedure Warning(AOwner: TComponent; aMessage : String); overload;
    procedure Warning(AOwner: TComponent; aTitle, aMessage : String); overload;
    procedure Error(AOwner: TComponent; aMessage : String); overload;
    procedure Error(AOwner: TComponent; aTitle, aMessage : String); overload;
    procedure Success(AOwner: TComponent; aMessage : String); overload;
    procedure Success(AOwner: TComponent; aTitle, aMessage : String); overload;
  end;

  TServiceMessage = class(TInterfacedObject, IServiceMessage)
    private
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function New : IServiceMessage;

      procedure Inform(AOwner: TComponent; aMessage : String); overload;
      procedure Inform(AOwner: TComponent; aTitle, aMessage : String); overload;
      procedure Warning(AOwner: TComponent; aMessage : String); overload;
      procedure Warning(AOwner: TComponent; aTitle, aMessage : String); overload;
      procedure Error(AOwner: TComponent; aMessage : String); overload;
      procedure Error(AOwner: TComponent; aTitle, aMessage : String); overload;
      procedure Success(AOwner: TComponent; aMessage : String); overload;
      procedure Success(AOwner: TComponent; aTitle, aMessage : String); overload;
  end;

implementation

{ TServiceMessage }

constructor TServiceMessage.Create;
begin
  ;
end;

destructor TServiceMessage.Destroy;
begin
  inherited;
end;

procedure TServiceMessage.Error(AOwner: TComponent; aTitle, aMessage: String);
begin
  TViewMessage
    .Create(AOwner)
    .TypeMessage(TTypeMessage.tmError)
    .Title(aTitle.Trim)
    .Text(aMessage.Trim)
    .Show;
end;

procedure TServiceMessage.Inform(AOwner: TComponent; aTitle, aMessage: String);
begin
  TViewMessage
    .Create(AOwner)
    .TypeMessage(TTypeMessage.tmInform)
    .Title(aTitle.Trim)
    .Text(aMessage.Trim)
    .Show;
end;

procedure TServiceMessage.Inform(AOwner: TComponent; aMessage: String);
begin
  Self.Inform(AOwner, 'Informe!', aMessage);
end;

procedure TServiceMessage.Error(AOwner: TComponent; aMessage: String);
begin
  Self.Error(AOwner, 'Erro!', aMessage);
end;

class function TServiceMessage.New: IServiceMessage;
begin
  Result := Self.Create;
end;

procedure TServiceMessage.Success(AOwner: TComponent; aTitle, aMessage: String);
begin
  TViewMessage
    .Create(AOwner)
    .TypeMessage(TTypeMessage.tmSuccess)
    .Title(aTitle.Trim)
    .Text(aMessage.Trim)
    .Show;
end;

procedure TServiceMessage.Success(AOwner: TComponent; aMessage: String);
begin
  Self.Success(AOwner, 'Sucesso!', aMessage);
end;

procedure TServiceMessage.Warning(AOwner: TComponent; aTitle, aMessage: String);
begin
  TViewMessage
    .Create(AOwner)
    .TypeMessage(TTypeMessage.tmWarnin)
    .Title(aTitle.Trim)
    .Text(aMessage.Trim)
    .Show;
end;

procedure TServiceMessage.Warning(AOwner: TComponent; aMessage: String);
begin
  Self.Warning(AOwner, 'Alerta!', aMessage);
end;

end.
