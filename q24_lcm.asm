Data Segment
	msg1 db 10,13, "Enter First Number: $"
	num1 db ?
	msg2 db 10,13, "Enter Second Number: $"
	num2 db ?
	msg3 db 10,13, "LCM is: $"
	lcm db ?
Data Ends
Code Segment

	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax

		mov dx, offset msg1					; taking 1st input
		mov ah, 09h
		int 21h

		mov ah, 01h
		int 21h
		Call input
		mov bl, al
		rol bl, 04h

		mov ah, 01h
		int 21h
		Call input
		add bl, al

		mov num1, bl

		mov dx, offset msg2					; taking 2nd input
		mov ah, 09h
		int 21h

		mov ah, 01h
		int 21h
		Call input
		mov bl, al
		rol bl, 04h

		mov ah, 01h
		int 21h
		Call input
		add bl, al

		mov num2, bl

		mov cl, num1
		cmp bl, cl
		jz Equal
		jnc B

		C:
			sub cl, bl
			cmp bl, cl
			jz Equal
			jc C

		B:
			sub bl, cl
			cmp bl, cl
			jz Equal
			jnc B
			jc C

		Equal:

			mov cl, bl

			mov ah, 00h
			mov al, num1
			mov bl, num2

			MUL bl								; ax = al * bl

			DIV cl 								; quo in al = ax / cl

			mov bl, al 							; storing quotient (LCM) in bl
			mov lcm, bl

			mov dx, offset msg3					; printing op
			mov ah, 09h
			int 21h

			and bl, 0f0h
			ror bl, 04h
			Call output

			mov bl, lcm
			and bl, 0fh
			Call output

		mov ah, 4ch
		int 21h	

		input proc
			cmp al, 41h
			jc Inp
			sub al, 07h

			Inp:
				sub al, 30h

			ret
			endp

		output proc
			cmp bl, 0ah
			jc Outp
			add bl, 07h

			Outp:
				add bl, 30h

			mov dl, bl
			mov ah, 02h
			int 21h

			ret
			endp
Code Ends
	end start