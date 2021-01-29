 

# ICCAD review 

Jerry Chandler

2021.01.25



The first priority*** - to finish all homework by yourself, including small tasks maybe not in written, such as saying meta-characters in English, running demonstration programs and etc.



# ICCAD Overview

IC thread: Shockley Lab -> Fairchild -> Intel

PC/OS thread: Apple -> IBM -> Microsoft -> Linux

Big-3 of EDA: Synopsys/Cadence/Mentor Graphics

ICCAD vs. EDA, subtle difference?

EDA	electronic design automation

ICCAD is a part of EDA

 

# A difficult question in previous years as an example.

Link each person's name to the obviously relevant item(s) on the right. 

Paul Allen       Apple

Larry Ellison     C Language

Steve Wozniak      Free Software Foundation / GNU

Bill Joy      Intel

Dennis Ritchie       Linux	

Richard Stallman  Microsoft 

Ken Thompson      Oracle

Linus Torvalds       Unix

Gordon Moore      Fairchild

Steve Jobs      Macintosh/NeXT

Robert Noyce    gcc

Bill Gates    vi

 

Noyce, jean hoerni, Gordon moore: Fairchild

Paul allen: Microsoft创始人

Larry Ellison：Oracle甲骨文公司创始人

Steve Wozniak：apple创始人

Bill Joy：vi

Dennis Ritchie：c language， unix

Richard Stallman：Free Software Foundation / GNU，gcc

Ken Thompson：unix

Linus Torvalds：linux

Gordon Moore：Fairchild，Intel

Steve Jobs：apple，Macintosh/NeXT

Robert Noyce：Fairchild，Intel

Bill Gates：Microsoft

 

 

# Unix Overview

Is Linux a kind of Unix? Why say GNU/Linux? GNU? GPL? GUI?

 

不是，linux是完全开源的，unix是商业化的

法律上没有联系，但也是unix-like

GNU的意思是GNU’s not Unix, 是一个自由开源的操作系统，内核使用linux内核，linux系统包括了linux内核和GNU的组件

General Public License，GNU的通用公共许可证

Graphical User Interface，用户图形界面，人和计算机交互

 

unix_command -options arguments

case sensitive

Ubuntu, what is it?

*Ubuntu*是一个以桌面应用为主的Linux操作系统，其名称来自非洲南部祖鲁语或豪萨语的“*ubuntu*"一词，意思是“人性”“我的存在是因为大家的存在"，是非洲传统的一种价值观。

 

# Getting Started

## uname -a; passwd; date

![image-20210125145418479](./images/image-20210125145418479.png)

![image-20210125145459940](./images/image-20210125145459940.png)

---

## alias rm='rm -i'

![image-20210125145802924](./images/image-20210125145802924.png)

alias can define another name for a command

---

## who; who am i/whoami

![image-20210125150005253](./images/image-20210125150005253.png)

'who' shows right now, who is logged into this machine;

whoami shows the current ID

**who：显示当前真正登录系统中的用户（不会显示那些用su命令切换用户的登录者）**
 **who am i: 显示当前登录时用的用户名，尽管切换了多个用户**
 **whoami: 显示当前用户的用户名**

---

## man/xman/info, conventional manual organization, reading manual

![image-20210125150218059](./images/image-20210125150218059.png)

xman is GUI

info page是将文件数据拆成一个个的段落，每一个段落有个独立的页面，相当于一个独立的节点，每一个节点都有定位于链接。

---

## more - space bar, b, q

![image-20210125152300592](./images/image-20210125152300592.png) 

---

# File System

## meanings of standard directories' names /bin /dev /tmp /lib /etc /src

bin: binary

dev: device

tmp: temp files

lib: library

etc: etcetra directory -> editable text configuration

src: source code

---

## some concepts

A disk: superblock, inode, data block

File tree: full path name/relative path name

. and ..

pwd/cd/mkdir/rmdir

---

## ls with its useful options: -altdR

-a: all

-l: long

![https://img-blog.csdn.net/20170820002015682?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemh1b3lhXw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center](images/20170820002015682)

-t: 将文件依建立时间之先后次序列出

-d :![image-20210125153032216](./images/image-20210125153032216.png)

only show the current directory

-R: 若目录下有文件，则以下之文件亦皆依序列出

## meaning of every field of 'ls -l' output

-r read permission

-w write permission

-x execute permission

-- no permission

![image-20210125153824233](./images/image-20210125153824233.png)

1+3*3

first shows the type, d is directory, l is link file, - is normal file, p is pipe

pemissions/mode: rwx for user/group/other

![image-20210126065008827](images/image-20210126065008827.png)

---

## chmod/chown/chgrp, numerical(777) chmod 

chmod: change the file or directory access permissions

chown: change the owner of a file

chgrp: change the group of the file

chmod:

![image-20210125154342629](./images/image-20210125154342629.png)

umask 022?

![image-20210125154556657](./images/image-20210125154556657.png)

---

## cat/head/tail/more

cat: concatenate

head: first 10

taile: last 10

more: same as u think

---

## cp/mv/rm with options -f -i

cp source target

mv: rename/transport !!!

rm: file

-f: no need to confirm

-i: need to confirm

---

other commands on the slides: ln/unlink, find, gzip, wc, diff, grep

ln: link <------> unlink

![image-20210125160317550](./images/image-20210125160317550.png)

find . \\(  user Bill -0 -size +1000c \\) -print -exec rm{} \;

find ^~^bill ^~^denis -size +1000 -atime 30 -ok rm{};	a：访问过



gzip

wc display a count of lines, words and characters in a file

-c或--bytes或--chars   只显示Bytes数。

-l或--lines   显示行数。

-w或--words   只显示字数。

diff compare the difference line by line

grep

![image-20210125182314736](./images/image-20210125182314736.png)



## other utilities such as file, which, sort, whatis/apropos

which: locate a command

file: determine file type

sort	-n按照数值大小 -o output 

whatis: search for word (must match)

apropos: search for string (can be a part of a string)

## ==saying source code line (with many meta characters) in English==

 

| meta character |             English             |
| :------------: | :-----------------------------: |
|       /        |              slash              |
|       \        |            backslash            |
|       "        |          double quote           |
|       `        |            backquote            |
|       *        |            asterisk             |
|       :        |              colon              |
|       ;        |            semicolon            |
|       '        |              quote              |
|       ^        |              caret              |
|       ~        |              tilde              |
|       {}       | opening/closing curly brackets  |
|       ()       |   opening/closing parenthesis   |
|       []       | opening/closing square brackets |
|       !        |             exclam              |
|       $        |             dollar              |
|       <>       |          less/greater           |
|       \|       |          vertical bar           |
|       &        |            ampersand            |
|       #        |              pound              |
|       @        |               at                |
|       %        |             percent             |
|       ,        |              comma              |
|       +        |              plus               |
|       =        |              equal              |
|       ？       |          question mark          |



# vi

## insert mode / command mode: command line mode

## h, j, k, l

k is upward! 

## \^F\^B\^D^U

f: forward one screen

b: backward one screen

d: down half screen

u: up half screen

---

## inserting text

a, A, i, I, o, O

a append text after the cursor

A append text at end of line

i insert text before the cursor

I insert text at beginning of line

o open new line after current line

O open new line before current line

---

## cursor movement

/, ?, n, N

f character	forward to next this character

/ pattern string	go to matched pattern downward

? pattern string	go to matched mattern upward

n N	next matched

---

## deleting text

dd, yy, p, 4dd10jp, u

dd	delet current line

yy	yank line(s) to buffer (copy)

p	paste

4dd10jp	next 4 lines (including this line) cut to buffer; 10j=move 10 lines down and paste after it 

---

## file manipulation

:wq, :q!

:set all, :set number, :set nonumber

:[]s/old_exp/new_exp/[g]

:1,$-3s/Oct\\./Nov./g   

![image-20210125190751571](./images/image-20210125190751571.png)

g	替换每一行的所有

没有g的话代表只替换每一行的第一个

```
.代表当前行，$代表最后一行
```

## ==Regular Expression** - the basics and examples (meta-characters in REP)==

?	any single	（wild cards）

**\*	==0 or >=2 of the former character**

**shell中*	表示任何子元，在运算时表示加法==**

.在shell中表示目录

.在正则表达式中表示 any single 除了新的一行

[abc]	matches any of character enclosed

[a-d]	the same as above, only shows in range

[!def]	only not match def

{abc,def,ghi}	match any set of characters separated by comma

^~^	home directory

^~^user	home directory of the specified user

[^abc] match any character ==NOT== in the enclosed set

^jerry	must start with jerry

jerry$	must end with jerry

 

# Shell

echo $SHELL, sh<=>csh<=>bash

sh	Bourne shell	$

csh	%

bash	bourne-again shell

bash提供了csh和ksh的交互，语言兼容sh，是GNU的，免费的

meta-characters => the usages as wild cards on shell command line

stdin, stdout, stderr (the mechanism of one-in, two-outputs)

## basic redirection operators < > >> | 2>, &> or >&, 

\> \>! \>|	redirect standard output to file

\>>	append standard output to file

<	input redirection from file

|	pupe output to another command	command1|command2

2>	stderr

2&>1 2>&1 means that both write into 1's correspoding file, and only opens the file once, so no mistake!

---

## tee

replicate the standard output to the list

![image-20210125201521926](./images/image-20210125201521926.png)

## export PATH=$PATH:.

## command symbols

;	command separator

&	run in the background	----->	\^z to stop, bg to continue, fg to  return, *jobs* can see what jobs are in the background 

&&	run the following command only if previous command completes successfully

||	run the following command only if previous command did not complete successfully

## ps 

-l	shows only process about your logged PID

-ef	

```
e  显示环境变量
f  显示程序间的关系
```

top	show updating process info

pstree

uptime	tell how long the system has been running

---

## kill 

kill -9 PID	absolutely kill!

kill -l	see all the available kill signals

---

## \#!Magic Symbol

how to use it?

commands in samples, e.g.,

## conditions

(if -d) (if !-w) if [`tty` != "console" ]

-r	return 1 if it exists and is readable

-w	exists and writable

-x	exists and executable

-f	regular file

-d	directory

-e	exist

-o	if the user owns the file

-z	empty

tty命令用于显示 终端机 连接 标准输入设备的 文件名称

## diff $SYNOPSYS/admin/setup/$f $LIBX11 >& /dev/null

then it only returns state but no output

$status

 

# Network

## TCP/IP, HTTP, FTP, LAN, DNS

transmission control protocol/ internet protocol

LAN	Local Area Network

## 4 Layers

Application/Transport/Internetwork/Link&Physical

real example for each layer? how a network basically works on such a layer?

TCP / UDP / IP/ Token ring

## command

ping, hostname, cat /etc/hosts, ssh

ping	determine if destination is alive

hostname	show the names of host

cat /etc/hosts	IP addresses and host names are saved in file /etc/hosts

ssh

## ftp

text-mode ftp commands: ls, !ls, pwd, cd, lcd, put, get, ascii, binary, mput, mget

!	escape to the local machine

ascii/binary	transmission type

get	get a file from remote to local

mget	get files from remote to local

put	upload a file

mput upload files

cd	remote cd

lcd	local cd



# System Admin

su/sudo

## inode->data blocks

file = an inode + data blocks <= what happens when ls a file, cat a file?

ls:	看对应inode的信息

cat	先找到inode的地址，再由地址去对应的数据块

inode( filename & location data) + indirect data blocks + storage blocks => a file

## superblock vs. inode

df -k vs. du -ks <=> superblock vs. inode; which is faster?

df is faster

df	display filesystem information

du	report disk usage

## mount

mount/umount

mount filesystem mountpoint

## file system backup

tar cvf/xvf/tvf

-c	create an archive

-t	table of content list

-x	extract from archive	(recover)

-f file	name the archive file

-v	verbose	(show the process)

'-' is optional

## network file system(NFS)

NFS

 

# X window

Purpose of X. X Window <=> M$ Windows? 

X windows只是一个图形管理器，而m$ windows是一个完整的操作系统

linux比较特别，它的图形和核心是分开的

X window是历史上为了解决图形在不同的计算机之间传递的问题，怎么解决？作为一种==服务==

X11R6,	最新的，但也很久没有更新了

xterm

export DISPLAY=192.168.0.1:0.0	送到哪里去

Client/Server model <= Request/Reply

X Events: examples?

xclock xeyes xwininfo

gcc demo_x.c -lX11

# Software development tools

## ==gcc==

gcc -c -g -o tri.o triangle.c (-I?, -D?)

-I pathname	add pathname to include

-D symbol	=#define symbol

gcc -g tri.o -lm (-L?)

-L	add directory to the library search path

![image-20210126094609863](images/image-20210126094609863.png)

only gcc -c will produce .o without linking

gcc -g only tell the computer to write down the process, but it does not care what it does, i.e., only compile or compile & link

gcc -o only tell the computer to output something, it still does not care whether the result is .o or .exe

## gdb

gdb	GNU

ddd	GUI

br	breakpoint

print value

next

where

## touch

## makefile

a makefile rule

target: dependencies

​    commands

make -n -f makefile.bit

-n	no execution mode

draw dependency graph for any makefile

understand 2 makefiles in homework, and another in github（有发吗?）

understand every line of makefile in cube_wrong.tar, try to touch some files, and predict the result of running "make".

git, source code version control concept

## makefile macros

$*	the basename of the current target

$<	the name of a dependency file (actually the trigue one)

$@	the name of the current target

$?	the list of dependencies that are newer than the target

# C programming in Unix

homework <= demo_x, cube_wrong, demo_bit, demo_fork, etc.

 

TCL, Perl, Python => ??? languages

scripting language

TCL? TK?

TCL	tool command language

TK	toolkit

/usr/bin/wish: trying hello.tcl, trying browse.tcl

 

## Perl variable types: $, @, %

$	scalar

@	array

%	associative array

running Perl demos, encourage to try Perl for homework

# homework lookback

xxd	shows 0X** of a file

awk

![image-20210126125549948](images/image-20210126125549948.png)

when the output of 'sort' is the file itself, we cannot use >, but only -o

```sh
sort  -n -k 1 -k 2 -k 3 -k 4 unsort_ip.txt > sort_ip.txt # this sentence is very important beacuse it sorts the ip in number, and use -k to point out the priority of comparation
```

```shell
wget -q -O ./xml.txt 'https://cn.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1'
```

