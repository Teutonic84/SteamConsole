On Error Resume Next


Const strComputer = "."
Const HKLM        = &H80000002
Const strKeyPath  = "SOFTWARE\Wow6432Node\Valve"


Dim oReg, arrSubKeys, strProduct, strDisplayName, strVersion, strInstallPath


Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _ 
     strComputer & "\root\default:StdRegProv")


' Enumerate the subkeys of the Uninstall key
oReg.EnumKey HKLM, strKeyPath, arrSubKeys
For Each strProduct In arrSubKeys
  ' Check to see if Steam subkey exists
  oReg.GetStringValue HKLM, strKeyPath & "\" & strProduct
  ' Process only products whose name contain 'Steam'
  If InStr(1, arrSubKeys, "Steam", vbTextCompare) > 0 Then
    ' Get the product's install path
    oReg.GetStringValue HKLM, strKeyPath & "\" & strProduct, "InstallPath", strInstallPath
    WScript.Echo strInstallPath
  End If
Next