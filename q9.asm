Data Segment
	msg db 10,13, "** MAIN MENU ** $"
	msg1 db 10,13, "1. Multiply $"
	msg2 db 10,13, "2. Divide $"
	msg3 db 10,13, "3. Exit $"
	msg4 db 10,13, "Enter Your Choice: $"
	choice db ?
	msg5 db 10,13, "Enter First Number: $"
	num1 db ?
	msg6 db 10,13, "Enter Second Number: $"
	num2 db ?
	msg7 db 10,13, "Product is: $"
	product dw ?
	msg8 db 10,13, "Quotient is: $"
	quo db ?
	msg9 db 10,13, "Remainder is: $"
	rem db ?
Data Ends
Code Segment

	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax

		Menu:

			mov dx, offset msg
			mov ah, 09h
			int 21h

			mov dx, offset msg1
			mov ah, 09h
			int 21h

			mov dx, offset msg2
			mov ah, 09h
			int 21h

			mov dx, offset msg3
			mov ah, 09h
			int 21h

			mov dx, offset msg4
			mov ah, 09h
			int 21h

			mov ah, 01h
			int 21h
			Call input
			mov choice, al

			cmp choice, 03h
			jnz Option

			mov ah, 4ch
			int 21h

			Option:

				mov dx, offset msg5
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

				mov dx, offset msg6
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

				cmp choice, 01h
				jnz Divide

				mov bl, num1
				mov al, num2

				MUL bl
				mov product, ax

				mov dx, offset msg7
				mov ah, 09h
				int 21h

				mov bx, product
				and bx, 0f000h
				ror bx, 0ch
				Call output

				mov bx, product
				and bx, 00f00h
				ror bx, 08h
				Call output

				mov bx, product
				and bx, 000f0h
				ror bx, 04h
				Call output

				mov bx, product
				and bx, 0000fh
				Call output

				jmp Menu

				Divide:

					mov ah, 00h
					mov al, num1
					mov bl, num2

					DIV bl
					mov quo, al
					mov rem, ah

					mov dx, offset msg8
					mov ah, 09h
					int 21h

					mov bl, quo
					and bl, 0f0h
					ror bl, 04h
					Call output

					mov bl, quo
					and bl, 0fh
					Call output

					mov dx, offset msg9
					mov ah, 09h
					int 21h

					mov bl, rem
					and bl, 0f0h
					ror bl, 04h
					Call output

					mov bl, rem
					and bl, 0fh
					Call output

					jmp Menu

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
