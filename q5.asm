Data Segment
	msg1 db 10,13, "Enter Size of Array: $"
	len db ?
	msg2 db 10,13, "Enter Element: $"
	msg3 db 10,13, "Sum of all digits is: $"
	sum db ?
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
		mov len, al

		mov si, 1000h
		mov cl, len 					; since loop only uses cx register
		mov ch, 00h

		labelElement:
				
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

			mov [si], bl
			inc si

			loop labelElement

		mov si, 1000h					; pointer back to 1000h
		mov cl, len 					; value of cl again = len so as to calculate
		mov ch, 00h
		mov bl, [si]					; putting 1st value to bl

		labelSum:

			inc si
			mov al, [si]
			add bl, al

			loop labelSum

		mov sum, bl						; storing the sum in sum variable

		mov dx, offset msg3				; displaying msg
		mov ah, 09h
		int 21h

		mov bl, sum
		and bl, 0f0h					; displaying 1st digit of sum
		ror bl, 04h
		Call output

		mov bl, sum 					; displaying 2nd digit of sum
		and bl, 0fh
		Call output

		mov ah, 4ch						; terminating the program
		int 21h

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