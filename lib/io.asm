



global outb, outw, outbp, inb, inw

outb:
	push ebp
	mov ebp, esp
	mov edx, [ebp+8]		; port
	mov eax, [ebp+12]		; value
	out dx, al
	pop ebp
	ret 8

outbp:
	push ebp
	mov ebp, esp
	mov edx, [ebp+8]		; port
	mov eax, [ebp+12]		; value
	out dx, al
	jmp .f
	.f:
	pop ebp
	ret 8

outw:
	push ebp
	mov ebp, esp
	mov edx, [ebp+8]		; port
	mov eax, [ebp+12]		; value
	out dx, ax
	pop ebp
	ret 8

inb:db 0
	push ebp
	mov ebp, esp
	mov edx, [ebp+8]
	push eax
	in al, dx
	mov byte [inb], al
	pop eax
	pop ebp
	ret 4


inw:dw 0
	push ebp
	mov ebp, esp
	mov edx, [ebp+8]
	push eax
	in ax, dx
	mov word [inw], ax
	pop eax
	pop ebp
	ret 4



