;
;[object]
; 		[type]: function:{/* management interrupt functions */}
;
;@Copyright (c) 2017
;@author : kabong freddy
;


;	---------------------------------------------------------------------
;	-	
;	---------------------------------------------------------------------

extern print, getChar,cleanScreen, cursorY, cursorX, posCursorXY

global fn_isr_div_by_0_int, fn_isr_DG_int, fn_isr_nn_mask_int, fn_isr_BP_int, fn_isr_OF_int, fn_isr_BR_int, fn_isr_UD_int, fn_isr_NM_int, fn_isr_DF_int, fn_isr_CSO_int, fn_isr_TS_int, fn_isr_NP_int, fn_isr_SS_int, fn_isr_GP_int, fn_isr_PF_int, fn_isr_MF_int, fn_isr_resv_int, isr_default_int, fn_isr_clock_int, fn_isr_kbd_int, do_syscalls_int

%macro	SAVE_REGS 0
	pushad 
	push ds
	push es
	push fs
	push gs 
	push ebx
	mov bx,0x10
	mov ds,bx
	pop ebx
%endmacro

%macro	RESTORE_REGS 0
	pop gs
	pop fs
	pop es
	pop ds
	popad
%endmacro

 fn_isr_div_by_0_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS
 	.string: db 'interrupt divid by zero',10,0
 	push .string
	call print
 	.done:
 		RESTORE_REGS
 		pop ebp
 	ret


 fn_isr_DG_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS
 	.string: db 'interrupt debug',10,0
 	push .string
	call print
 	.done:
 		RESTORE_REGS
 		pop ebp
 	ret


 fn_isr_nn_mask_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS
 	.string: db 'interrupt none mask',10,0
 	push .string
	call print
 	.done:
 		RESTORE_REGS
 		pop ebp
 	ret


 fn_isr_BP_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS
 	.string: db 'interrupt break point',10,0
	push .string
	call print
 	.done:
 		RESTORE_REGS
 		pop ebp
 	ret


 fn_isr_OF_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS
 	.string: db 'interrupt overflow',10,0
	push .string
	call print
 	.done:
 		RESTORE_REGS
 		pop ebp
 	ret


 fn_isr_BR_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS
 	.string: db 'interrupt bound',10,0
	push .string
	call print
 	.done:
 		RESTORE_REGS
 		pop ebp
 	ret


 fn_isr_UD_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS
 	.string: db 'interrupt invaalid opcode',10,0
	push .string
	call print
 	.done:
 		RESTORE_REGS
 		pop ebp
 	ret


 fn_isr_NM_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS

 	RESTORE_REGS
 		pop ebp

 	ret


 fn_isr_DF_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS

 	RESTORE_REGS
 		pop ebp

 	ret


 fn_isr_CSO_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS

 	RESTORE_REGS
 		pop ebp

 	ret


 fn_isr_TS_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS

 	RESTORE_REGS
 		pop ebp

 	ret


 fn_isr_NP_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS

 	RESTORE_REGS
 		pop ebp

 	ret


 fn_isr_SS_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS

 	RESTORE_REGS
 		pop ebp

 	ret


 fn_isr_MF_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS

 	RESTORE_REGS
 		pop ebp

 	ret


 fn_isr_GP_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS

 	RESTORE_REGS
 		pop ebp

 	ret


 fn_isr_PF_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS

 	RESTORE_REGS
 		pop ebp

 	ret


 fn_isr_resv_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS


 	RESTORE_REGS
 		pop ebp

 	ret

 fn_isr_clock_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS
 	.string: db 'interrupt clock',10,0
 	cmp ecx,10
 	je .a1
 	jmp .done
 	.a1:
 		push .string
 		call print
 	.done:
 	RESTORE_REGS
 		pop ebp
 	ret

 fn_isr_kbd_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS
 	

 	RESTORE_REGS
 		pop ebp

 	ret


 do_syscalls_int:
 	push ebp
 	mov ebp, esp
 	SAVE_REGS

 	RESTORE_REGS
 		pop ebp

 	ret


