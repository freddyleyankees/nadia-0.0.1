
;Copyright  c) 2017
;@author kabon fredddy

;         ------------------------
;         --   IDT, --
;         ------------------------

extern memcopy,_asm_exec_div_by_0_int, _asm_exec_DG_int, _asm_exec_nn_mask_int, _asm_exec_BP_int, _asm_exec_OF_int, _asm_exec_BR_int, _asm_exec_UD_int,_asm_exec_NM_int, _asm_exec_DF_int,  _asm_exec_CSO_int, _asm_exec_TS_int, _asm_exec_NP_int, _asm_exec_SS_int, _asm_exec_GP_int, _asm_exec_PF_int, _asm_exec_MF_int, _asm_exec_resv_int, _asm_default_int,  _asm_clock_irq_0, _asm_kbd_irq_1, _asm_syscalls

global init_set_IDT, _init_set_IDT, set_idt, _idt, set_idt_table

%define __DESC_CODE__		0x08
%define __TRAP_GATE__		0x8F00
%define __INT_GATE__		0x8E00
%define __SYST_GATE__		0xEF00
%define __MAX_IDT__		 	256


; 	---------------------------------------------------------
; 	-	[object]											-
; 	-		[type]: macro									-
; 	-		[name]:"init_set_IDT"								-
; 	-		[arg]: ['select':reference,'offset':reference,	-
;	-			'access':reference,'descriptor':struct]		-	
;	-		[description]:									-
; 	-	[end]												-
; 	---------------------------------------------------------

%macro init_set_IDT 4 ;16bits:select, 32bits:offset, 16bits:type,
	mov ax,%1
	and ax, 0xFFFF
	mov WORD [%4+2], ax

	mov eax, %2
	mov ax, 0xFFFF
	mov	WORD [%4], ax
	shr eax, 16
	mov WORD [%4+6], ax

	mov ax, %3
	and ax, 0xFFFF
	mov WORD [%4+4], ax
%endmacro


; 	---------------------------------------------------------
; 	-	[object]											-
; 	-		[type]: function								-
; 	-		[name]:"_init_set_IDT"								-
; 	-		[arg]: none										-	
;	-		[description]:									-
; 	-	[end]												-
; 	---------------------------------------------------------

set_idt_table:
	;/* Initialisation des descripteurs systeme par defaut */
	
		init_set_IDT __DESC_CODE__,  _asm_exec_resv_int, __INT_GATE__, _idt
		init_set_IDT __DESC_CODE__,  _asm_exec_resv_int, __INT_GATE__, _idt+8
		
		init_set_IDT __DESC_CODE__,  _asm_clock_irq_0, __INT_GATE__, _idt+256
	.done:
	ret

dw 0

; 	---------------------------------------------------------
; 	-	[object]											-
; 	-		[type]: function								-
; 	-		[name]:"_idt_dsc"								-
; 	-		[arg]: none										-	
;	-		[description]:									-
; 	-	[end]												-
; 	---------------------------------------------------------

_idt_dsc:
	dw 0xFF					;limit
	dd _idt 			;base
	ret

dw 0

; 	---------------------------------------------------------
; 	-	[object]											-
; 	-		[type]: function								-
; 	-		[name]:"set_idt"								-
; 	-		[arg]: none										-	
;	-		[description]:									-
; 	-	[end]												-
; 	---------------------------------------------------------

set_idt:
	push ebp
	mov ebp, esp
	push edi
	mov edi, [ebp+8]
	lidt [edi]
	ret 4

_init_set_IDT:
	call set_idt_table
	push _idt_dsc
	call set_idt
	ret
	

dw 0

; 	---------------------------------------------------------
; 	-	[object]											-
; 	-		[type]: structure								-
; 	-		[name]:"_idt"									-
; 	-		[arg]: none										-	
;	-		[description]:									-
; 	-	[end]												-
; 	---------------------------------------------------------

_idt:   times 256*8 dw 0
