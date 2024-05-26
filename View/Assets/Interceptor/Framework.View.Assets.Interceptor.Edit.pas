unit Framework.View.Assets.Interceptor.Edit;

interface

uses
  System.Classes,
  System.UITypes,
  FMX.Edit,
  FMX.Types,
  FMX.StdCtrls,
  FMX.Objects;

type
  TEdit = class(FMX.Edit.TEdit)
    private
      procedure DoEnter; override;
      procedure DoExit; override;
      procedure Loaded; override;
    protected

    public
      constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TEdit }

constructor TEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TEdit.DoEnter;
var
  I : Integer;
begin
  inherited;
  Self.Font.Style := [TFontStyle.fsBold];
  Self.TextSettings.Font.Style := [TFontStyle.fsBold];
  for I := 0 to Pred(TFmxObject(Self).ChildrenCount) do
  begin
    if (TFmxObject(Self).Children.Items[I] is TLabel) then
      TLabel(TFmxObject(Self).Children.Items[I]).TextSettings.Font.Style := [TFontStyle.fsBold];

    if (TFmxObject(Self).Children.Items[I] is TLine) then
    begin
      TLine(TFmxObject(Self).Children.Items[I]).Stroke.Thickness := 2;
      TLine(TFmxObject(Self).Children.Items[I]).Opacity := 1;
    end;
  end;
end;

procedure TEdit.DoExit;
var
  I : Integer;
begin
  inherited;
  Self.Font.Style := [];
  Self.TextSettings.Font.Style := [];
  for I := 0 to Pred(TFmxObject(Self).ChildrenCount) do
  begin
    if (TFmxObject(Self).Children.Items[I] is TLabel) then
      TLabel(TFmxObject(Self).Children.Items[I]).TextSettings.Font.Style := [];

    if (TFmxObject(Self).Children.Items[I] is TLine) then
    begin
      TLine(TFmxObject(Self).Children.Items[I]).Stroke.Thickness := 1;
      TLine(TFmxObject(Self).Children.Items[I]).Opacity := 0.4;
    end;
  end;
end;

procedure TEdit.Loaded;
begin
  inherited;
  ;
end;

end.
