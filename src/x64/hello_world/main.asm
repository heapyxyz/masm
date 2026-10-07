; hello64.asm
extern GetStdHandle : PROC
extern WriteFile : PROC
extern ExitProcess : PROC

.data
    STD_OUTPUT_HANDLE EQU -11
    msg DB "Hello World from 64-bit MASM!", 13, 10
    msg_len EQU $ - msg

.data?
    bytes_written DQ ?

.code
main PROC
    ; 1. Setup stack frame: Allocate shadow space (32 bytes) + 8 bytes to align 
    ; the stack to a 16-byte boundary (since the call instruction pushes an 8-byte RIP).
    sub rsp, 40

    ; 2. Get stdout handle: rcx = STD_OUTPUT_HANDLE
    mov ecx, STD_OUTPUT_HANDLE
    call GetStdHandle
    mov rbx, rax             ; Save returned handle in rbx

    ; 3. Write to console: WriteFile(handle, msg, len, &bytes_written, 0)
    mov rcx, rbx             ; 1st arg: Handle
    lea rdx, msg             ; 2nd arg: Pointer to string
    mov r8d, msg_len         ; 3rd arg: String length
    lea r9, bytes_written    ; 4th arg: Pointer to bytes written variable
    mov qword ptr [rsp + 32], 0 ; 5th arg: Passed on the stack above shadow space

    call WriteFile

    ; 4. Exit program: ExitProcess(0)
    xor ecx, ecx             ; rcx = 0
    call ExitProcess

    ; Clean up stack (not strictly reached due to ExitProcess, but good practice)
    add rsp, 40
    ret
main ENDP
END
