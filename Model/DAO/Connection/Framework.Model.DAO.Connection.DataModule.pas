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
  FireDAC.Phys.SQLite,

  Framework.Model.DAO.Connection.Params;

type
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

{ TdmConexao }

procedure TDataModuleConexao.ConnBeforeConnect(Sender: TObject);
begin
  if not FSettings then
  begin
    Conn.Params.BeginUpdate;
    try
      Params.Load;

      Conn.Params.Clear;
      Conn.Params.AddPair('DriverID', Params.DriveName);
      Conn.Params.AddPair('Database', Params.DataBase);
    finally
      Conn.Params.EndUpdate;
    end;

    if (Conn.DriverName = 'SQLite') then
    begin
      Conn.Params.AddPair('OpenMode', Params.OpenMode);
      Conn.Params.AddPair('LockingMode', Params.LockingMode);
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
  FParams.Free;
end;

function TDataModuleConexao.Params: TDataModuleParams<TDataModuleConexao>;
begin
  Result := FParams;
end;

end.
