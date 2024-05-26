program Agil.Framework;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  Framework.View.Index in 'View\Framework.View.Index.pas' {ViewIndex},
  Framework.View.Login in 'View\Framework.View.Login.pas' {ViewLogin},
  Framework.View.DataModule.Resource in 'View\DataModule\Framework.View.DataModule.Resource.pas' {DataModuleResource: TDataModule},
  Framework.View.Helpers in 'View\Framework.View.Helpers.pas',
  Framework.View.Assets.Controls in 'View\Assets\Framework.View.Assets.Controls.pas',
  Framework.View.Assets.Exceptions in 'View\Assets\Framework.View.Assets.Exceptions.pas',
  Framework.View.Assets.ComplexType in 'View\Assets\Framework.View.Assets.ComplexType.pas',
  Framework.Model.Entity.Usuario in 'Model\Entity\Framework.Model.Entity.Usuario.pas',
  Framework.Model.DAO in 'Model\DAO\Framework.Model.DAO.pas',
  Framework.Model.DAO.Connection in 'Model\DAO\Connection\Framework.Model.DAO.Connection.pas',
  Framework.Model.DAO.Usuario in 'Model\DAO\Framework.Model.DAO.Usuario.pas',
  Framework.Model.DAO.Interfaces in 'Model\DAO\Framework.Model.DAO.Interfaces.pas',
  Framework.Model.Entity in 'Model\Entity\Framework.Model.Entity.pas',
  Framework.Model.DAO.Connection.DataModule in 'Model\DAO\Connection\Framework.Model.DAO.Connection.DataModule.pas' {DataModuleConexao: TDataModule},
  Framework.Model.DAO.Connection.Interfaces in 'Model\DAO\Connection\Framework.Model.DAO.Connection.Interfaces.pas',
  Framework.Controller in 'Controller\Framework.Controller.pas',
  Framework.Controller.Login in 'Controller\Framework.Controller.Login.pas',
  Framework.Controller.Interfaces in 'Controller\Framework.Controller.Interfaces.pas',
  Framework.View.Assets.Interceptor.Edit in 'View\Assets\Interceptor\Framework.View.Assets.Interceptor.Edit.pas',
  Framework.View.Message in 'View\Framework.View.Message.pas' {ViewMessage},
  Framework.Service.Message in 'Service\Framework.Service.Message.pas';

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TDataModuleResource, DataModuleResource);
  Application.CreateForm(TViewIndex, ViewIndex);
  Application.Run;
end.
