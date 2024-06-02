; 练习ex03.asm
; 主引导扇区代码
; 创建日期:2021-12-10 20:58

    jmp near start

msg db '1+2+3+4+5+6+...+100='

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

; 显示字符串
    mov si, msg
    mov di, 0
    mov cx, start-msg

showmsg:
    mov al, [si]
    mov [es:di], al
    inc di
    mov byte [es:di], 0x03
    inc di
    inc si
    loop showmsg

; 计算1-100的和
    xor ax, ax
    mov cx, 1
sum:
    add ax, cx
    inc cx
    cmp cx, 100
    jle sum

; 计算累加和的每个数位
    xor cx, cx          ; 设置堆栈段的段基地址
    mov ss, cx
    mov sp, cx

    mov bx, 10
    xor cx, cx
everydigit:
    inc cx
    xor dx, dx
    div bx
    add dl, 0x30
    push dx
    cmp ax, 0
    jne everydigit

; 显示各个数位
    mov al, '['
    mov [es:di], al
    inc di
    mov byte [es:di], 0x07
    inc di
showdigit:
    pop dx
    mov [es:di],dl
    inc di
    mov byte [es:di],0x02
    inc di
    loop showdigit


    mov al, ']'
    mov [es:di], al
    inc di
    mov byte [es:di], 0x07
    inc di


    jmp near $                  ; 无限循环

    times   510-($-$$)  db  0
    dw      0xaa55










