object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object Conexao: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Port=3306'
      'Database=vendas'
      'Password=!@345678'
      'Server=localhost'
      'User_Name=root')
    LoginPrompt = False
    Left = 40
    Top = 32
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'libmysql.dll'
    Left = 112
    Top = 32
  end
end
