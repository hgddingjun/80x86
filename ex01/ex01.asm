; 练习ex01.asm
; 主引导扇区代码
; 创建日期:2021-12-07 17:29

;   清屏操作
    mov ax, 0x600   ; AH = 6, AL = 0
    mov bx, 0x700   ; 黑底白字(BL = 0x7)
    mov cx, 0       ; 左上角：(0, 0)
    mov dx, 0x184f  ; 右下角：(80, 50)
    int 0x10

    mov ax, 0xb800
    mov es, ax

    mov byte [es:0x00], 'L'
    mov byte [es:0x01], 0x02
    mov byte [es:0x02], 'a'
    mov byte [es:0x03], 0x02
    mov byte [es:0x04], 'b'
    mov byte [es:0x05], 0x02
    mov byte [es:0x06], 'e'
    mov byte [es:0x07], 0x02
    mov byte [es:0x08], 'l'
    mov byte [es:0x09], 0x02
    mov byte [es:0x0a], ' '
    mov byte [es:0x0b], 0x02
    mov byte [es:0x0c], 'o'
    mov byte [es:0x0d], 0x02
    mov byte [es:0x0e], 'f'
    mov byte [es:0x0f], 0x02
    mov byte [es:0x10], 'f'
    mov byte [es:0x11], 0x02
    mov byte [es:0x12], 's'
    mov byte [es:0x13], 0x02
    mov byte [es:0x14], 'e'
    mov byte [es:0x15], 0x02
    mov byte [es:0x16], 't'
    mov byte [es:0x17], 0x02
    mov byte [es:0x18], ':'
    mov byte [es:0x19], 0x02

    mov ax, number
    mov bx, 10

    ;设置数据段基址
    mov cx, cs
    mov ds, dx

    ; 求个位
    mov dx, 0
    div bx
    mov [0x7c00+number+0x00], dl

    ; 求十位
    xor dx, dx
    div bx
    mov [0x7c00+number+0x01], dl

    ; 求百位
    xor dx, dx
    div bx
    mov [0x7c00+number+0x02], dl

    ; 求千位
    xor dx, dx
    div bx
    mov [0x7c00+number+0x03], dl

    ; 求万位
    xor dx, dx
    div bx
    mov [0x7c00+number+0x04], dl

    mov al, [0x7c00+number+0x04]
    add al, 0x30
    mov [es:0x1a], al
    mov byte [es:0x1b], 0x04

    mov al, [0x7c00+number+0x03]
    add al, 0x30
    mov [es:0x1c], al
    mov byte [es:0x1d], 0x04

    mov al, [0x7c00+number+0x02]
    add al, 0x30
    mov [es:0x1e], al
    mov byte [es:0x1f], 0x04

    mov al, [0x7c00+number+0x01]
    add al, 0x30
    mov [es:0x20], al
    mov byte [es:0x21], 0x04

    mov al, [0x7c00+number+0x00]
    add al, 0x30
    mov [es:0x22], al
    mov byte [es:0x23], 0x04

    mov byte [es:0x24], 'D'
    mov byte [es:0x25],0x07

infi:
    jmp near infi                  ; 无限循环

    number db 0, 0, 0, 0, 0

    times   510-($-$$)  db  0

    dw      0xaa55










