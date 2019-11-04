#include<stdio.h>
#include<conio.h>
void main()
{
	int i,len,num,sum, avg;
	clrscr();
	printf("Enter Size of Array: ");
	scanf("%d",&len);
	min=0;
	asm mov si, 1000h
	for(i=0; i<len; i++)
	{
		printf("Enter Element: ");
		scanf("%d",&num);
		asm mov ax, num
		asm mov [si], ax
		asm inc si
		asm inc si
	}
	asm mov si, 1000h
	asm mov bx, [si]
	asm mov cx, 0000h
	asm mov cx, len
	asm dec cx
	asm inc si
	asm inc si
	labelloop:
		
		asm add bx, [si]
		
		asm inc si
		asm inc si
		asm loop labelloop
	asm mov sum, bx
	asm mov ax, sum
	asm mov bx, len
	asm DIV bx
	asm mov avg, ax
	printf("Average is: %d", avg);
	getch();
}