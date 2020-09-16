segment .data
	num dd 145
	n dd 145
	msm1 db "Yes",10,0
	msm2 db "No",10,0

segment .text
	global main
	extern printf

main:
	
	;-------------------------------------------------------------------;
	;cuenta cifras :num el numero a contar, resultado sale en ebx
	xor ebx,ebx
	xor eax,eax
	mov ecx,10
	mov eax,DWORD[num]
	mov esi,0
	cont_c:
		xor edx,edx
		cmp eax,0
		je end_cont_c
		div ecx
		inc ebx		
		jmp cont_c
	end_cont_c:

	;-------------------------------------------------------------------;
	mov eax,DWORD[n]
	mov esi,0
	mov ecx,ebx
	xor edx,edx
	push edx
	strong_number:
		cmp ecx,0
		je exit
		mov eax,DWORD[n]
		mov esi,0
	;-------------------------------------------------------------------;
	;factorial: n el numero a hacer el factorial, respuesta en eax
		xor edx,edx
		mov ebx,10
		div ebx
		mov [n],eax
		mov ebx,edx
		mov eax,1
		fact:
			cmp ebx,0
			je exit_fact
			cmp ebx,1
			je exit_fact
			mul ebx
			dec ebx		
			jmp fact
		exit_fact:
			pop edx
			add edx,eax
			push edx
			dec ecx
			jmp strong_number
	;-------------------------------------------------------------------;

	exit:
	pop edx
	mov eax,DWORD[num]
	mov esi,0

	cmp edx,eax
	je yes
	push msm2
	call printf

	jmp final
	yes:
	push msm1
	call printf
	final:
	mov eax, 1
	mov ebx, 0
	int 80h

;nasm -f elf32 -o strong_number.o strong_number.asm
;gcc -m32 -o strong_number strong_number.o
;./strong_number
