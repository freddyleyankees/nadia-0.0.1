
;Copyright (c) 2017
;@author kabon fredddy

;         ------------------------
;         --     BOOTLOADER     --
;         ------------------------

extern print, getChar,cleanScreen, _init_set_gdt

global _start


jmp _start



;	 ----------------------------------------------------
;	 -	[object]										-
;	 -		[type]: function							-
;	 -		[name]:"_start"								-
;	 -		[arg]:none									-	
;	 -		[description]:								-
;	 -	[end]											-
;	 ----------------------------------------------------


_start:
	call cleanScreen
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	;--------- make gdt --------

	call _init_set_gdt

	push msgSys
	call print

	push msg
	call print
	
	
e:
	jmp e




msgSys: db 'loading system ...',10,0
msg: db 'starting kernel ...',10,0
empty:db ' ',0