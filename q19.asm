; I have taken 1 32 bit number as 2 16 bit numbers and then performed addition 😪
; The lower bits addition are normal using ADD while in upper bits addition I used ADC

Data Segment
	msg0 db 10,13, "** 32 BIT ADDITION-SUBTRACTION ** $"
	msg db 10,13, "** MAIN MENU ** $"
	msg1 db 10,13, "1. Addition $"
	msg2 db 10,13, "2. Subtraction $"
	msg3 db 10,13, "3. Exit $"
	msg4 db 10,13, "Enter Your Choice: $"
	choice db ?
	msg5 db 10,13, "Enter First Number: $"
	num1a dw ?
	num1b dw ?
	msg6 db 10,13, "Enter Second Number: $"
	num2a dw ?
	num2b dw ?
	msg7 db 10,13, "Addition is: $"
	msg8 db 10,13, "Subtraction is: $"
	res1 dw ?
	res2 dw ?
	result dw ?
Data Ends
Code Segment

	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax

		Menu:

			mov dx, offset msg0
			mov ah, 09h
			int 21h

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

			mov ah, 01h 						; taking choice
			int 21h
			Call input
			mov choice, al

			cmp choice, 03h
			jnz Option

			mov ah, 4ch
			int 21h

			Option:

				mov dx, offset msg5 			; taking 1st number
				mov ah, 09h
				int 21h

				Call ip 						; taking first 16 bits of num1
				mov num1a, bx

				Call ip 						; taking last 16 bits of num1
				mov num1b, bx

				mov dx, offset msg6 			; taking 2nd number
				mov ah, 09h
				int 21h

				Call ip 						; taking first 16 bits of num2
				mov num2a, bx

				Call ip 						; taking last 16 bits of num2
				mov num2b, bx

				cmp choice, 01h
				jnz Subtract
												; adding the lower bits
				mov bx, num1b
				mov cx, num2b

				ADD bx,cx
				mov res1, bx
												; adding the upper bits
				mov bx, num1a
				mov cx, num2a

				ADC bx,cx
				mov res2, bx

				mov dx, offset msg7
				mov ah, 09h
				int 21h

				mov bx, res2 					; printing the upper bits
				Call op

				mov bx, res1 					; printing the lower bits
				Call op

				jmp Menu

				Subtract:
													; subtracting the lower bits
					mov bx, num1b
					mov cx, num2b

					SUB bx,cx
					mov res1, bx
													; subtracting the upper bits
					mov bx, num1a
					mov cx, num2a

					SBB bx,cx
					mov res2, bx

					mov dx, offset msg7
					mov ah, 09h
					int 21h

					mov bx, res2 					; printing the upper bits
					Call op

					mov bx, res1 					; printing the lower bits
					Call op

					jmp Menu

		ip proc
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

			ret
			endp

		op proc
			mov result, bx 
			and bx, 0f000h
			ror bx, 0ch
			Call output

			mov bx, result
			and bx, 00f00h
			ror bx, 08h
			Call output

				mov bx, result
				and bx, 000f0h
				ror bx, 04h
				Call output

				mov bx, result
				and bx, 0000fh
				Call output

			ret
			endp

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
