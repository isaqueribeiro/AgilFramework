unit Framework.View.DataModule.Resources;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  TDataModuleResource = class(TDataModule)
    StyleBookDefault: TStyleBook;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleResource: TDataModuleResource;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
