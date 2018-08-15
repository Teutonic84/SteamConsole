On Error Resume Next


Const strComputer = "."
Const HKLM        = &H80000002
Const strKeyPath  = "SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome"


Dim oReg, arrSubKeys, strProduct, strDisplayName, strVersion, strInstallLocation


Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _ 
     strComputer & "\root\default:StdRegProv")


' Enumerate the subkeys of the Uninstall key
oReg.EnumKey HKLM, strKeyPath, arrSubKeys
For Each strProduct In arrSubKeys
  ' Check to see if Steam subkey exists
  oReg.GetStringValue HKLM, strKeyPath & "\" & strProduct
  ' Process only products whose name contain 'Google Chrome'
  If InStr(1, arrSubKeys, "Google Chrome", vbTextCompare) > 0 Then
    ' Get the product's install path
    oReg.GetStringValue HKLM, strKeyPath & "\" & strProduct, "InstallLocation", strInstallLocation
    WScript.Echo strInstallLocation
  End If
Next