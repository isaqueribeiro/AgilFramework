unit Framework.View.Assets.Interceptor.MyLabel;

interface

uses
  System.Classes,
  System.UITypes,
  FMX.Types,
  FMX.StdCtrls,
  FMX.Objects;

type
  TLabel = class(FMX.StdCtrls.TLabel)
    private
      procedure MouseEnter(Sender: TObject);
      procedure MouseLeave(Sender: TObject);
    protected
    public
      constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TLabel }

constructor TLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.OnMouseEnter := MouseEnter;
  Self.OnMouseLeave := MouseLeave;
end;

procedure TLabel.MouseEnter(Sender: TObject);
begin
  Self.TextSettings.Font.Size := Self.TextSettings.Font.Size + 1;
end;

procedure TLabel.MouseLeave(Sender: TObject);
begin
  Self.TextSettings.Font.Size := Self.TextSettings.Font.Size - 1;
end;

end.
