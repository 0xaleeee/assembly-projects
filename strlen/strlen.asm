default rel
extern printf
extern Sleep
extern scanf
section .data
	fmt db "Length of string is %u", 10, 0
	takeinput db "%29s", 0
section .bss
	mystr resb 30

section .text
global main

mystrlen:
	mov r8, rcx
	mov ecx, 0

.loop:
	cmp byte [r8+rcx], 0
	je .done
	inc ecx
	jmp .loop
.done:
	mov eax, ecx
	ret
main:
	push rbp
	mov rbp, rsp
	sub rsp, 32
	
	lea rcx, [takeinput]
	lea rdx, [mystr]
	call scanf

	lea rcx, [mystr]
	call mystrlen

	mov edx, eax
	lea rcx, [fmt]
	call printf

	mov ecx, 5000
	call Sleep

	add rsp, 32
	pop rbp
	xor eax, eax
	ret