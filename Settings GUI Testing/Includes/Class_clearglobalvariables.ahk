CleanGlobalVars() {
	global
	local out, p, v
	ListVars
	ControlGetText, out, Edit1, ahk_class AutoHotkey
	WinHide, ahk_class AutoHotkey
	Loop, parse, out, `n, `r
		if	(!p :=	InStr(A_LoopField,"[")) || RegExMatch(A_LoopField,"^\d+\[")
			continue
		else	v :=	SubStr(A_LoopField,1,p-1), VarSetCapacity(%v%,0)
}
