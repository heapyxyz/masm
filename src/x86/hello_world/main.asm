; hello32.asm
.386
.model flat, stdcall
option casemap :none

; Declare Windows API Prototypes
ExitProcess PROTO :DWORD
GetStdHandle PROTO :DWORD
WriteFile PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD

.data
    ; Standard handle ID for output is -11
    STD_OUTPUT_HANDLE EQU -11 
    
    msg DB "Hello World from 32-bit MASM!", 13, 10
    msg_len EQU $ - msg

.data?
    bytes_written DWORD ?
    stdout_handle DWORD ?

.code
main PROC
    ; 1. Get stdout handle: stdout_handle = GetStdHandle(STD_OUTPUT_HANDLE)
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov stdout_handle, eax

    ; 2. Write to console: WriteFile(handle, msg, len, &bytes_written, 0)
    invoke WriteFile, stdout_handle, ADDR msg, msg_len, ADDR bytes_written, 0

    ; 3. Exit program: ExitProcess(0)
    invoke ExitProcess, 0
main ENDP
END main
