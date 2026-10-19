.686
.model flat, C

extern _exit : PROC

; volatile (safe to overwrite): eax, ecx, edx
; non-volatile (restore if modified): ebx, esi, edi, ebp, esp

.code
main PROC
    mov eax, 14
    mov ecx, 32
    add eax, ecx
    ; eax = eax + ecx
    ; eax should be 2e (46 in decimal)

    mov edx, 64
    mov eax, 16
    sub edx, eax
    ; edx = edx - eax
    ; edx should be 30 (48 in decimal)

    xor edx, edx ; reset edx
    mov eax, 97
    mov ecx, 8
    div ecx
    ; eax = eax / ecx (edx will have rest)
    ; edx should be 01
    ; eax should be 0c (12 in decimal)

    ; use non-volatile registers
    ; they have to be pushed to stack and when not used anymore - popped
    push ebx
    push esi

    mov ebx, 12
    mov esi, 3
    imul ebx, esi
    ; ebx = ebx * esi
    ; ebx should be 24 (36 in decimal)
    ; worth to learn both imul and mul, mul is more complex

    pop esi
    pop ebx

    push 0
    call _exit
main ENDP
END