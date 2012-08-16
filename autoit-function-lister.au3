

#include <Array.au3>
#include <File.au3>

Global $gTitleMsgBox = "AutoIT Function Lister"
Global $gFileToWrite = @ScriptDir & "\functions.txt"

_Main()

Func _Main()

	Local $laFileLines, $laFunctions[1]

	Local $lFileToRead = FileOpenDialog($gTitleMsgBox, @ScriptDir, "AutoIt Scripts (*.au3)", 3)

	_FileReadToArray($lFileToRead,$laFileLines)
	_ArrayDisplay($laFileLines, "$laFileLines")
	_PickFunctionLines($laFileLines, $laFunctions)
	_WriteToTextFile($laFunctions)


EndFunc

Func _PickFunctionLines($laLines, ByRef $laFunctions)

	For $i = 1 To $laLines[0]
		If StringRegExp($laLines[$i], "^Func\s([_\w\d]*\(.*\))") Then
			_ArrayAdd($laFunctions, StringRegExpReplace($laLines[$i], "^Func\s([_\w\d]*\(.*\))", "$1"))
		EndIf
	Next
;~ 	_ArrayDelete($laFunctions, 0)
	$laFunctions[0] = UBound($laFunctions)-1
	_ArrayDisplay($laFunctions, "$laFunctions")

EndFunc

Func _WriteToTextFile($laFunctions)

	_FileWriteFromArray($gFileToWrite, $laFunctions, 1)
	ShellExecute($gFileToWrite)

EndFunc