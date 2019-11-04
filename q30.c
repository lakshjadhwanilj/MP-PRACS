#include<stdio.h>
#include<conio.h>
void main()
{
	int i,size,num,choice;
	clrscr();
	do
	{
		printf("Enter Cursor Size: ");
		scanf("%d",&size);
		printf("**MENU**\n");
		printf("1. Increase Cursor Size\n2. Decrease Cursor Size\n3. Exit\n");
		printf("Enter Choice:\n");
		scanf("%d",&choice);
		switch(choice)
		{
			case 1:
					asm mov cx, size
					asm mov ah, 01h
					asm inc cl
					asm int 10h
					getch();
					break;
			case 2:
					asm mov cx, size
					asm mov ah, 01h
					asm dec cl
					asm int 10h
					getch();
					break;
			case 3:
					break;
		}
	}while(choice!=3);
}