mov ah,0x0e

; attemp 1
; Fails because it tries to print the memory address (i.e. pointer)
; not its actual contents
mov al,'1'
int 0x10
mov al, the_secret
int 0x10

; attemp 2
; It tries to print the memory address of 'the_secret' which is the correct approach.
; However, BIOS places out bootsector binary at address 0x7c00
; so we need to add that padding beforehand.We'll do that in attemp 3
mov al,'2'
int 0x10
mov al, [the_secret]
int 0x10

; attemp 3
; Add the BIOS starting offset 0x7c00 to the memory address of the X
; and then dereference the contents of that pointer.
mov al,'3'
int 0x10
mov bx,0x7c00
add bx,the_secret
mov al,[bx]
int 0x10

; attemp 4
; We try a shortcut since we know that the X is stored at byte 0x2d in our binary.
; That's smart but ineffective,we don't want to be recounting label offsets every time we change the code.
mov al,'4'
int 0x10
mov al,[0x7c2d]
int 0x10

jmp $ ;infinite loop

the_secret:
    ; ASCII code 0x58('X') is stored just before the zero-padding.
    ; On this code that is at byte 0x2d (check it out using 'xxd file.bin')
    db 'X'

; zero padding and magic bios number
times 510- ($-$$) db 0
dw 0xaa55

