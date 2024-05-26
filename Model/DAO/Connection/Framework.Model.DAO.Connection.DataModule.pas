unit Framework.Model.DAO.Connection.DataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Comp.Client,
  FireDAC.Phys.OracleDef,
  FireDAC.Phys.Oracle,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite;

type
  TDataModuleParams<T> = class
    strict private
      FParent : T;
      FDriveID,
      FHost   : String;
      FPort   : Integer;
      FDataBase ,
      FUserName ,
      FPassword : String;
    protected
      constructor Create(aParent : T);
    public
      destructor Destroy; override;
      function &End : T;

      function DriveName(Value : String) : TDataModuleParams<T>; overload;
      function DriveName : String; overload;
//      function Host(Value : String) : TDataModuleParams<T>; overload;
//      function Host : String; overload;
//      function Port(Value : Integer) : TDataModuleParams<T>; overload;
//      function Port : Integer; overload;
      function DataBase(Value : String) : TDataModuleParams<T>; overload;
      function DataBase : String; overload;
//      function UserName(Value : String) : TDataModuleParams<T>; overload;
//      function UserName : String; overload;
//      function Password(Value : String) : TDataModuleParams<T>; overload;
//      function Password : String; overload;
  end;

  TDataModuleConexao = class(TDataModule)
    Conn: TFDConnection;
    Trans: TFDTransaction;
    WaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
  private
    { Private declarations }
    FSettings : Boolean;
    FParams : TDataModuleParams<TDataModuleConexao>;
  public
    { Public declarations }
    function Params : TDataModuleParams<TDataModuleConexao>;
  end;

implementation

uses
  System.IOUtils;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDataModuleParams<T> }

function TDataModuleParams<T>.&End: T;
begin
  Result := FParent;
end;

constructor TDataModuleParams<T>.Create(aParent: T);
begin
  FParent   := aParent;
  FDriveID  := 'SQLite';
  FHost     := 'localhost';
  FPort     := 0;
  FDataBase := '.\db\banco.db';
  FUserName := EmptyStr;
  FPassword := EmptyStr;
end;

function TDataModuleParams<T>.DataBase: String;
begin
  Result := FDataBase;
end;

function TDataModuleParams<T>.DataBase(Value: String): TDataModuleParams<T>;
begin
  Result := Self;
  FDataBase := Value.Trim;
end;

destructor TDataModuleParams<T>.Destroy;
begin
  inherited;
end;

function TDataModuleParams<T>.DriveName: String;
begin
  Result := FDriveID;
end;

function TDataModuleParams<T>.DriveName(Value: String): TDataModuleParams<T>;
begin
  Result := Self;
  FDriveID := Value.Trim;
end;

{ TdmConexao }

procedure TDataModuleConexao.ConnBeforeConnect(Sender: TObject);
begin
  if not FSettings then
  begin
    Conn.Params.BeginUpdate;
    try
      Conn.Params.Clear;
      Conn.Params.AddPair('DriverID', Params.DriveName);
      Conn.Params.AddPair('Database', '.\db\banco.db');
      Conn.Params.AddPair('LockingMode', 'Normal');
    finally
      Conn.Params.EndUpdate;
    end;

    if (Conn.DriverName = 'SQLite') then
    begin
      if not TDirectory.Exists(TPath.Combine(ExtractFilePath(ParamStr(0)), 'db')) then
        TDirectory.CreateDirectory(TPath.Combine(ExtractFilePath(ParamStr(0)), 'db'));
    end;

    FSettings := True;
  end;
end;

procedure TDataModuleConexao.DataModuleCreate(Sender: TObject);
begin
  FParams   := TDataModuleParams<TDataModuleConexao>.Create(Self);
  FSettings := False;
end;

procedure TDataModuleConexao.DataModuleDestroy(Sender: TObject);
begin
  FParams.DisposeOf;
end;

function TDataModuleConexao.Params: TDataModuleParams<TDataModuleConexao>;
begin
  Result := FParams;
end;

end.
