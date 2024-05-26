unit Framework.Model.DAO.Connection.Params;

interface

uses
  System.SysUtils,
  System.IOUtils,
  System.IniFiles;

type
  TDataModuleParams<T> = class
    strict private
      FParent : T;
      FDriveID,
      FHost   : String;
      FPort   : Integer;
      FDataBase ,
      FLockingMode,
      FOpenMode ,
      FUserName ,
      FPassword : String;
      FFileIni : TIniFile;
    protected
      constructor Create(aParent : T);
    public
      destructor Destroy; override;
      function &End : T;

      function DriveName(Value : String) : TDataModuleParams<T>; overload;
      function DriveName : String; overload;
      function Host(Value : String) : TDataModuleParams<T>; overload;
      function Host : String; overload;
      function Port(Value : Integer) : TDataModuleParams<T>; overload;
      function Port : Integer; overload;
      function DataBase(Value : String) : TDataModuleParams<T>; overload;
      function DataBase : String; overload;
      function LockingMode(Value : String) : TDataModuleParams<T>; overload;
      function LockingMode : String; overload;
      function OpenMode(Value : String) : TDataModuleParams<T>; overload;
      function OpenMode : String; overload;
      function UserName(Value : String) : TDataModuleParams<T>; overload;
      function UserName : String; overload;
      function Password(Value : String) : TDataModuleParams<T>; overload;
      function Password : String; overload;

      function Load : TDataModuleParams<T>;
      function Save : TDataModuleParams<T>;
  end;

implementation

{ TDataModuleParams<T> }

function TDataModuleParams<T>.&End: T;
begin
  Result := FParent;
end;

function TDataModuleParams<T>.Host: String;
begin
  Result := FHost;
end;

function TDataModuleParams<T>.Host(Value: String): TDataModuleParams<T>;
begin
  Result := Self;
  FHost  := Value.Trim;
end;

function TDataModuleParams<T>.Load: TDataModuleParams<T>;
begin
  Result := Self;

  FDriveID := FFileIni.ReadString('Conn', 'DriveID', 'SQLite');
  FHost    := FFileIni.ReadString('Conn', 'Host', 'localhost');
  FPort    := FFileIni.ReadInteger('Conn', 'Port', 0);
  FDataBase    := FFileIni.ReadString('Conn', 'DataBase', '.\db\banco.db');
  FLockingMode := FFileIni.ReadString('Conn', 'LockingMode', 'Normal');
  FOpenMode := FFileIni.ReadString('Conn', 'OpenMode', 'CreateUTF8');
  FUserName := FFileIni.ReadString('Conn', 'UserName', EmptyStr);
  FPassword := FFileIni.ReadString('Conn', 'Password', EmptyStr);

  FFileIni.WriteDateTime('Log', 'LoadedAt', Now);
  FFileIni.UpdateFile;
end;

function TDataModuleParams<T>.LockingMode: String;
begin
  Result := FLockingMode;
end;

function TDataModuleParams<T>.OpenMode: String;
begin
  Result := FOpenMode;
end;

function TDataModuleParams<T>.OpenMode(Value: String): TDataModuleParams<T>;
begin
  Result := Self;
  FOpenMode := Value.Trim;
end;

function TDataModuleParams<T>.LockingMode(Value: String): TDataModuleParams<T>;
begin
  Result := Self;
  FLockingMode := Value.Trim;
end;

function TDataModuleParams<T>.Password: String;
begin
  Result := FPassword;
end;

function TDataModuleParams<T>.Password(Value: String): TDataModuleParams<T>;
begin
  Result := Self;
  FPassword := Value.Trim;
end;

function TDataModuleParams<T>.Port: Integer;
begin
  Result := FPort;
end;

function TDataModuleParams<T>.Save: TDataModuleParams<T>;
begin
  Result := Self;

  FFileIni.WriteString('Conn', 'DriveID', FDriveID);
  FFileIni.WriteString('Conn', 'Host', FHost);
  FFileIni.WriteInteger('Conn', 'Port', FPort);
  FFileIni.WriteString('Conn', 'DataBase', FDataBase);
  FFileIni.WriteString('Conn', 'LockingMode', FLockingMode);
  FFileIni.WriteString('Conn', 'OpenMode', FOpenMode);
  FFileIni.WriteString('Conn', 'UserName', FUserName);
  FFileIni.WriteString('Conn', 'Password', FPassword);

  FFileIni.WriteDateTime('Log', 'UpdatedAt', Now);
  FFileIni.UpdateFile;
end;

function TDataModuleParams<T>.UserName: String;
begin
  Result := FUserName;
end;

function TDataModuleParams<T>.UserName(Value: String): TDataModuleParams<T>;
begin
  Result := Self;
  FUserName := Value.Trim;
end;

function TDataModuleParams<T>.Port(Value: Integer): TDataModuleParams<T>;
begin
  Result := Self;
  FPort  := Value;
end;

constructor TDataModuleParams<T>.Create(aParent: T);
begin
  FParent   := aParent;
  FDriveID  := 'SQLite';
  FHost     := 'localhost';
  FPort     := 0;
  FDataBase := '.\db\banco.db';
  FLockingMode  := 'Normal';
  FOpenMode  := 'CreateUTF8';
  FUserName  := EmptyStr;
  FPassword  := EmptyStr;
  FFileIni   := TIniFile.Create(TPath.Combine(ExtractFileDir(ParamStr(0)), 'Conexao.ini'));
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
  FFileIni.UpdateFile;
  FFileIni.Free;
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

end.
