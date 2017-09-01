;
;[object]
; 		[type]: function:{/* management string */}
;
;@Copyright (c) 2017
;@author : kabong freddy
;


;	---------------------------------------------------------------------
;	-	In this file, we define several functions who allow print charater,
;	-	or string in screen and others functions who allow move cursor 
;	-	when one print string 
;	---------------------------------------------------------------------


extern outb, outw, outbp, inb, inw
global getChar, print, cleanScreen, cursorX, cursorY, posCursorXY, nullXY, setXY

%define VIDEO_SEG 0xB8000
%define MAX_LINE 25
%define XCOLOR 0x07
%define MAX_COL 80
%define MAX_SCREEN 2000


; 	-----------------------------------------------------
; 	-	[object]										-
; 	-		[type]: function							-
; 	-		[name]:"getChar"							-
; 	-		[arg]: arg:charater							-	
; 	-		[description]:								-
; 	-	[end]											-
; 	-----------------------------------------------------

getChar:
	push ebp
	mov ebp, esp
	pusha
	push edi
	xor edx, edx
	mov edx, [ebp+8]
	mov edi, VIDEO_SEG

	;to determine position of character we 're doing do
	;pos = cursorY*2*MAX_COL+2*cursorX
	
	.pos:
		;clean register

		xor eax, eax
		xor ecx, ecx
		xor ebx, ebx

		
		;here we're going do cursorY*2*MAX_COL

		mov al, byte [cursorY]
		mov cl, MAX_COL
		mul cl
		shl ax,1
		mov bx, ax 

		;then we 're going add 2*cursorX
		
		xor ecx, ecx
		xor eax, eax

		mov al, byte [cursorX]
		mov cl, 2
		mul cl
		add eax, ebx

		add edi, eax 
		xor eax, eax
		xor ebx, ebx

	.do_write:
		cmp dl, 10
		je .new_line
		cmp dl, 13
		je .a1

		mov byte [edi], dl
		mov byte [edi+1], XCOLOR
		cmp byte [cursorX],160
		je .new_line

		inc byte [cursorX]
		jmp .done

	.a1:
			mov byte [cursorX], 0
			jmp .done

	.new_line:
		inc byte [cursorY]
		mov byte [cursorX], 0
		jmp .done

	.done:
		mov al, byte [cursorX]
		mov bl, byte [cursorY]
		push ebx
		push eax
		call posCursorXY
		pop edi
		popa
		pop ebp
	ret 4

; 	-----------------------------------------------------
; 	-	[object]										-
; 	-		[type]: function							-
; 	-		[name]:"print"								-
; 	-		[arg]: arg:reference {string}				-	
;	-		[description]:								-
; 	-	[end]											-
; 	-----------------------------------------------------

print:
	push ebp
	mov ebp, esp
	push esi
	push eax
	xor eax, eax
	xor esi, esi
	mov esi, [ebp+8]
	
	.loop_char:
		mov al, byte [esi]
		cmp al, 0
		je .done
		
		push eax
		call getChar
		inc esi
		jmp .loop_char

	.done:
		pop eax
		pop esi
		pop ebp
	ret

; 	-----------------------------------------------------
; 	-	[object]										-
; 	-		[type]: function							-
; 	-		[name]:"scrollScreen"						-
; 	-		[arg]: arg:number							-	
; 	-		[description]:								-
; 	-	[end]											-
; 	-----------------------------------------------------

scrollScreen:
	push ebp
	mov ebp, esp

	;...

	pop ebp
	ret 4

; 	-----------------------------------------------------
; 	-	[object]										-
; 	-		[type]: function							-
; 	-		[name]:"posCursorXY"						-
; 	-		[arg]:['x':number,'y':number]				-	
; 	-		[description]:								-
; 	-	[end]											-
; 	-----------------------------------------------------

posCursorXY:
	push ebp
	mov ebp, esp
	pusha
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	mov ebx, [ebp+8]			;cursorX 
	mov ecx, [ebp+12] 			;cursorY
	mov byte [cursorX], bl
	mov byte [cursorY], cl
	mov al, cl
	mov dl, MAX_COL
	mul dl
	add al, bl
	xor ecx, ecx
	xor ebx, ebx
	mov bl, al
	mov cl, ah

	push 0x0f
	push 0x3d4
	call outb

	push ebx
	push 0x3d5
	call outb

	push 0x0e
	push 0x3d4
	call outb

	push ecx
	push 0x3d5
	call outb

	popa
	pop ebp
	ret 8

; 	-----------------------------------------------------
; 	-	[object]										-
; 	-		[type]: function							-
; 	-		[name]:"nullXY"								-
; 	-		[arg]:none									-	
; 	-		[description]:								-
; 	-	[end]											-
; 	-----------------------------------------------------

nullXY:
	mov byte [cursorX], 0
	mov byte [cursorY], 0
	ret

; 	-----------------------------------------------------
; 	-	[object]										-
; 	-		[type]: function							-
; 	-		[name]:"setXY"								-
; 	-		[arg]:['x','y']								-	
; 	-		[description]:								-
; 	-	[end]											-
; 	-----------------------------------------------------

setXY:
	push ebp
	mov ebp, esp
	push eax
	mov eax, [ebp+8]
	mov byte [cursorX], al
	mov eax, [ebp+12]
	mov byte [cursorY], al
	pop eax
	pop ebp
	ret 8

; 	-----------------------------------------------------
; 	-	[object]										-
; 	-		[type]: function							-
; 	-		[name]:"cleanScreen"						-
; 	-		[arg]:none									-	
; 	-		[description]:								-
; 	-	[end]											-
; 	-----------------------------------------------------

cleanScreen:
	pusha
	push edi
	mov ecx, 2000
	mov edi, VIDEO_SEG
	.loop_empty:
		cmp ecx, 0
		je .done
		mov byte [edi], ' '
		add edi, 2
		dec ecx
		jmp .loop_empty
		
	.done:
		call nullXY
		xor eax, eax
		xor ebx, ebx
		mov al, byte [cursorY]
		mov bl, byte [cursorX]
		push eax
		push ebx
		call posCursorXY
		pop edi
		popa
	ret


cursorX: db 0
cursorY: db 0
empty:db ' ',0



