; Program works for 8 bit numbers
Data Segment
	msg1 db 10,13, "Enter Number: $"
	num db ?
	msg2 db 10,13, "Two's Complement is: $"
	com db ?
Data Ends
Code Segment

	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax

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

		mov num, bl

		mov ax, 0000h					; for precaution
		mov al, num
		NOT al							; complementing the register
		adc al, 01h						; adding 1 to the complement
		mov bl, al

		mov com, bl

		mov dx, offset msg2
		mov ah, 09h
		int 21h

		and bl, 0f0h
		ror bl, 04h
		Call output

		mov bl, com
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