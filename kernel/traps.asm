

extern fn_isr_div_by_0_int, fn_isr_DG_int, fn_isr_nn_mask_int, fn_isr_BP_int, fn_isr_OF_int, fn_isr_BR_int, fn_isr_UD_int, fn_isr_NM_int, fn_isr_DF_int, fn_isr_CSO_int, fn_isr_TS_int, fn_isr_NP_int, fn_isr_SS_int, fn_isr_GP_int, fn_isr_PF_int, fn_isr_MF_int, fn_isr_resv_int, isr_default_int, fn_isr_clock_int, fn_isr_kbd_int, do_syscalls_int

global _asm_exec_div_by_0_int, _asm_exec_DG_int, _asm_exec_nn_mask_int, _asm_exec_BP_int, _asm_exec_OF_int, _asm_exec_BR_int, _asm_exec_UD_int, _asm_exec_NM_int, _asm_exec_DF_int,  _asm_exec_CSO_int, _asm_exec_TS_int, _asm_exec_NP_int, _asm_exec_SS_int, _asm_exec_GP_int, _asm_exec_PF_int, _asm_exec_MF_int, _asm_exec_resv_int, _asm_default_int,  _asm_clock_irq_0, _asm_kbd_irq_1, _asm_syscalls, make_switching



;------------------------------------------------
;routine exception
; int0 routine interrupt divide by 0
;------------------------------------------------

_asm_exec_div_by_0_int:
	
	call fn_isr_div_by_0_int
	mov al,0x20
	out 0x20,al
	
	iret

;------------------------------------------------
;int 1 routine reserved for intel debug
;--------------------------------------------------

_asm_exec_DG_int:
	
	call fn_isr_DG_int
	mov al,0x20
	out 0x20,al
	
	iret

;----------------------------------------------------
;int 2 routine non smaskable interrupt
;---------------------------------------------------

_asm_exec_nn_mask_int:
	
	call fn_isr_nn_mask_int
	mov al,0x20
	out 0x20,al
	
	iret

;----------------------------------
;int 3 routine break point
;--------------------------------

_asm_exec_BP_int:
	
	call fn_isr_BP_int
	mov al,0x20
	out 0x20,al
	
	iret

;------------------------------------
;int 4 routine overflow
;--------------------------------

_asm_exec_OF_int:
	
	call fn_isr_OF_int
	mov al,0x20
	out 0x20,al
	
	iret

;--------------------------------------------------
;int 5 routine bound range exceeded
;---------------------------------------------

_asm_exec_BR_int:
	
	call fn_isr_BR_int
	mov al,0x20
	out 0x20,al
	
	iret

;---------------------------------------------------------
;int 6 routine invalid opcode (Undefined Opcode)
;-----------------------------------------------------------

_asm_exec_UD_int:
	
	call fn_isr_UD_int
	mov al,0x20
	out 0x20,al
	
	iret

;---------------------------------------------------------------- 
;int 7 routine device not available (no math coprocessor)interrupt
;-----------------------------------------------------------------------

_asm_exec_NM_int:
	
	call fn_isr_NM_int
	mov al,0x20
	out 0x20,al
	
	iret

;------------------------------------------------
;int 8 routine doube fault interrupt
;------------------------------------------------

_asm_exec_DF_int:
	
	call fn_isr_DF_int
	mov al,0x20
	out 0x20,al
	
	iret

;---------------------------------------------------------------
;int 9 routine coprocessor segment overrun (reseved) interrupt
;-----------------------------------------------------------------

_asm_exec_CSO_int:
	
	call fn_isr_CSO_int
	mov al,0x20
	out 0x20,al
	
	iret

;-------------------------------------------
;int 10 routine TSS invalid interrupt
;-----------------------------------------

_asm_exec_TS_int:
	
	call fn_isr_TS_int
	mov al,0x20
	out 0x20,al
	
	iret

;--------------------------------------------------
;int 11 routine segment not present interrupt
;-------------------------------------------------

_asm_exec_NP_int:
	
	call fn_isr_NP_int
	mov al,0x20
	out 0x20,al
	
	iret
;-------------------------------------------------
;int 12 routine stack segment fault interrupt
;---------------------------------------------------

_asm_exec_SS_int:
	push 0x00000000
	call fn_isr_SS_int
	mov al,0x20
	out 0x20,al
	iret

;-----------------------------------------------------
;int 13 routine general protection interrupt
;--------------------------------------------------

_asm_exec_GP_int:
	
	call fn_isr_GP_int
	mov al,0x20
	out 0x20,al
	
	iret

;----------------------------------------------
;int 14 routine page fault interrupt
;--------------------------------------------------

_asm_exec_PF_int:
	
	call fn_isr_PF_int
	mov al,0x20
	out 0x20,al
	
	iret

;---------------------------------------------
;int 16 routine FPU error (math fault)
;-------------------------------------------

_asm_exec_MF_int:
	
	call fn_isr_MF_int
	mov al,0x20
	out 0x20,al
	
	iret

;--------------------------------------------------------------
;int 15 and int 17 - 31 routine reserved for intel 15,17-31
;----------------------------------------------------------------

_asm_exec_resv_int:
	
	call fn_isr_resv_int
	mov al,0x20
	out 0x20,al
	
	iret

;----------------------------------------
;routine hardware
;---------------------------------------


_asm_clock_irq_0:
	
	call fn_isr_clock_int
	mov al,0x20
	out 0x20,al
	iret

_asm_kbd_irq_1:
	
	call fn_isr_kbd_int
	mov al,0x20
	out 0x20,al
	
	iret

_asm_syscalls:
	
	push eax                 ; transmission du numero d'appel
	call do_syscalls_int
	pop eax
	
	iret

make_switching:
	mov al, 0x20
	out 0x20, al
	iret
