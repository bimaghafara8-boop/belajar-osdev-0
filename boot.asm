[bits 16]
global mulai

mulai:
  cli
  mov [boot_drive], dl

  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7c00

  mov ah, 0x02
  mov al, 1
  mov ch, 0
  mov dh, 0
  mov cl, 2
  mov bx, 0x7e00

  mov dl, [boot_drive]
  int 0x13
  jc $

  in al, 0x92
  or al, 0x2
  out 0x92, al

  mov eax, cr0
  or eax, 0x1
  mov cr0, eax

  jmp 0x08:mulai_32bit

boot_drive db 0

[bits 32]
mulai_32bit:
  mov ax, 0x10
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000
  mov esp, ebp

  extern main_c
  call main_c
  jmp $

gdt_mulai:
  dq 0x0

gdt_kode:
  dw 0xffff
  dw 0x0
  db 0x0
  db 10011010b
  db 11001111b
  db 0x0

gdt_data:
  dw 0xffff
  dw 0x0
  db 0x0
  db 10010010b
  db 11001111b
  db 0x0

gdt_selesai:

gdt_tabel:
  dw gdt_selesai - gdt_mulai - 1
  dd gdt_mulai

times 510 - ($ - $$) db 0
dw 0xaa55
