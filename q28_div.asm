Data Segment
	msg db 10,13, "Division Without Instruction $"
	msg1 db 10,13, "Enter Dividend: $"
	num1 db ?
	msg2 db 10,13, "Enter Divisor: $"
	num2 db ?
	msg3 db 10,13, "Quotient is: $"
	quo db ?
	msg4 db 10,13, "Remainder is: $"
	rem db ?
Data Ends
Code Segment

	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax

		mov dx, offset msg
		mov ah, 09h
		int 21h

		mov dx, offset msg1
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

		mov dx, offset msg2
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

		mov ax, 0000h
		mov al, num1
		mov bx, 0000h
		mov bl, num2
		mov cl, 00h
		
		Subtraction:

			sub al, bl
			inc cl
			cmp al, num2
			jnc Subtraction


		mov bl, al 						; priniting remainder
		mov rem, bl
		
		mov dx, offset msg4
		mov ah, 09h
		int 21h

		and bl, 0f0h
		ror bl, 04h
		Call output

		mov bl, rem
		and bl, 0fh
		Call output


		mov bl, cl 						; priniting quotient
		mov quo, bl
		
		mov dx, offset msg3
		mov ah, 09h
		int 21h

		and bl, 0f0h
		ror bl, 04h
		Call output

		mov bl, quo
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