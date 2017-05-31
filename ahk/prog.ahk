#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;DATABASE Scripts
;Remote " and "_ in a selected string
^!j::
	ClipSaved := ClipboardAll	; Store original clipboard in a variable for future use
	Clipboard =			     ; Empty the clipboard,
	SendInput, ^c 			     ; copy current selection to clipboard
	ClipWait, 30 
	FixString = %clipboard%
	StringReplace, FixString, FixString,"_,, All
	StringReplace, FixString, FixString,",, All
	Clipboard := FixString		; load the new string to clipboard
	SendInput, ^v
	FixString =
RETURN

;Format a string seperated with "," so that after each "," there is a newline
^!k::
	ClipSaved := ClipboardAll	; Store original clipboard in a variable for future use
	Clipboard =			     ; Empty the clipboard,
	SendInput, ^c 			     ; copy current selection to clipboard
	ClipWait, 30 
	FixString = %clipboard%
	StringReplace, FixString, FixString,`,,`,`r`n, All
	Clipboard := FixString		; load the new string to clipboard
	SendInput, ^v
	FixString =
RETURN

^!i::
	ClipSaved := ClipboardAll	; Store original clipboard in a variable for future use
	Clipboard :=	""		     ; Empty the clipboard,
	SendInput, ^c 			     ; copy current selection to clipboard
	ClipWait, 30 
	FixString = %clipboard%
	NewString := ""
	Loop, parse, FixString, `r, `n
	{
		Line = %A_LoopField%
		NewLine =
		NewLine := RegExReplace(Line, "^", """")
		NewString .= RegExReplace(NewLine, "$", """_`r`n")
	}
	FixString := ""
	Clipboard := NewString		; load the new string to clipboard
	SendInput, ^v
	NewString =
RETURN