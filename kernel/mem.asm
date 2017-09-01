

global memcopy

memcopy: ;address source, address destination, size
	push ebp
	mov ebp, esp
	pusha
	mov esi, [ebp+8]		; address destination
	mov edi, [ebp+12]		; address source
	mov ecx, [ebp+16]		; size
	rep movsd
	.done:
	popa
	pop ebp
ret 12