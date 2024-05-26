unit Framework.View.Login;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Threading,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.TabControl,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.Ani,
  FMX.Effects,
  FMX.Filter.Effects,

  Router4D.Interfaces,
  Framework.View.Assets.Interceptor.Edit,
  Framework.View.Assets.Controls,
  Framework.Controller.Interfaces;

type
  TViewLogin = class(TForm, iRouter4DComponent)
    Layout: TLayout;
    LayoutOnBoard: TLayout;
    LayoutUser: TLayout;
    TabControlLogin: TTabControl;
    tbiLogin: TTabItem;
    tbiRegister: TTabItem;
    tbiRemember: TTabItem;
    RectangleBackground: TRectangle;
    lytLoginContent: TLayout;
    lytLoginHeader: TLayout;
    lytLoginBody: TLayout;
    lytLoginFooter: TLayout;
    lblLoginHeader: TLabel;
    edtLoginUserName: TEdit;
    linLoginUserName: TLine;
    lblLoginUserName: TLabel;
    imgLoginUserName: TImage;
    edtLoginPassword: TEdit;
    linLoginPassword: TLine;
    lblLoginPassword: TLabel;
    imgLoginPassword: TImage;
    fillColorLogin: TFillRGBEffect;
    lytLoginFields: TLayout;
    lytLoginButton: TLayout;
    recLoginButton: TRoundRect;
    lblLoginButton: TLabel;
    lblEsqueciSenha: TLabel;
    lytRememberContent: TLayout;
    lytRememberHeader: TLayout;
    lblRememberHeader: TLabel;
    lytRememberBody: TLayout;
    lytRememberFields: TLayout;
    fillRememberFields: TFillRGBEffect;
    edtRememberEmail: TEdit;
    linRememberEmail: TLine;
    lblRememberEmail: TLabel;
    imgRememberEmail: TImage;
    lytRememberFooter: TLayout;
    lytResetButton: TLayout;
    recResetButton: TRoundRect;
    lblResetButton: TLabel;
    Image1: TImage;
    lytRegisterContenet: TLayout;
    lytRegisterHeader: TLayout;
    lblRegisterHeader: TLabel;
    lytRegisterBody: TLayout;
    lytRegisterFields: TLayout;
    fillRegisterFields: TFillRGBEffect;
    edtRegisterPassword: TEdit;
    linRegisterPassword: TLine;
    lblRegisterPassword: TLabel;
    imgRegisterPassword: TImage;
    edtRegisterEmail: TEdit;
    linRegisterEmail: TLine;
    lblRegisterEmail: TLabel;
    imgRegisterEmail: TImage;
    lytRegisterFooter: TLayout;
    lytRegisterButton: TLayout;
    recRegisterButton: TRoundRect;
    lblRegisterButton: TLabel;
    lblRegistrarAcesso: TLabel;
    Layout1: TLayout;
    Line3: TLine;
    lytEfetuarLogin: TLayout;
    lblEfetuarLogin: TLabel;
    edtRegisterName: TEdit;
    linRegisterName: TLine;
    lblRegisterName: TLabel;
    imgRegisterName: TImage;
    procedure FormCreate(Sender: TObject);
    procedure recLoginButtonClick(Sender: TObject);
    procedure lblEsqueciSenhaClick(Sender: TObject);
    procedure lblEfetuarLoginClick(Sender: TObject);
    procedure lblRegistrarAcessoClick(Sender: TObject);
    procedure TabControlLoginChange(Sender: TObject);
  private
    { Private declarations }
    FAssetControl : IViewAssetControl;
    FUser : IControllerLogin;
  public
    { Public declarations }
    function Render : TFMXObject;
    procedure UnRender;
  end;

implementation

{$R *.fmx}

uses
  Router4D,
  Framework.View.Helpers,
  Framework.View.DataModule.Resource,
  Framework.Controller;

{ TViewLogin }

procedure TViewLogin.FormCreate(Sender: TObject);
begin
  AllowTabStopOnlyEdit;
  FAssetControl := TViewAssetControl.New;
  FAssetControl
    .SetEffectEvent(recLoginButton)
    .SetEffectEvent(recRegisterButton)
    .SetEffectEvent(recResetButton)
    .SetEffectEvent(lblEfetuarLogin)
    .SetEffectEvent(lblRegistrarAcesso)
    .SetEffectEvent(lblEsqueciSenha);

  FUser := TController.New.Login;
end;

procedure TViewLogin.lblEfetuarLoginClick(Sender: TObject);
begin
  TabControlLogin.GotoVisibleTab(tbiLogin.Index);
  TViewAssetControl.DelayedSetFocus(edtLoginUserName);
end;

procedure TViewLogin.lblEsqueciSenhaClick(Sender: TObject);
begin
  TabControlLogin.GotoVisibleTab(tbiRemember.Index);
  TViewAssetControl.DelayedSetFocus(edtRememberEmail);
end;

procedure TViewLogin.lblRegistrarAcessoClick(Sender: TObject);
begin
  TabControlLogin.GotoVisibleTab(tbiRegister.Index);
  TViewAssetControl.DelayedSetFocus(edtRegisterName);
end;

procedure TViewLogin.recLoginButtonClick(Sender: TObject);
begin
  FUser
    .UserName(edtLoginUserName.Text)
    .Password(edtLoginPassword.Text)
    .Execute;
end;

function TViewLogin.Render: TFMXObject;
begin
  Result := Layout;
  TabControlLogin.ActiveTab := tbiLogin;
  TViewAssetControl.DelayedSetFocus(edtLoginUserName);
end;

procedure TViewLogin.TabControlLoginChange(Sender: TObject);
begin
  if (TabControlLogin.ActiveTab = tbiRegister) then
    lytEfetuarLogin.Parent := lytRegisterFooter
  else
  if (TabControlLogin.ActiveTab = tbiRemember) then
    lytEfetuarLogin.Parent := lytRememberFooter;
end;

procedure TViewLogin.UnRender;
begin
  ;
end;

initialization
  TRouter4D.Switch.Router('ViewLogin', TViewLogin);

end.
