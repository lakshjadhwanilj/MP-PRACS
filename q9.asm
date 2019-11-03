Data Segment
	msg1 db 10,13, "**MAIN MENU** $"
	msg2 db 10,13, "1. Multiply $"
	msg3 db 10,13, "2. Divide $"
	msg4 db 10,13, "3. Exit $"
	msg5 db 10,13, "Enter Your Choice: $"
	choice db ?
	msg6 db 10,13, "Enter First Number: $"
	num1 db ?
	msg7 db 10,13, "Enter Second Number: $"
	num2 db ?
	msg8 db 10,13, "Product of Numbers is: $"
	product dw ?
	msg9 db 10,13, "Quotient of Numbers is: $"
	quo db ?
	msg10 db 10,13, "Remainder of Numbers is: $"
	rem db ?
Data Ends
Code Segment
	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax
		
		labelMenu:

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

			mov dx, offset msg5
			mov ah, 09h
			int 21h

			mov ah, 01h
			int 21h
			Call input
			mov choice, al
			mov bl, al

			cmp bl, 03h
			jnz labelChoice
			mov ah, 4ch
			int 21h

			labelChoice:

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

				mov num1, bl

				mov dx, offset msg7
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

				mov bl, choice
				cmp bl, 01h
				jnz labelDiv

				mov dx, offset msg8
				mov ah, 09h
				int 21h

				mov ax, 0000h
				mov al, num1
				mov bl, num2
				MUL bl

				mov bx, ax
				mov product, bx

				and bx, 0f000h
				ror bx, 12
				Call output

				mov bx, product
				and bx, 0f00h
				ror bx, 8
				Call output

				mov bx, product
				and bx, 0f0h
				ror bx, 4
				Call output

				mov bx, product
				and bx, 0fh				
				Call output

				jmp labelMenu

				labelDiv:

					mov ax, 0000h
					mov al, num1
					mov bl, num2
					DIV bl

					mov quo, al
					mov rem, ah

					mov dx, offset msg9					; printing quotient
					mov ah, 09h
					int 21h

					mov bl, quo
					and bl, 0f0h
					ror bl, 04h
					Call output

					mov bl, quo
					and bl, 0fh
					Call output

					mov dx, offset msg10				; printing remainder
					mov ah, 09h
					int 21h

					mov bl, rem
					and bl, 0f0h
					ror bl, 04h
					Call output

					mov bl, rem
					and bl, 0fh
					Call output

					jmp labelMenu

		input proc
			cmp al, 41h
			jc labelIn
			sub al, 07h

			labelIn:
				sub al, 30h

			ret
			endp

		output proc
			cmp bl, 0ah
			jc labelOut
			add bl, 07h

			labelOut:
				add bl, 30h

			mov dl, bl
			mov ah, 02h
			int 21h

			ret
			endp

Code Ends
	end start