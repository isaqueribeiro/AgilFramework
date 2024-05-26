unit Framework.View.Index;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts;

type
  TViewIndex = class(TForm)
    Layout: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewIndex: TViewIndex;

// https://docwiki.embarcadero.com/RADStudio/Alexandria/en/FireMonkey_Platform_Prerequisites

implementation

uses
  Router4D,
  Framework.View.Helpers,
  Framework.View.Login;

{$R *.fmx}

procedure TViewIndex.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  AllowTabStopOnlyEdit;
  TRouter4D.Render<TViewLogin>.SetElement(Layout, Layout);
  Layout.Align := TAlignLayout.Center;
end;

procedure TViewIndex.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkReturn) then
  begin
    Key := vkTab;
    KeyDown(Key, KeyChar, Shift);
  end;
end;

end.
