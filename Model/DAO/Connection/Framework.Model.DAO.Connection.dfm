object DataModuleConexao: TDataModuleConexao
  Height = 301
  Width = 413
  PixelsPerInch = 96
  object Conn: TFDConnection
    Params.Strings = (
      'Database=.\db\banco.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime, fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayDateTime = 'dd/mm/yyyy hh:mi:ss'
    FormatOptions.FmtDisplayDate = 'dd/mm/yyyy'
    FormatOptions.FmtDisplayTime = 'hh:mi'
    LoginPrompt = False
    Transaction = Trans
    UpdateTransaction = Trans
    Left = 104
    Top = 40
  end
  object Trans: TFDTransaction
    Connection = Conn
    Left = 104
    Top = 96
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 104
    Top = 152
  end
end
