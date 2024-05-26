unit Framework.View.Helpers;

interface

uses
  FMX.Forms,
  FMX.Types,
  FMX.Controls,
  FMX.Layouts,
  FMX.Edit,
  FMX.TabControl;

type
  TViemForm = class helper for TForm
    private
      procedure AllowTabStopOnly(aObject : TFmxObject);
    public
      procedure AllowTabStopOnlyEdit;
  end;

implementation

{ TViemForm }

procedure TViemForm.AllowTabStopOnly(aObject: TFmxObject);
var
  I : Integer;
begin
  for I := 0 to Pred(aObject.ChildrenCount) do
  begin
    if (not (aObject.Children.Items[I] is TEdit)) and (aObject.Children.Items[I] is TControl) then
      TControl(aObject.Children.Items[I]).TabStop := False;

    if (aObject.Children.Items[I] is TLayout) or (aObject.Children.Items[I] is TTabControl) or (aObject.Children.Items[I] is TTabItem) then
      AllowTabStopOnly(aObject.Children.Items[I]);
  end;
end;

procedure TViemForm.AllowTabStopOnlyEdit;
var
  I : Integer;
begin
  for I := 0 to Pred(TFmxObject(Self).ChildrenCount) do
    AllowTabStopOnly(TFmxObject(Self).Children.Items[I]);
end;

end.
