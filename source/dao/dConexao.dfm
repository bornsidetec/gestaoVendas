object dmConexao: TdmConexao
  OnCreate = DataModuleCreate
  Height = 172
  Width = 298
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
    Left = 168
    Top = 32
  end
end
