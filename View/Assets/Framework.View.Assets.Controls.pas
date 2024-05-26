unit Framework.View.Assets.Controls;

interface

uses
  System.SysUtils,
  System.Classes,
  System.UITypes,
  System.Generics.Collections,

  FMX.Types,
  FMX.Controls,
  FMX.Objects,
  FMX.Edit,
  FMX.StdCtrls;

type
  TEvent = procedure (Sender: TObject) of Object;
  TEffectEvent = procedure (Sender: TObject) of Object;

  IViewAssetControl = interface
    ['{513C18D0-CE66-4CB9-9F93-8A63BD666D00}']
    function SetEffectEvent(Sender: TRoundRect) : IViewAssetControl; overload;
    function SetEffectEvent(Sender: TLabel) : IViewAssetControl; overload;
  end;

  TViewAssetControl = class(TInterfacedObject, IViewAssetControl)
    strict private
      const OPACITY_DEFAULT = 0.8;
    private
      procedure OnMouseEnterRoundRect(Sender: TObject);
      procedure OnMouseLeaveRoundRect(Sender: TObject);
      procedure OnClick(Sender: TObject);

      procedure LabelMouseEnter(Sender: TObject);
      procedure LabelMouseLeave(Sender: TObject);
    protected
      FListOnClick : TDictionary<TComponentName, TEvent>;
      constructor Create;
    public
      destructor Destroy; override;
      class function New : IViewAssetControl;
      class procedure DelayedSetFocus(aControl : TControl);

      function SetEffectEvent(Sender: TRoundRect) : IViewAssetControl; overload;
      function SetEffectEvent(Sender: TLabel) : IViewAssetControl; overload;
  end;


implementation

{ TViewAssetControl }

constructor TViewAssetControl.Create;
begin
  FListOnClick := TDictionary<TComponentName, TEvent>.Create;
end;

class procedure TViewAssetControl.DelayedSetFocus(aControl: TControl);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize( nil,
        procedure
        begin
          if aControl.Visible and aControl.Enabled then
            aControl.SetFocus;
        end
      );
    end
  ).Start;
end;

destructor TViewAssetControl.Destroy;
begin
  FListOnClick.DisposeOf;
  inherited;
end;

procedure TViewAssetControl.LabelMouseEnter(Sender: TObject);
begin
  if Sender is TLabel then
  begin
    TLabel(Sender).Opacity := 1;
    TLabel(Sender).TextSettings.Font.Size := TLabel(Sender).TextSettings.Font.Size + 1;
  end;
end;

procedure TViewAssetControl.LabelMouseLeave(Sender: TObject);
begin
  if Sender is TLabel then
  begin
    TLabel(Sender).Opacity := 0.8;
    TLabel(Sender).TextSettings.Font.Size := TLabel(Sender).TextSettings.Font.Size - 1;
  end;
end;

class function TViewAssetControl.New: IViewAssetControl;
begin
  Result := Self.Create;
end;

procedure TViewAssetControl.OnClick(Sender: TObject);
var
  aName  : TComponentName;
  aClick : TEvent;
begin
  // Executar evento de animação
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize( nil,
        procedure
        begin
          TControl(Sender).AnimateFloat('Opacity', 0.5, 0.2, TAnimationType.In, TInterpolationType.Linear);
          TControl(Sender).AnimateFloat('Opacity', OPACITY_DEFAULT, 0.2, TAnimationType.In, TInterpolationType.Linear);
        end
      );
    end
  ).Start;

  // Executar evento implementado na View
  aName := TControl(Sender).Name;
  if FListOnClick.TryGetValue(aName, aClick) then
    aClick(Sender);
end;

procedure TViewAssetControl.OnMouseEnterRoundRect(Sender: TObject);
begin
  TRoundRect(Sender).Opacity := 1;
end;

procedure TViewAssetControl.OnMouseLeaveRoundRect(Sender: TObject);
begin
  TRoundRect(Sender).Opacity := OPACITY_DEFAULT;
end;

function TViewAssetControl.SetEffectEvent(Sender: TLabel): IViewAssetControl;
begin
  Result := Self;

  Sender.Opacity := OPACITY_DEFAULT;
  Sender.Cursor  := crHandPoint;
  Sender.OnMouseEnter := LabelMouseEnter;
  Sender.OnMouseLeave := LabelMouseLeave;
end;

function TViewAssetControl.SetEffectEvent(Sender: TRoundRect) : IViewAssetControl;
begin
  Result := Self;

  Sender.Opacity := OPACITY_DEFAULT;
  Sender.Cursor  := crHandPoint;
  Sender.OnMouseEnter := OnMouseEnterRoundRect;
  Sender.OnMouseLeave := OnMouseLeaveRoundRect;

  if Assigned(Sender.OnClick) and (not FListOnClick.ContainsKey(Sender.Name)) then
    FListOnClick.AddOrSetValue(Sender.Name, Sender.OnClick);

  Sender.OnClick := OnClick;
end;

end.
