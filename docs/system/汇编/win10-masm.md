# 搭建masm汇编环境

### 1、WIN10下搭建masm汇编环境

- 下载dosbox的windows版本：https://www.dosbox.com/
- 下载masm等程序：https://github.com/yinzhipeng123/Picture_Bed/raw/main/masm615.zip

masm解压后，改名为masm615，，放在D盘，如下

```powershell
D:\masm615
BIN/
DOSXNT.EXE*
。。。。
```

安装dosbox，在DOSBOX安装目录，双击DOSBox 0.74-3 Options.bat，会弹出DOSBOX的配置，末尾添加

```powershell
mount d D:\masm615
path=%path%;D:\BIN;D:\
d:
cd myasm
```

在D:\masm615\myasm目录下进行编辑asm文件，在DOSBOX模拟器里面就能直接对asm文件进行编译，运行和调试了

编辑 eg101.asm

```ASN.1
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

打开桌面上的DOSBox 0.74-3图标，命令行里输入：

```powershell
> ML611.EXE eg101.asm
> eg101.exe
hello assembly!
>
```

### 2、mac上搭建masm汇编环境

- 下载dosbox的windows版本：https://www.dosbox.com/
- 下载masm等程序：https://github.com/yinzhipeng123/Picture_Bed/raw/main/masm615.zip

masm解压后，改名为masm615，放在家目录 /Users/zhipengyin/下，如下

```bash
zhipengyin@zhipengyindeMBP masm615 % ls
BIN		HELP		LIB.EXE		Ml611.exe	masm
DOSXNT.EXE	INCLUDE		LINK.EXE	Ml710.exe	ml.exe
EDIT.COM	INIT		MASM.EXE	SAMPLES		myasm
EDIT.HLP	LIB		ML.ERR		TMP
zhipengyin@zhipengyindeMBP masm615 % pwd
/Users/zhipengyin/masm615
```

安装DOSBOX，然后编辑DOSBOX配置。如下

```bash
vim /Users/zhipengyin/Library/Preferences/DOSBox\ 0.74-3-3\ Preferences

[autoexec]
# Lines in this section will be run at startup.
# You can put your MOUNT lines here.
# 在这添加下面的内容
mount d /Users/zhipengyin/masm615
path=%path%;D:\BIN;D:\
d:
cd myasm
```

在/Users/zhipengyin/masm615/myasm目录下进行编辑asm文件，在DOSBOX模拟器里面就能直接对asm文件进行编译，运行和调试了

编辑 eg101.asm

```ASN.1
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

打开桌面上的DOSBox图标，命令行里输入：

```powershell
> ML611.EXE eg101.asm
> eg101.exe
hello assembly!
>
```

### 

