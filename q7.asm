Data Segment
	msg1 db 10,13, "**MAIN MENU** $"
	msg2 db 10,13, "1. Addition $"
	msg3 db 10,13, "2. Subtraction $"
	msg4 db 10,13, "3. Exit $"
	msg5 db 10,13, "Enter your choice $"
	choice db ?
	msg6 db 10,13, "Enter First Number: $"
	num1 dw ?
	msg7 db 10,13, "Enter Second Number: $"
	num2 dw ?
	msg8 db 10,13, "Addition is: $"
	msg9 db 10,13, "Subtraction is: $"
	res dw ?
Data Ends
Code Segment
	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax

		loopMenu:

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

			; taking choice

			mov ah, 01h
			int 21h
			Call input
			mov choice, al

			cmp al, 03h						; compare with exit case
			jnz labelChoice
			mov ah, 4ch
			int 21h

			labelChoice:

				mov dx, offset msg6
				mov ah, 09h
				int 21h

				; taking 1st input

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

				mov num1, bx

				mov dx, offset msg7
				mov ah, 09h
				int 21h

				; taking 2nd input

				mov ah, 01h					; taking 1st digit
				int 21h
				Call input
				mov ah, 00h
				rol ax, 12
				mov cx, ax

				mov ah, 01h					; taking 2nd digit
				int 21h
				Call input
				mov ah, 00h
				rol ax, 8
				add cx, ax

				mov ah, 01h					; taking 3rd digit
				int 21h
				Call input
				mov ah, 00h
				rol ax, 4
				add cx, ax

				mov ah, 01h					; taking 4th digit
				int 21h
				Call input
				mov ah, 00h
				add cx, ax

				cmp choice, 01h
				jnz labelSub				; check if addition or subtraction choice is made
				
				add bx, cx
				mov res, bx

				mov dx, offset msg8
				mov ah, 09h
				int 21h

				; displaying output

				and bx, 0f000h
				ror bx, 0ch
				Call output

				mov bx, res
				and bx, 00f00h
				ror bx, 08h
				Call output

				mov bx, res
				and bx, 000f0h
				ror bx, 04h
				Call output

				mov bx, res
				and bx, 0000fh
				Call output

				jmp loopMenu

				labelSub:
					sub bx, cx
					mov res, bx

					mov dx, offset msg9
					mov ah, 09h
					int 21h

					; dsplaying output

					and bx, 0f000h
					ror bx, 0ch
					Call output

					mov bx, res
					and bx, 00f00h
					ror bx, 08h
					Call output

					mov bx, res
					and bx, 000f0h
					ror bx, 04h
					Call output

					mov bx, res
					and bx, 0000fh
					Call output

					jmp loopMenu

		input proc
			cmp al, 41h
			jc labelInp
			sub al, 07h

			labelInp:
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
