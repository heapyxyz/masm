.686
.model flat

extern _ExitProcess@4 : PROC
extern _GetStdHandle@4 : PROC
extern _WriteConsoleA@20 : PROC

; HANDLE WINAPI GetStdHandle(
;       DWORD nStdHandle);

; BOOL WINAPI WriteConsole(
;       HANDLE hConsoleOutput,
;       const VOID *lpBuffer,
;       DWORD nNumberOfCharsToWrite,
;       LPDWORD lpNumberOfCharsWritten,
;       LPVOID lpReserved);

; volatile (safe to overwrite): eax, ecx, edx
; non-volatile (restore if modified): ebx, esi, edi, ebp, esp

.data
    output_handle dd -11 ; -11 = STD_OUTPUT_HANDLE
    text db 'Hello, World!', 10
         db 'This is a 32-bit MASM assembly running on Wine.', 10, 0

.code
_main PROC
    push DWORD PTR output_handle
    call _GetStdHandle@4

    push 0
    push 0 
    push 62 ; length of text (62 characters)
    push OFFSET text
    push eax ; push return value of GetStdHandle() as hConsoleOutput
    call _WriteConsoleA@20
    ; ? stack cleanup isnt needed (add esp, X) for Win32 calls, only C calls need it

    push 0 ; 0 exit code
    call _ExitProcess@4
_main ENDP
END