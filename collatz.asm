SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1

segment .data
	msj_ingrese db "La conjetura de Collatz, ingrese un numero y presione enter: (0..9)", 0xA,0xD
	tam_ingrese equ $ - msj_ingrese

	msj_par db "par sd ",0xA,0xD
	tam_par equ $ - msj_par

	msj_impar db "impar asda",0xA,0xD
	tam_impar equ $ - msj_impar

segment .bss
	numero resb 1
	res resb 1



section  .text
	global _start  ;must be declared for using gcc
_start:  ;tell linker entry point
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msj_ingrese
	mov edx, tam_ingrese
	int 0x80

	mov eax, SYS_READ
	mov ebx, STDIN
	mov ecx, numero
	mov edx, 2
	int 0x80
	
	mov eax, [numero]
	sub eax, 48d
	mov [numero], eax

	mov EDX, 0
	mov EBX, [numero]
	and BX, 1 
	cmp BX, 1
	je impar
	jmp par

par:

	;divide entre dos
	mov EDX, 0
	mov EAX, [numero] 
	mov ECX, 2d
	div ECX
	mov [numero], eax


	;imprime el caracter resultado
	mov eax, [numero]
	add eax, '0'
	mov [res], eax
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, res
	mov edx, 1
	int 0x80


	;imprime un espacio
	mov eax, 32d
	mov [res], eax
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, res
	mov edx, 1
	int 0x80

	
	;compara si es uno sale si no continua
	mov EBX, [numero]
	cmp EBX, 1d
	je salida

	;compara si es uno sale si no continua
	mov EDX, 0
	mov EBX, [numero]
	and BX, 1 
	cmp BX, 1
	je impar
	jmp par
	

impar:


	;compara si es uno sale si no continua
	mov EBX, 0x0000
	mov EBX, [numero]
	cmp bl, 1
	je salida


	;multiplica por 3
	mov EBX, 0
	mov EAX, [numero] 
	mov EBX, 3d
	mul EBX
	mov [numero], eax
	add eax, 1d
	mov [numero], eax

	
	;imprime el caracter resultado
	mov eax, [numero]
	add eax, '0'
	mov [res], eax
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, res
	mov edx, 1
	int 0x80
	

	;imprime un espacio
	mov eax, 32d
	mov [res], eax
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, res
	mov edx, 1
	int 0x80


	;compara si es impar
	mov EDX, 0
	mov EBX, [numero]
	and BX, 1 
	cmp BX, 1
	je salida
	jmp par


salida:
	mov eax, SYS_EXIT
	xor ebx, ebx  ;EBX=0 INDICA EL CODIGO DE RETORNO (0=SIN ERRORES)
	int 0x80

