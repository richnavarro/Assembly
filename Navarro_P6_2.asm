TITLE Navarro_P6_2 (Navarro_P6_2.asm)		;title

INCLUDE Irvine32.inc   ;includes the goods that Irvine created

.data			;data
NL equ <0DH, 0AH, 0>  ;new line symbolic constant
headerStr BYTE "Richard Navarro - CS340 - Project 6 - Problem #2 ", NL  ;header
newLineStr BYTE nl

str1 BYTE "Stack Parameters",0
str2 BYTE "----------------------------",0
str3 BYTE "Address = ",0
str4 BYTE "	; value = ",0

result DWORD ?

.code

	Sum PROTO param1:DWORD, param2:DWORD, return:PTR DWORD
	ShowParams PROTO count : DWORD

	; MAIN Procedure
	main PROC
	; header
	mov edx, Offset headerStr
	call writeString
	push 340					; pushing to show the pop at the end

	invoke Sum, 10, 3, ADDR result
	invoke Sum, 2, 5, ADDR result
	invoke Sum, 1, 6, ADDR result
	invoke Sum, 50, 0, ADDR result
	invoke Sum, 32, 52, ADDR result
	; Print out the sum
	mov eax, result
	Call WriteInt
	Call Crlf

	; Print out the Stack test
	pop eax								; here's the pop
	Call WriteInt
	Call Crlf

	exit
	main ENDP 
	
	; SUM Procedure
	Sum PROC USES ebx param1:DWORD, param2:DWORD, return:PTR DWORD
		LOCAL loc:DWORD

		INVOKE showParams, 3		;invoking to search for the value of 2 parameters.
		mov ebx, param1
		add ebx, param2
		mov loc, ebx
		;mov eax, loc
		
		mov esi, return
		mov edi, return
		mov [edi], ebx

		ret
	Sum ENDP

	ShowParams PROC count : DWORD
		mov edx, OFFSET str1			; initial strings
		call writeString
		call crlf

		mov edx, OFFSET str2			; initial strings
		call writeString
		call crlf

		mov ecx, count					; number of loop reps
		mov esi, 24						; constant offset
		L1:
			mov edx, OFFSET str3
			call writeString
			mov edx, ebp				; edx = ebp
			add edx, esi				; edx = ebp + esi
			mov eax, edx
			call writehex				; print ebp + esi
			mov edx, OFFSET str4		; value string
			call writeString			; print string
			mov eax, [ebp+esi]			; get value of ebp + esi
			call writeint				; print value
			call crlf
			add esi, 4					; get ready for next element
		loop L1
		call crlf
		ret
	ShowParams endp



END main
