unit Framework.View.Assets.Exceptions;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils;

type
  TTypeException = (teInformative, teWarning, teError);
  HandleErrorException = class(Exception)
    private
      FTitle ,
      FInformative : String;
      FTypeException : TTypeException;
    public
      constructor Create(aTitle, aInformative : String;
        const aType : TTypeException = TTypeException.teError;
        const aCreateLog : Boolean = False);

      property Title : String read FTitle;
      property Informative : String read FInformative;
      property TypeException : TTypeException read FTypeException;
  end;

implementation

{ HandleErrorException }

constructor HandleErrorException.Create(aTitle, aInformative : String;
  const aType : TTypeException = TTypeException.teError;
  const aCreateLog : Boolean = False);
var
  aLog : TSTringList;
  aFileName : TFileName;
begin
  aLog := TSTringList.Create;
  try
    Message := aInformative;

    FTitle := aTitle.Trim;
    FInformative := aInformative;
    FTypeException := aType;

    if aCreateLog then
    begin
      aLog.BeginUpdate;
      aLog.Clear;
      aLog.Add('Title   : ' + aTitle);
      aLog.Add('Message : ' + aInformative);

      case FTypeException of
        TTypeException.teInformative: aLog.Add('Type    : Informative');
        TTypeException.teWarning    : aLog.Add('Type    : Warning');
        TTypeException.teError      : aLog.Add('Type    : Error');
      end;

      aLog.EndUpdate;

      if (aType = TTypeException.teError) then
      begin
        aFileName := TPath.Combine(ExtractFilePath(ParamStr(0)), '.logs');
        if not DirectoryExists(aFileName) then
          ForceDirectories(aFileName);

        aFileName := TPath.Combine(aFileName,
          'logger-' + FormatDateTime('yyyymmdd', Date) + '-' + FormatDateTime('hh-nn-ss', Time) + '.log'
        );
        aLog.SaveToFile(aFileName, TEncoding.UTF8);
      end;
    end;
  finally
    aLog.Free;
  end;
end;

end.
