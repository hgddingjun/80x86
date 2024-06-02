; 练习ex02.asm
; 主引导扇区代码
; 创建日期:2021-12-08 10:42

    jmp near start

mytext db 'L',0x02,'a',0x02,'b',0x02,'e',0x02,'l',0x02,' ',0x02,\
            'o',0x02,'f',0x02,'f',0x02,'s',0x02,'e',0x02,'t',0x02,':',0x02

number db 0, 0, 0, 0, 0

;   清屏操作
start:
    mov ax, 0x600   ; AH = 6, AL = 0
    mov bx, 0x700   ; 黑底白字(BL = 0x7)
    mov cx, 0       ; 左上角：(0, 0)
    mov dx, 0x184f  ; 右下角：(80, 50)
    int 0x10

    mov ax, 0x7c0
    mov ds, ax

    mov ax, 0xb800
    mov es, ax

    cld              ;???

    mov si, mytext
    mov di, 0
    mov cx, (number-mytext)/2
    rep movsw

    ;得到标号所代表的偏移地址
    mov ax, number

    ;计算各个位数
    mov bx, ax
    mov cx, 5           ;循环次数
    mov si, 10          ;除数

digit:
    xor dx, dx
    div si
    mov [bx], dl
    inc bx
    loop digit

    ;显示各个位数
    mov bx, number
    mov si, 4

show:
    mov al, [bx+si]
    add al, 0x30
    mov ah, 0x04
    mov [es:di], ax
    add di, 2
    dec si
    jns show

    mov word [es:di], 0x0744

    jmp near $                  ; 无限循环

    times   510-($-$$)  db  0
    dw      0xaa55










