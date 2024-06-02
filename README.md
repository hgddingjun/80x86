# 80x86汇编练习

#### 进入每一个而子目录
cd ex01

#### 编译源文件:
nasm ex01.asm

#### 将编译好的ex01文件写入启动软驱中:
dd if=ex01 of=floppy.img bs=512 count=1 conv=notrunc

#### 用bochs启动调试:
bochs -f bochs_rc.txt
