Const ForReading = 1
Const ForWriting = 2
Const OpenAsUnicode=-1

RegPath = WScript.Arguments.Unnamed(0)
WScript.echo "Variable is ", RegPath

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set FileIn = objFSO.OpenTextFile("xpadder.reg", ForReading, , OpenAsUnicode)
strNewText = EncodeSTR( FileIn.ReadAll )

Set FileIn = objFSO.CreateTextFile("xpadder.reg", ForWriting)
FileIn.Write strNewText
FileIn.close
WScript.Quit

Function EncodeSTR( STRz )
EncodeSTR = Replace(STRz, "PATH", RegPath)
End Function