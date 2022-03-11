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





<font face="黑体">我是黑体字</font>
<font face="微软雅黑">我是微软雅黑</font>
<font face="STCAIYUN">我是华文彩云</font>
<font color=red>我是红色</font>
<font color=#008000>我是绿色</font>
<font color=Blue>我是蓝色</font>
<font size=5>我是尺寸</font>
<font face="黑体" color=green size=18>我是黑体，绿色，尺寸为5</font>



<div>
<font face="黑体" color=green size=18>我是黑体，绿色，尺寸为5
</div>



<span style="font-size:30px;color:blue";face:"STCAIYUN">这是比font标签更好的方式。可以试试。</span>  哈哈
