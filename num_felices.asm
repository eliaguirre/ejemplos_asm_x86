
; M A C R O S 

%macro cuadrado 1;
mov eAX, 0
mov eBX, 0
mov eAX, %1 
mov eBX, %1
mul eBX
mov %1, AX
 %endmacro 


%macro suma 3;
and eax,0x0000
and ebx,0x0000
mov Ax, %1 
mov Bx, %2
add AX, BX
mov %3, EAX
 %endmacro 

%macro imprime 1;
;imprime el caracter resultado
mov eax, 0x0000
mov al, %1
add al, '0'
mov [res], al
mov al, SYS_WRITE
mov bl, STDOUT
mov ecx, res
mov edx, 1
int 0x80
%endmacro

%macro print_char 1;
;imprime un espacio
mov al, %1
mov [res], al
mov al, SYS_WRITE
mov bl, STDOUT
mov ecx, res
mov edx, 1
int 0x80
%endmacro


SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1






segment .data
msj_ingrese db "Numeros felices, ingresa un numero: (10..44)", 0xA,0xD
tam_ingrese equ $ - msj_ingrese

msj_feliz db "el numero es feliz",0xA,0xD
tam_feliz equ $ - msj_feliz

msj_infeliz db "el numero no es feliz",0xA,0xD
tam_infeliz equ $ - msj_infeliz

segment .bss
numero resb 4
numero1 resb 4
numero2 resb 4
numero3 resb 2
res resb 1
count resb 1



section  .text
global _start  ;must be declared for using gcc
_start:  ;tell linker entry point
mov eax, SYS_WRITE
mov ebx, STDOUT
mov ecx, msj_ingrese
mov edx, tam_ingrese
int 0x80

mov eax, 3
mov ebx, 0
mov ecx, numero
mov edx, 2
int 80h

mov eax, [numero+0]
sub eax, '0'
mov ebx, [numero+1]
sub ebx, '0'

mov [numero1], al
mov [numero2], bl
mov ebx, 0
mov [numero], ebx

continuar:
 imprime [numero3] 
 imprime [numero1] 
 imprime [numero2] 
 print_char 32d

 cuadrado [numero3]
 cuadrado [numero1] 
 cuadrado [numero2] 
 suma [numero1], [numero2], [numero]
 suma [numero3], [numero], [numero]
 

 mov cx,[count];
 add cx,1d
 mov [count],cx
 cmp cX, 9
jg noes_feliz
 

 mov EDX, 0
 mov EBX, [numero]
 cmp BX, 1d
je es_feliz

 
 mov DX, 0
 mov BX, [numero]
 cmp BX, 10d
 jge next1
 jmp else1
 next1:
  mov AX, 0x0000
  mov DX, 0x0000
  mov AX, [numero]
  mov CX, 10d
  div CX
  and ax, 0x001111
  ;and dx, 0x000011
  mov [numero1], ax
  mov [numero2], dx

  mov EDX, 0
  mov EBX, [numero]
  cmp BX, 99d
  jg otronumero
  jmp continuar
 else1:
  mov ax, 0x0
  mov [numero1], ax
  mov ax, [numero]
  mov [numero2], ax
jmp continuar

otronumero: 
mov AX, 0x0000
mov DX, 0x0000
mov AX, [numero]
mov CX, 100d
div CX
and ax, 0x001111
mov [numero3], ax
jmp continuar


es_feliz:
mov eax, SYS_WRITE
mov ebx, STDOUT
mov ecx, msj_feliz
mov edx, tam_feliz
int 0x80
jmp salida;

noes_feliz:
mov eax, SYS_WRITE
mov ebx, STDOUT
mov ecx, msj_infeliz
mov edx, tam_infeliz
int 0x80
jmp salida;

salida:
mov eax, SYS_EXIT
xor ebx, ebx  ;EBX=0 INDICA EL CODIGO DE RETORNO (0=SIN ERRORES)
int 0x80

