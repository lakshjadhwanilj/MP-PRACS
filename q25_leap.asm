; I have divided only the last 2 digits by 4 as they are sufficient to tell if a year is leap or not
; It doesnt work for certain values but you can't do anything 🤷‍♂️
Data Segment
	msg1 db 10,13, "Enter Year: $"
	year dw ?
	msg2 db 10,13, "It is a Leap Year: $"
	msg3 db 10,13, "It is Not a Leap Year: $"
Data Ends
Code Segment

	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax

		mov dx, offset msg1
		mov ah, 09h
		int 21h

		mov ah, 01h					; taking 1st digit
		int 21h
		Call input
		mov ah, 00h
		rol ax, 12
		mov bx, ax

		mov ah, 01h					; taking 2nd digit
		int 21h
		Call input
		mov ah, 00h
		rol ax, 8
		add bx, ax

		mov ah, 01h					; taking 3rd digit
		int 21h
		Call input
		mov ah, 00h
		rol ax, 4
		add bx, ax

		mov ah, 01h					; taking 4th digit
		int 21h
		Call input
		mov ah, 00h
		add bx, ax

		mov year, bx

		mov ax, 0000H
		mov al, bl

		;Divide4:

			mov bl, 04h
			DIV bl					; bl is the divisor
			mov bl, ah				; storing remainder in bl

			cmp bl, 00h				; check divisiblity by 4
			jz Leap

			mov dx, offset msg3
			mov ah, 09h
			int 21h
			jmp Exit

		Leap:

			mov dx, offset msg2
			mov ah, 09h
			int 21h

		Exit:
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
