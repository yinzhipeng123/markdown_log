# WIN10下搭建masm汇编环境

依赖：dosBOX 0.74，masm 6.15

https://www.dosbox.com/

http://www.downcc.com/soft/318780.html

masm解压后，改名为masm615，新建myasm目录，和BIN目录同级，放在D盘，如下

```powershell
D:\masm615
BIN/
DOSXNT.EXE*
EDIT.COM*
EDIT.HLP
HELP/
INCLUDE/
INIT/
LGX.ASM
LGX.LST
LGX.OBJ
Li2.asm
li2.exe*
li2.obj
LIB/
LIB.EXE*
LINK.EXE*
MASM.EXE*
ML.ERR
ml.exe*
Ml611.exe*
Ml710.exe*
myasm/
SAMPLES/
TEST01.ASM
test01.exe*
test01.lst
test01.obj
TMP/


```

安装DOSBOX，在DOSBOX安装目录，双击DOSBox 0.74-3 Options.bat，会弹出DOSBOX的配置，末尾添加

```powershell
mount d D:\masm615
path=%path%;D:\BIN;D:\
d:
cd myasm
```

安装完成了

在D:\masm615\myasm目录下进行编辑asm文件，在DOSBOX模拟器里面就能直接对asm文件进行编译，运行和调试了



编辑 eg101.asm

```asm6502
        ;eg101.asm
        .model small
        .stack
        .data
msg     db 'hello assembly!',13,10,'$'
        .code
        .startup
        mov dx , offset msg
        mov ah , 9
        int 21h
        .exit
        end
```

打开桌面上的DOSBox 0.74-3图标



命令行里输入：

```powershell
> ml eg101.asm
> eg101.exe
hello assembly!
>
```
