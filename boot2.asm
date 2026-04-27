[bits 16]
[org 0x7c00]
  
  mov cx, 0

set_keybord:
  mov ah, 0x00
  int 0x16

  cmp al, 13
  je set_enter

  cmp al, 8
  je set_backspace

  cmp al, 'x'
  je set_stop

set_layar:
  mov ah, 0x0e
  int 0x10
  inc cx
  jmp set_keybord

set_enter:
  mov cx, 0
  mov ah, 0x0e

  mov al, 10
  int 0x10
  mov al, 13
  int 0x10
  jmp set_keybord

set_backspace:
  cmp cx, 0
  je set_keybord

  dec cx
  mov ah, 0x0e
  mov al, 8
  int 0x10
  mov al, ' '
  int 0x10
  mov al, 8
  int 0x10
  jmp set_keybord

set_stop:
  cmp cx, 0
  je stop

  jmp set_layar

stop:
  cli
  hlt

times 510 - ($ - $$) db 0
dw 0xaa55
