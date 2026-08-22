default rel
extern Sleep
extern printf
extern scanf

section .data
	secret db 0xD2, 0xB3, 0xF6, 0xC5, 0xEE, 0xE7, 0xB1, 0xEE, 0xE5, 0xE5, 0xF2, 0
    takeinput  db "%11s", 0
	fmt db "%s", 0
	res1 db "Access Granted", 10, 0
	res2 db "Access Denied", 10, 0
	result dq res1, res2

section .bss
	userinput resb 12 

section .text

global main

strcmp:
	mov r8, rcx
	mov r9, rdx

.loop:

	mov al, byte[r8]
	cmp al, 0
	je .compare
	xor al, 80h

.compare:
	cmp al, byte[r9]
	jne .notsuccess

	cmp al, 0
	je .success

	inc r8
	inc r9
	jmp .loop


.notsuccess:
	mov eax, 1
	ret
.success:
	xor eax, eax
	ret



main:
	push rbp
	mov rbp, rsp
	sub rsp, 32

	lea rcx, [takeinput]
	lea rdx, [userinput]
	call scanf


	lea rcx, [userinput]
	lea rdx, [secret]
	call strcmp

	lea r10, [result]
	mov rdx, qword [r10+rax*8]
	lea rcx, [fmt]
	call printf


	
	mov ecx, 5000
	call Sleep

	add rsp, 32
	pop rbp
	xor eax, eax
	ret