
extern outb, outw, outbp, inb, inw
global initPic


initPic:
	;	/* Initialisation de ICW1 */
	pusha
	xor eax, eax
	xor ebx, ebx

	mov al, 0x11
	mov bl, 0x20
	push eax
	push ebx
	call outb

	xor eax, eax
	xor ebx, ebx

	mov al, 0x11
	mov bl, 0xA0
	push eax
	push ebx
	call outb

	;	/* Initialisation de ICW2 */
	xor eax, eax
	xor ebx, ebx

	mov al, 0x20
	mov bl, 0x21
	push eax
	push ebx
	call outb	;	/* vecteur de depart = 32 */

	xor eax, eax
	xor ebx, ebx

	mov al, 0x28
	mov bl, 0xA1
	push eax
	push ebx
	call outb	;	/* vecteur de depart = 96 */

	;	/* Initialisation de ICW3 */
	xor eax, eax
	xor ebx, ebx

	mov al, 0x04
	mov bl, 0x21
	push eax
	push ebx
	call outb

	xor eax, eax
	xor ebx, ebx

	mov al, 0x02
	mov bl, 0xA1
	push eax
	push ebx
	call outb

	;	/* Initialisation de ICW4 */
	xor eax, eax
	xor ebx, ebx

	mov al, 0x01
	mov bl, 0x21
	push eax
	push ebx
	call outb

	xor eax, eax
	xor ebx, ebx

	mov al, 0x01
	mov bl, 0xA1
	push eax
	push ebx
	call outb

	;	/* masquage des interruptions */
	xor eax, eax
	xor ebx, ebx

	mov al, 0x0
	mov bl, 0x21
	push eax
	push ebx
	call outb

	xor eax, eax
	xor ebx, ebx

	mov al, 0x0
	mov bl, 0xA1
	push eax
	push ebx
	call outb
	popa
ret