section .text

	global _start

_start:	push xyz
	push len	;	       (ebp)	(ebp + 4)     (ebp+8) (ebp+12)
	call ADD	;memory:	esp	func_ret	len	xyz
	mov [result],eax

	mov eax, 1
	xor ebx, ebx
	int 0x80

ADD:
	push ebp
	mov ebp, esp
	;Don't need local variables

	;initialize counter in ecx
	mov ecx, [ebp+8]

	;initialize edx to last element of array
	mov eax, ecx
	dec eax
	mov ebx, 4
	mul ebx
	mov edx, [ebp+12]
	add edx, eax
	xor ebx, ebx
	xor eax, eax

SUM:	add eax, [edx]
	sub edx, 4
	loop SUM
	leave
	ret
			;No need for local variables

section .data
	xyz dd 23,34,45
	len EQU ($ - xyz)/4 ;num ints to add 
section .bss
	result resd 1
