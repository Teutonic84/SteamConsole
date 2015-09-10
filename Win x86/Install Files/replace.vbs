Const ForReading = 1
Const ForWriting = 2

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set FileIn = objFSO.OpenTextFile("path.txt", ForReading)
strNewText = EncodeSTR( FileIn.ReadAll )

Set FileIn = objFSO.CreateTextFile("path.txt", ForWriting)
FileIn.Write strNewText
FileIn.close
WScript.Quit

Function EncodeSTR( STRz )
EncodeSTR = Replace(STRz, "\", "\\")
End Function