[org 0x7c00]    ;tell the assembler that our offset is the bootsector code

; The main routine make sure the parameters are ready and then calls the function
mov bx, HELLO
call print

call print_nl

mov bx,GOODBYE
call print

call print_nl

mov dx, 0x12fe
call print_hex

; that's it! we can hang now
jmp $

;remeber to include subroutines below the hang
%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"

; data
HELLO:
    db 'Hello, World',0

GOODBYE:
    db 'Goodbye',0

; padding the magic number
times 510-($-$$) db 0
dw 0xaa55
