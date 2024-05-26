unit Framework.View.Message;

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
  FMX.Objects,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.StdCtrls,

  Framework.View.Assets.ComplexType;

type
  TTypeMessage = (tmInform, tmWarnin, tmError, tmRequest, tmSuccess);
  TViewMessage = class(TForm)
    Layout: TLayout;
    Rectangle: TRectangle;
    LayoutMessage: TLayout;
    RectangleBackground: TRectangle;
    LayoutHeader: TLayout;
    RectangleHeader: TRectangle;
    LayoutContent: TLayout;
    lblTitleMessage: TLabel;
    LayoutBody: TLayout;
    LayoutFooter: TLayout;
    imgMessage: TImage;
    lblTextMessage: TLabel;
    lytConfirmar: TLayout;
    recConfirmar: TRectangle;
    lblConfirmar: TLabel;
    btnConfirmar: TSpeedButton;
    lytCancelar: TLayout;
    recCancelar: TRectangle;
    lblCancelar: TLabel;
    btnCancelar: TSpeedButton;
    imgInform: TImage;
    imgWarning: TImage;
    imgError: TImage;
    imgRequest: TImage;
    imgSuccess: TImage;
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnConfirmarMouseEnter(Sender: TObject);
    procedure btnConfirmarMouseLeave(Sender: TObject);
    procedure btnCancelarMouseEnter(Sender: TObject);
    procedure btnCancelarMouseLeave(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
    FCallback : TEventMessage;
    FTypeMessage : TTypeMessage;
    procedure OcultarImagens;
  protected
    procedure DoShow; override;
  public
    { Public declarations }
    function TypeMessage(Value : TTypeMessage) : TViewMessage;
    function Title(Value : String) : TViewMessage;
    function Text(Value : String) : TViewMessage;
    function Callback(Value : TEventMessage) : TViewMessage;
    function Render : TFmxObject;
  end;

implementation

{$R *.fmx}

{ TViewMessage }

procedure TViewMessage.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TViewMessage.btnCancelarMouseEnter(Sender: TObject);
begin
  lblCancelar.TextSettings.Font.Style := [TFontStyle.fsBold];
end;

procedure TViewMessage.btnCancelarMouseLeave(Sender: TObject);
begin
  lblCancelar.TextSettings.Font.Style := [];
end;

procedure TViewMessage.btnConfirmarClick(Sender: TObject);
begin
  Self.Close;
  if Assigned(FCallback) then
    FCallback(Sender);
end;

procedure TViewMessage.btnConfirmarMouseEnter(Sender: TObject);
begin
  lblConfirmar.TextSettings.Font.Style := [TFontStyle.fsBold];
end;

procedure TViewMessage.btnConfirmarMouseLeave(Sender: TObject);
begin
  lblConfirmar.TextSettings.Font.Style := [];
end;

function TViewMessage.Callback(Value: TEventMessage): TViewMessage;
begin
  Result := Self;
  FCallback := Value;
end;

procedure TViewMessage.DoShow;
begin
  inherited;
  Self.FullScreen := False;

  if Assigned(Application.MainForm) then
  begin
    Self.Top    := Application.MainForm.Top;
    Self.Left   := Application.MainForm.Left;
    Self.Height := Application.MainForm.Height;
    Self.Width  := Application.MainForm.Width;
  end
  else
    Self.FullScreen := True;
end;

procedure TViewMessage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(Layout.Parent) and (Layout.Parent <> Self) then
    TFmxObject(Layout.Parent).RemoveObject(Layout);
end;

procedure TViewMessage.FormCreate(Sender: TObject);
begin
  OcultarImagens;
end;

procedure TViewMessage.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkEscape) then
    Self.Close;
end;

procedure TViewMessage.OcultarImagens;
begin
  imgInform.Visible  := False;
  imgWarning.Visible := False;
  imgError.Visible   := False;
  imgRequest.Visible := False;
  imgSuccess.Visible := False;
end;

function TViewMessage.Render: TFmxObject;
begin
  OcultarImagens;
  Result := Layout;
end;

function TViewMessage.Text(Value: String): TViewMessage;
begin
  Result := Self;
  lblTextMessage.Text := Value.Trim;
end;

function TViewMessage.Title(Value: String): TViewMessage;
begin
  Result := Self;
  lblTitleMessage.Text := Value.Trim;
end;

function TViewMessage.TypeMessage(Value: TTypeMessage): TViewMessage;
begin
  Result := Self;
  FTypeMessage := Value;

  lytConfirmar.Visible := False;
  lytCancelar.Visible  := True;
  lytCancelar.Align    := TAlignLayout.Center;

  case Value of
    TTypeMessage.tmInform :
      begin
        imgMessage.Bitmap := imgInform.Bitmap;
        RectangleHeader.Fill.Color := $FF2AB1AB;
      end;

    TTypeMessage.tmWarnin :
      begin
        imgMessage.Bitmap := imgWarning.Bitmap;
        RectangleHeader.Fill.Color := $FFFAAB48;
      end;

    TTypeMessage.tmError  :
      begin
        imgMessage.Bitmap := imgError.Bitmap;
        RectangleHeader.Fill.Color := $FFF04760;
      end;

    TTypeMessage.tmRequest:
      begin
        imgMessage.Bitmap := imgRequest.Bitmap;
        RectangleHeader.Fill.Color := $FFF9973E;
      end;

    TTypeMessage.tmSuccess:
      begin
        imgMessage.Bitmap := imgSuccess.Bitmap;
        RectangleHeader.Fill.Color := $FF2AD352;
      end;
  end;
end;

end.
