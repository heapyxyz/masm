.686
.model flat, C

extern ExitProcess@4 : PROC
extern _write : PROC

; int _write(
;   int fd,
;   const void *buffer,
;   unsigned int count);

.data
    text db "hello", 10, 0

.code
main PROC
    push 7 ; length of text (7 characters)
    push OFFSET text ; buffer
    push 1 ; fd, 1 = stdout
    call _write

    add esp, 12 ; stack cleanup (C calls only)

    push 0
    call ExitProcess@4
main ENDP
END