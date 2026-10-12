.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC

; int MessageBox(HWND hWnd, LPCTSTR lpText, 
;                LPCTSTR lpCaption, UINT uType);

; MB_OK / 0 / OK
; MB_OKCANCEL / 1 / OK, Cancel
; MB_ABORTRETRYIGNORE / 2 / Abort, Retry, Ignore
; MB_YESNOCANCEL / 3 / Yes, No, Cancel
; MB_YESNO / 4 / Yes, No
; MB_RETRYCANCEL / 5 / Retry, Cancel
; MB_CANCELTRYCONTINUE / 6 / Cancel, Try Again, Continue

.data
    box_title db "Title", 0 ; 0 = null 
    box_body db "1st line", 10, "2nd line", 0 ; 10 = new line, 0 = null 

.code
_main PROC
    push 5 ; box type (uType)
    push OFFSET box_title ; message box body (lpCaption)
    push OFFSET box_body ; message box title (lpText)
    push 0 ; NULL (hWnd)
    call _MessageBoxA@16
    ; ? stack cleanup isnt needed (add esp, X) for Win32 calls, only C calls need it

    push 0 ; 0 exit code
    call _ExitProcess@4
_main ENDP
END