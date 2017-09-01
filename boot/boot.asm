%define BASE    0x1000  ; 0x1000:0x0 = 10000
%define KSIZE   128     ; nombre de secteurs a charger
%define CODE_DESC   0x8
%define DATA_DESC   0x10
%define NULL_DESC   0x0

[BITS 16]
[ORG 0x0]

jmp start
%include "util0.inc"
%include "a20.inc"
start:

;-------------------------------;
;   Setup segments and stack    ;
;-------------------------------;

    ;move boot sector up to adress 90000

    mov ax, 9000h  ; stack en 0xFFFF
    mov es, ax
    xor di, di

    mov ax, 07C0h
    mov ds, ax
    xor si, si
    mov cx, 512
    rep
    movsb

    jmp 0x9000:point_check

point_check:

    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x0fff 

; recuparation de l'unite de boot
    mov [_BOOTDRIVER_], dl    

;--------------------;
;   print message    ;
;--------------------; 

    mov si, MsgLoad
    call afficher

    mov si, loadKernelMsg
    call afficher

;-----------------------------------------------;
;   Reset and load system at address 0x10000     ;
; from second sector on boot Boot Disk          ;
;-----------------------------------------------;

    xor ax, ax
    int 0x13

    push es
    mov ax, BASE
    mov es, ax
    mov bx, 0
    mov ah, 2
    mov al, KSIZE
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [_BOOTDRIVER_]
    int 0x13
    pop es


;-----------------------------------------------;
;   install our GDT (Global Descriptor Table)   ;
;-----------------------------------------------;

; initialisation du pointeur sur la GDT
    mov ax, gdtend    ; calcule la limite de GDT
    mov bx, gdt
    sub ax, bx
    mov word [gdtptr], ax

    xor eax, eax      ; calcule l'adresse lineaire de GDT
    xor ebx, ebx
    mov ax, ds
    mov ecx, eax
    shl ecx, 4
    mov bx, gdt
    add ecx, ebx
    mov dword [gdtptr+2], ecx
    call _EnableA20
; passage en modep
    cli
    ;---------------------------------------;
    ;   move system from 0x1000 at 0x0000   ;
    ;---------------------------------------;

    lgdt [gdtptr]    ; charge la gdt
    sti
    mov si, gdtMsg
    call afficher
    cli

    mov eax, cr0
    or  ax, 1
    mov cr0, eax        ; PE mis a 1 (CR0)

    jmp next

next:
    mov ax, DATA_DESC        ; segment de donne
    mov ds, ax
    mov fs, ax
    mov gs, ax
    mov es, ax
    mov ss, ax
    mov esp, 0x9F000  

    jmp dword CODE_DESC:0x10000      ; reinitialise le segment de code

;--------------------------------------------------------------------
badDiskMsg      db 13,10," BootDisk error ... Computer must restart", 13, 10, 0
MsgLoad         db 13,10,"loading system ...", 13, 10, 0
_BOOTDRIVER_      DB   00h        ;Drive boot sector came from
loadKernelMsg   db 13,10,'Nadia 0.01 is preparing to load, Please wait ...',13, 10, 0
gdtMsg   db 13,10,'GDT loading ...',13, 10, 0
;--------------------------------------------------------------------
gdt:
    db 0, 0, 0, 0, 0, 0, 0, 0
gdt_cs:
    db 0xFF, 0xFF, 0x0, 0x0, 0x0, 10011011b, 11011111b, 0x0
gdt_ds:
    db 0xFF, 0xFF, 0x0, 0x0, 0x0, 10010011b, 11011111b, 0x0
gdtend:
;--------------------------------------------------------------------
gdtptr:
    dw 0  ; limite
    dd 0  ; base
;--------------------------------------------------------------------

;; NOP jusqu'a 510
times 510-($-$$) db 0
dw 0xAA55
