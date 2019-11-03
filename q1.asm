Data Segment
	msg db 10,13, "** MAIN MENU ** $"
	msg1 db 10,13, "1. Addition $"
	msg2 db 10,13, "2. Subtraction $"
	msg3 db 10,13, "3. Exit $"
	msg4 db 10,13, "Enter Your Choice: $"
	choice db ?
	msg5 db 10,13, "Enter First Number: $"
	num1 db ?
	msg6 db 10,13, "Enter Second Number: $"
	num2 db ?
	msg7 db 10,13, "Addition is: $"
	msg8 db 10,13, "Subtraction is: $"
	result db ?
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
				jnz Subtract

				mov bl, num1
				mov cl, num2

				add bl, cl
				mov result, bl

				mov dx, offset msg7
				mov ah, 09h
				int 21h

				mov bl, result
				and bl, 0f0h
				ror bl, 04h
				Call output

				mov bl, result
				and bl, 0fh
				Call output

				jmp Menu

				Subtract:

					mov bl, num1
					mov cl, num2

					sub bl, cl
					mov result, bl

					mov dx, offset msg8
					mov ah, 09h
					int 21h

					mov bl, result
					and bl, 0f0h
					ror bl, 04h
					Call output

					mov bl, result
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
