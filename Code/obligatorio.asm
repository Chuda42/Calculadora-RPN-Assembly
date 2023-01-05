.data  ; Segmento de datos
	ENTRADA equ 10
	PUERTO_LOG_DEFECTO equ 2
	SALIDA equ 1
	MAX_OPERADORES equ 62; son 31 elementos maximo en la pila pero se representan con 64 bytes en la memoria

	C_NUM equ 1
	C_PORT equ 2
	C_LOG equ 3
	C_TOP equ 4
	C_DUMP equ 5
	C_DUP equ 6
	C_SWAP equ 7
	C_NEG equ 8
	C_FACT equ 9
	C_SUM equ 10
	C_SUMA equ 11
	C_RESTA equ 12
	C_MULT equ 13
	C_DIV equ 14
	C_MOD equ 15
	C_AND equ 16
	C_OR equ 17
	C_SAL equ 18
	C_SAR equ 19
	C_CLS equ 254
	C_HALT equ 255

.code  ; Segmento de código
	;Inicializo la pila en ES, y en la posicion cero de la misma 
	mov BX, 0x2000
	mov ES, BX ;Voy a guardar mi stack en ES
	mov byte ptr ES:[0], 0;En le primer byte del segmento guardo mi tope
	
	;Desplazo el segmento DS para utilizarlo y guardar cosas
	mov BX, 0X4000
	mov DS, BX
	
	;guardo el valor de los puertos en el segmento ds
	mov byte ptr DS:[0], PUERTO_LOG_DEFECTO
	mov byte ptr DS:[2], SALIDA
	;guardo el valor de la bandera que me indica si tengo que seguir leyendo de la entrada
	mov byte ptr DS:[4], 0X1
	
	procesar:
		CMP byte ptr DS:[4], 0X0
		JZ finProcesar
		;Leo la entrada
		in AX, ENTRADA
		;Guardo el comando leido en CX
		mov CX, AX
		;Imprimo en la bitacora el 0 mas el comando enviado en la entrada
		mov DX, DS:[0]; busco en memoria el valor del puerto de la bitacora
		xor AX, AX
		out DX, AX
		mov AX, CX
		out DX, AX
		
		;if comando == 1, es decir CX igual a 1
		cmp CX, 0x1
		jz comando1
		;if comando == 2, es decir CX igual a 2
		cmp CX, 0x2
		jz comando2
		;if comando == 3, es decir CX igual a 3
		cmp CX, 0x3
		jz comando3
		;if comando == 4, es decir CX igual a 4
		cmp CX, 0x4
		jz comando4
		;if comando == 5, es decir CX igual a 5
		cmp CX, 0x5
		jz comando5
		;if comando == 6, es decir CX igual a 6
		cmp CX, 0x6
		jz comando6
		;if comando == 7, es decir CX igual a 7
		cmp CX, 0x7
		jz comando7
		;if comando == 8, es decir CX igual a 8
		cmp CX, 0x8
		jz comando8
		;if comando == 9, es decir CX igual a 9
		cmp CX, 0x9
		jz comando9
		;if comando == 10, es decir CX igual a 10
		cmp CX, 0xA
		jz comando10
		;if comando == 11, es decir CX igual a 11
		cmp CX, 0xB
		jz comando11
		;if comando == 12, es decir CX igual a 12
		cmp CX, 0xC
		jz comando12
		;if comando == 13, es decir CX igual a 13
		cmp CX, 0xD
		jz comando13
		;if comando == 14, es decir CX igual a 14
		cmp CX, 0xE
		jz comando14
		;if comando == 15, es decir CX igual a 15
		cmp CX, 0xF
		jz comando15
		;if comando == 16, es decir CX igual a 16
		cmp CX, 0x10
		jz comando16
		;if comando == 17, es decir CX igual a 17
		cmp CX, 0x11
		jz comando17
		;if comando == 18, es decir CX igual a 18
		cmp CX, 0x12
		jz comando18
		;if comando == 19, es decir CX igual a 19
		cmp CX, 0x13
		jz comando19
		;if comando == 254, es decir CX igual a 254
		cmp CX, 0xFE
		jz comando254
		;if comando == 255, es decir CX igual a 255
		cmp CX, 0xFF
		jz comando255
		
		jmp retornarCodigoBitacora2

	comando1:
		;leo el parametro de la entrada
		in AX, ENTRADA
		mov DX, DS:[0]; busco en memoria el valor del puerto de la bitacora
		out DX, AX
		;busco el tope de mi pila
		mov SI, ES:[0]
		cmp SI, MAX_OPERADORES
		jz retornarCodigoBitacora4
		;incremento el tope en dos, porque la memoria va de a dos bytes
		inc SI
		inc SI
		mov ES:[0], SI
		mov ES:[SI], AX
		jmp retornarCodigoBitacora16

	comando2:
		;leo la entrada que tiene el parametro
		in AX, ENTRADA
		;busco el canal de la bitacora e imprimo lo correspondiente
		mov DX, DS:[0]
		OUT DX, AX
		;cambio el canal SALIDA por el que me mandan como parametro
		mov DS:[2], AX
		;confirmo por bitacora
		jmp retornarCodigoBitacora16

	comando3:
		;leo la entrada que tiene el parametro
		in AX, ENTRADA
		;busco el canal de la bitacora e imprimo lo correspondiente
		mov DX, DS:[0]
		out DX, AX
		;cambio el canal de la bitacora por el que me mandan como parametro
		mov DS:[0], AX
		;confirmo por bitacora
		jmp retornarCodigoBitacora16
	
	comando4:
		;busco el tope de mi pila
		mov SI, ES:[0]
		;chequeo si esta vacio el tope
		cmp SI, 0x0
		jz retornarCodigoBitacora8
		;busco el canal de salida
		mov DX, DS:[2]
		;pongo en ax el valor de mi pila en el tope
		mov AX, ES:[SI]
		;imprimo		
		out DX, AX
		jmp retornarCodigoBitacora16

	comando5:
		;busco el tope de mi pila
		mov SI, ES:[0]
		;chequeo si esta vacio el tope
		cmp SI, 0x0
		jz finWhile5
		;busco el canal de salida
		mov DX, DS:[2]
		;pongo en si el valor del tope de mi pila
		mov SI, ES:[0]
		while5:	
			mov AX, ES:[SI]
			out DX, AX
			dec SI
			dec SI
			cmp SI, 0x0
			jz finWhile5
			jmp while5
		finWhile5:
			jmp retornarCodigoBitacora16
					

	comando6:
		;busco el tope de mi pila
		mov SI, ES:[0]
		;chequeo si esta vacio el tope
		cmp SI, 0x0
		jz retornarCodigoBitacora8
		;Si no me da para ingresar nada mas a la pila
		cmp SI, MAX_OPERADORES
		jz retornarCodigoBitacora4 
		mov AX, ES:[SI]
		inc SI
		inc SI
		mov ES:[0], SI
		mov ES:[SI], AX
		jmp retornarCodigoBitacora16
		
	comando7:
		;si tengo menos de dos elementos en la pila retorno bitacora 8
		cmp byte ptr ES:[0], 0x4
		jb	insuficientesOperadoresOperacionBinaria
		mov SI, ES:[0]
		mov AX, ES:[SI]
		mov BX, ES:[SI -2]
		mov ES:[SI], BX
		mov ES:[SI -2], AX
		jmp retornarCodigoBitacora16

	comando8:
		;busco el tope de mi pila
		mov SI, ES:[0]
		;chequeo si esta vacio el tope
		cmp SI, 0x0
		jz retornarCodigoBitacora8
		neg word ptr ES:[SI]
		jmp retornarCodigoBitacora16
		
	comando9:
		;busco el tope de mi pila
		mov SI, ES:[0]
		;chequeo que este vacia y si lo esta retorno codigo 8 en bitacora
		cmp SI, 0X0
		jz retornarCodigoBitacora8
		;si no esta vacia pusheo el tope y llamo a fact la rutina recursiva
		push ES:[SI]
		call fact
		;pongo el resultado de fact en el tope de la pila
		pop ES:[SI]
		jmp retornarCodigoBitacora16
	
	comando10:
		mov SI, ES:[0]
		xor AX, AX
		;si no hay elementos en la pila que salte a agregar el cero
		cmp SI, 0X0
		jz finWhile10
		while10:
			add AX, ES:[SI]
			dec SI
			dec SI
			cmp SI, 0x0
			jz finWhile10
			jmp while10
		finWhile10:
			mov ES:[2], AX
			mov word ptr ES:[0], 2
			jmp retornarCodigoBitacora16
		

	comando11:; suma dos elementos
		;si tengo menos de dos elementos retrono bitacora 8, si es un solo elemento lo elimino ademas
		cmp byte ptr ES:[0], 0x4
		jb  insuficientesOperadoresOperacionBinaria
		mov SI, ES:[0]
		mov AX, ES:[SI]
		dec SI
		dec SI
		add ES:[SI], AX
		mov ES:[0], SI
		jmp retornarCodigoBitacora16

	comando12:; resta dos elementos
		;si tengo menos de dos elementos en la pila retorno bitacora 8
		cmp byte ptr ES:[0], 0x4
		jb 	insuficientesOperadoresOperacionBinaria
		mov SI, ES:[0]
		mov AX, ES:[SI]
		dec SI
		dec SI
		sub ES:[SI], AX
		mov ES:[0], SI
		jmp retornarCodigoBitacora16

	comando13:; multiplica dos elementos
		;si tengo menos de dos elementos en la pila retorno bitacora 8
		cmp byte ptr ES:[0], 0x4
		jb 	insuficientesOperadoresOperacionBinaria
		mov SI, ES:[0]
		mov AX, ES:[SI]
		dec SI
		dec SI
		xor DX, DX; la mul necesita que el que se multiplica sea de 32 bits por eso agarra tambien el dx lo pongo en 0
		mul word ptr ES:[SI]
		mov ES:[SI], AX
		mov ES:[0], SI
		jmp retornarCodigoBitacora16

	comando14:; divide dos elementos
		;si tengo menos de dos elementos en la pila retorno bitacora 8
		cmp byte ptr ES:[0], 0x4
		jb 	insuficientesOperadoresOperacionBinaria
		mov SI, ES:[0]
		mov AX, ES:[SI - 2]
		cmp AX, 0x8000
		jae setearDivNegativo
		xor DX, DX; si no es negativo pongo el dx en 0
		hacerDiv:
			dec SI
			dec SI
			idiv word ptr ES:[SI + 2]
			mov ES:[SI], AX
			mov ES:[0], SI
			jmp retornarCodigoBitacora16

		setearDivNegativo:
			mov DX, 0xFFFF
			jmp hacerDiv
		
	comando15:; modulo
		;si tengo menos de dos elementos en la pila retorno bitacora 8
		cmp byte ptr ES:[0], 0x4
		jb 	insuficientesOperadoresOperacionBinaria
		mov SI, ES:[0]
		mov AX, ES:[SI - 2]
		cmp AX, 0x8000
		jae setearModNegativo
		xor DX, DX; si no es negativo pongo el dx en 0
		hacerMod:
			dec SI
			dec SI
			idiv word ptr ES:[SI + 2]
			mov ES:[SI], DX
			mov ES:[0], SI
			jmp retornarCodigoBitacora16

		setearModNegativo:
			mov DX, 0xFFFF
			jmp hacerMod

	comando16:; and bit a bit
		;si tengo menos de dos elementos en la pila retorno bitacora 8
		cmp byte ptr ES:[0], 0x4
		jb 	insuficientesOperadoresOperacionBinaria
		mov SI, ES:[0]
		mov AX, ES:[SI]
		dec SI
		dec SI
		and ES:[SI], AX
		mov ES:[0], SI
		jmp retornarCodigoBitacora16

	comando17:; or bit a bit
		;si tengo menos de dos elementos en la pila retorno bitacora 8
		cmp byte ptr ES:[0], 0x4
		jb 	insuficientesOperadoresOperacionBinaria
		mov SI, ES:[0]
		mov AX, ES:[SI]
		dec SI
		dec SI
		or ES:[SI], AX
		mov ES:[0], SI
		jmp retornarCodigoBitacora16

	comando18:; shift izq
		;si tengo menos de dos elementos en la pila retorno bitacora 8
		cmp byte ptr ES:[0], 0x4
		jb 	insuficientesOperadoresOperacionBinaria
		mov SI, ES:[0]
		mov AX, ES:[SI]
		dec SI
		dec SI
		cmp AX, 0x10
		jae shiftIzqMas16
		mov CL, AL
		shl word ptr ES:[SI], CL
		mov ES:[0], SI
		jmp retornarCodigoBitacora16
		shiftIzqMas16:
			mov word ptr ES:[SI], 0x0
			mov ES:[0], SI
			jmp retornarCodigoBitacora16

	comando19:; shift der
		;si tengo menos de dos elementos en la pila retorno bitacora 8
		cmp byte ptr ES:[0], 0x4
		jb 	insuficientesOperadoresOperacionBinaria
		mov SI, ES:[0]
		mov AX, ES:[SI]
		dec SI
		dec SI
		cmp AX, 0x10
		jae shiftDerMas16
		mov CL, AL
		sar word ptr ES:[SI], CL
		mov ES:[0], SI
		jmp retornarCodigoBitacora16
		shiftDerMas16:
			mov CL, 0x11
			sar word ptr ES:[SI], CL
			mov ES:[0], SI
			jmp retornarCodigoBitacora16

	comando254:; clear
		mov word ptr ES:[0], 0X0
		jmp retornarCodigoBitacora16

	comando255:
		mov byte ptr DS:[4], 0X0
		jmp retornarCodigoBitacora16
		
	retornarCodigoBitacora2:
		xor DX, DX; limpio DX para dejar libre para poner el valor del canal puesto que DH puede no ser 0
		mov DX, DS:[0]; busco en memoria el valor del puerto de la bitacora
		mov AX, 0X2
		out DX, AX
		jmp procesar

	retornarCodigoBitacora4:
		xor DX, DX; limpio DX para dejar libre para poner el valor del canal puesto que DH puede no ser 0
		mov DX, DS:[0]; busco en memoria el valor del puerto de la bitacora
		mov AX, 0X4
		out DX, AX
		jmp procesar

	retornarCodigoBitacora8:
		xor DX, DX
		mov DX, DS:[0]; busco en memoria el valor del puerto de la bitacora
		mov AX, 0X8
		out DX, AX
		jmp procesar

	retornarCodigoBitacora16:
		xor DX, DX
		mov DX, DS:[0]; busco en memoria el valor del puerto de la bitacora
		mov AX, 0X10
		out DX, AX
		jmp procesar
	
	insuficientesOperadoresOperacionBinaria:
		mov word ptr ES:[0], 0X0
		jmp retornarCodigoBitacora8

	fact proc
		push BP
		push AX
		push BX
		push DX
		mov BP, SP
		mov AX, [BP + 0xA]
		
		;Paso base
		cmp AX, 0X0
		jz pasoBase
		cmp AX, 0x1
		jz pasoBase
		;Paso recursivo
		mov BX, AX
		dec BX
		push BX
		call fact
		pop BX
		; dx::ax = ax * bx
		mul BX
		mov [BP + 0xA], AX
		JMP finRec

		pasoBase:
			mov word ptr [BP + 0xA], 0x1
			jmp finRec	
		
		finRec:
			pop DX
			pop BX
			pop AX
			pop BP
			ret
	fact endp

	finProcesar:	
		jmp finProcesar
	

.ports ; Definicion de puertos
	ENTRADA: 255


.interrupts ; Manejadores de interrupciones
; Ejemplo interrupcion del timer
;!INT 8 1
;  iret
;!ENDINT
