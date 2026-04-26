[bits 16]
[org 0x7c00]
start:
  mov si, pesan
  mov ah, 0x0e

loop_teks:
  lodsb
  cmp al, 0
  je stop
  int 0x10

  jmp loop_teks

stop:
  jmp $

pesan:
  db "sistem ready!!", 0

times 510 - ($ - $$) db 0
dw 0xaa55

