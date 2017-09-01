
;Copyright (c) 2017
;@author kabon fredddy

;         ------------------------
;         --  GDT, IDT, PAGING  --
;         ------------------------


global init_GDT, _init_set_gdt, _gdt, set_gdt_table



; 	---------------------------------------------------------
; 	-	[object]											-
; 	-		[type]: macro									-
; 	-		[name]:"init_GDT"								-
; 	-		[arg]: ['limit':reference,'base':reference,		-
;	-			'access':reference,'other':reference,		-
;	-			'descriptor':struct]						-	
;	-		[description]:									-
; 	-	[end]												-
; 	---------------------------------------------------------


%macro init_GDT 5 ;limit(20/32), base(32), access(8), other(4/8),

;limit:
	push eax
	mov eax, %1
	and eax, 0x000fffff 		
	mov word [%5], ax		;limit 0-15bits (16bits)
	shr eax, 16
	and al, 0x0f
	mov byte [%5+6], al		;limit 48-51bits (4bits)
	xor eax, eax
;base:
	mov eax, %2
	mov word [%5+2],ax		;base 16-31bits (16bits)
	shr eax, 16	
	mov byte [%5+4], al		;base 32-39bits (8bits)
	shr ax, 8
	mov byte [%5+7], al		;base 56-63bits (8bits)
	xor eax, eax
;access:
	mov al, %3
	mov byte [%4+5], al			;access 40-47bits (8bits)
	xor eax, eax
;flag:
	mov al, %4
	and al, 0xf0
	or [%5+6], al			;flag 52-55bits (4bits)
	pop eax
%endmacro

; 	---------------------------------------------------------
; 	-	[object]											-
; 	-		[type]: function								-
; 	-		[name]:"_init_gdt"								-
; 	-		[arg]: none										-	
;	-		[description]:									-
; 	-	[end]												-
; 	---------------------------------------------------------


set_gdt_table:
	init_GDT 0x0, 0x0, 0x0, 0x0, _gdt
	init_GDT 0xFFFFF, 0x0, 0x9b, 0xcf, _gdt+8
	init_GDT 0xFFFFF, 0x0, 0x93, 0xcf, _gdt+16
	ret

dw 0

; 	---------------------------------------------------------
; 	-	[object]											-
; 	-		[type]: function								-
; 	-		[name]:"_gdt_dsc"								-
; 	-		[arg]: none										-	
;	-		[description]:									-
; 	-	[end]												-
; 	---------------------------------------------------------

_gdt_dsc:
	dw 0			;limit
	dd 0 			;base
	ret
dw 0

; 	---------------------------------------------------------
; 	-	[object]											-
; 	-		[type]: function								-
; 	-		[name]:"set_gdt"								-
; 	-		[arg]: none										-	
;	-		[description]:									-
; 	-	[end]												-
; 	---------------------------------------------------------

set_gdt:
	lgdt [_gdt_dsc]
	ret

_init_set_gdt:
	mov word [_gdt_dsc], 39
	push _gdt
	mov dword [_gdt_dsc+2], dword [esp-4]
	call set_gdt_table
	call set_gdt
	pop ebx
	xor eax, eax
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	jmp 0x08:.done
	.done:
	ret
dw 0

; 	---------------------------------------------------------
; 	-	[object]											-
; 	-		[type]: structure								-
; 	-		[name]:"_gdt"									-	
;	-		[description]:									-
; 	-	[end]												-
; 	---------------------------------------------------------

_gdt:   times 8*5 db 0
