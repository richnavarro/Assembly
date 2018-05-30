TITLE Navarro_P6_1 (Navarro_P6_1.asm)		;title

INCLUDE Irvine32.inc   ;includes the goods that Irvine created

.data			;data
NL equ <0DH, 0AH, 0>  ;new line symbolic constant
headerStr BYTE "Richard Navarro - CS340 - Project 6 - Problem #1 ", NL  ;header
newLineStr BYTE nl

a1 DWORD 2, 5, 1, 8, 3 ; avg = 3
a2 DWORD 38, 29, 23, 993 ; avg = 270
a3 DWORD 13, 14, 15 ; avg = 14
a4 DWORD 0, 0, 0, 0, 0, 0, 0, 8 ; avg = 1

average DWORD ?

.CODE		;code
avg  PROTO arrayStart : DWORD, len : DWORD, avgRet : PTR DWORD

main PROC
	; header
	mov edx, Offset headerStr
	call writeString
	push 340											; as the instructions indicate
	s
	INVOKE avg, OFFSET a1, Lengthof a1, addr average	; test case numero 1
	mov eax, average									; moves average into EAX
	call writeInt										; prints out
	call crlf											; new line

	INVOKE avg, OFFSET a2, Lengthof a2, addr average	; test case numero 2
	mov eax, average									; moves average into EAX
	call writeInt										; prints out
	call crlf											; new line

	INVOKE avg, OFFSET a3, Lengthof a3, addr average	; test case numero 3
	mov eax, average									; moves average into EAX
	call writeInt										; prints out
	call crlf											; new line

	INVOKE avg, OFFSET a4, Lengthof a4, addr average	; test case numero 4
	mov eax, average									; moves average into EAX
	call writeInt										; prints out
	call crlf											; new line

	pop eax					; as the instructions indicate
	call writeint			; as the instrucitons indicate
	call crlf				; as the instructions indicate
	exit
main ENDP
;
;
;
;
AVG  PROC arrayStart : DWORD, len : DWORD, avgRet : PTR DWORD
	LOCAL sum : dword  ; all locals must be at the tippy top

	;inits
	mov ecx, len		
	mov esi, arrayStart
	mov sum, 0

	; start the loop
	L1:
		mov eax, [esi]			; gets element value
		add sum, eax			; adds value to running total
		add esi, 4				; goes to next element
	loop L1

	; return number of evens into global variable
	mov eax, sum				; move local sum inot eax
	mov edx, 0					; clear edx for division
	div len						; divide by number of elements,  result in EAX
	mov esi, avgRet				; move addres of global into esi
	mov [esi], eax				; move sum (eax) into global variable avgRet
	ret
AVG ENDP
END main