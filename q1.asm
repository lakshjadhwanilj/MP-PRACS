Data Segment
	msg1 db 10,13, "Main Menu: $"
	msg2 db 10,13, "1. Addition $"
	msg3 db 10,13, "2. Subtraction $"
	msg4 db 10,13, "3. Exit $"
	msg5 db 10,13, "Enter your choice: $"
	choice db ?
	msg6 db 10,13, "Enter First Number: $"
	num1 db ?
	msg7 db 10,13, "Enter Second Number: $"
	num2 db ?
	msg8 db 10, 13, "Addition is: $"
	msg9 db 10,13, "Subtraction is $"
	res db ?
Data Ends
Code Segment
	Assume CS: Code, DS: Data

	start:
		mov ax, data
		mov ds, ax

		loopMenu:
			
			; Printing msgs

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

			cmp al, 03h      			 ; compare with exit case
			jnz labelChoice  			 ; jump to labelChoice if al - 03h != 0
			mov ah, 4ch
			int 21h

			labelChoice:

				; taking 2 inputs

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

				mov dx, offset msg7
				mov ah, 09h
				int 21h

				mov ah, 01h
				int 21h
				Call input
				mov cl, al
				rol cl, 04h

				mov ah, 01h
				int 21h
				Call input
				add cl, al

				cmp choice, 01h		          ; check if choice is 1
				jnz labelSub				  ; if not 0 then choice is 2

				add bl, cl 					  ; Addition
				mov res, bl

				mov dx, offset msg8
				mov ah, 09h
				int 21h

				and bl, 0f0h				; Anything ANDed with 1 gives the same result for printing higher digit
				ror bl, 04h
				Call output

				mov bl, res
				and bl, 0fh
				Call output

				jmp loopMenu

				labelSub:
					sub bl, cl 				; Subtraction
					mov res, bl

					mov dx, offset msg9
					mov ah, 09h
					int 21h

					and bl, 0f0h
					ror bl, 04h
					Call output

					mov bl, res
					and bl, 0fh
					Call output

					jmp loopMenu

		input proc
			cmp al, 41h
			jc labelInp		  				; carry or borrow will be generated when al < 41h
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