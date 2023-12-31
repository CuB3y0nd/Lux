; 主引导程序
; --------------------------------------
SECTION MBR vstart=0x7c00
  mov ax, cs
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov fs, ax
  mov sp, 0x7c00

  ; 利用 0x06 号功能，上卷全部行进行清屏
  ; --------------------------------------
  ; INT 0x10    功能号 0x06    功能描述：上卷窗口
  ; --------------------------------------
  ; 输入：
  ; AH 功能号 = 0x06
  ; AL = 上卷的行数（若为 0 则表示全部）
  ; BH = 上卷行属性
  ; (CL, CH) = 窗口左上角 (X, Y) 的位置
  ; (DL, DH) = 窗口右下角 (X, Y) 的位置
  ; 无返回值：
  mov ax, 0x600
  mov bx, 0x700
  mov cx, 0       ; 左上角 (0, 0)
  mov dx, 0x184f  ; 右下角 (80, 25)
                  ; --------------------
                  ; VGA 文本模式中，一行只能容纳 80 个字符，共 25 行
                  ; 下标从 0 开始，所以 0x18 = 24，0x4f = 79
  int 0x10        ; int 0x10

  ;; 获取光标位置
  ; .get_cursor 可获取当前光标位置，在该位置处打印字符
  mov ah, 3       ; 输入：3 号子功能是获取光标所在位置，需要存入 AH 寄存器
  mov bh, 0       ; BH 寄存器存储的是待获取光标的页号

  int 0x10        ; 输出：CH = 光标开始行，CL = 光标结束行
                  ; DH = 光标所在行号，DL = 光标所在列号
  ;; 获取光标位置结束

  ;; 打印字符串
  ; 还是用 10H 中断，不过这次调用 13 号子功能号打印字符串
  mov ax, message
  mov bp, ax      ; ES:BP 为串首地址，ES 此时同 CS 一致，
                  ; 开头时已为 SREG 初始化

  ; 光标处位置要用 DX 寄存器中内容，CX 中的光标位置可忽略
  mov cx, 9       ; CX 为串长度，不包括结束符 0 的字符个数
  mov ax, 0x1301  ; 子功能号 13 是显示字符及属性，要存入 AH 寄存器，
                  ; AL 设置写字符的方式 AL = 01：显示字符串，光标跟随移动
  mov bx, 0x2     ; BH 存储要显示的页号，此处是第 0 页，
                  ; BL 中是字符属性，属性黑底绿字（BL = 02H）
  int 0x10        ; 执行 BIOS 0x10 号中断
  ;; 打印字符串结束

  jmp $           ; 使程序悬停在此

  message db "MBR Okay!"
  times 510 - ($ - $$) db 0
  db 0x55, 0xaa

