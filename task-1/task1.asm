

section .text
	global sort

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list

sort:
	enter 0, 0
	;dau push la ebx pentru a nu modifica registrul
	push ebx
	;in ebx voi retine secventa de numere consecutive incepand cu 1
	mov ebx,1
	;in edx pun adresa vectorului ce trebuie sortat
	mov edx, [ebp + 12]
	;in ecx pun numarul de noduri
	mov  ecx, [ebp + 8]
	
;in acest label caut prin elementele vectorului numarul care este egal cu cel pus in ebx
egal_ebx:
	dec ecx
	mov esi,[edx +8*ecx]
	;iau cate un element din vector si il compar cu ebx
	cmp ebx,esi
	je retine_pozitie
	jmp egal_ebx


retine_pozitie:
	;retin adresa fiecarui numar gasit,punandu l pe stiva
	;pun pe stiva indicele la care se gaseste elementul pentru a l retine
	;cresc ebx pentru a cauta urmatorul numar
	;reiau in ecx numarul de noduri
	lea eax,[edx+8*ecx]
	push eax
	push ecx
	inc ebx
	mov  ecx, [ebp + 8]


;in acest label caut prin elementele vectorului numarul care este egal cu cel pus in ebx
;(practic caut adresa urmatorului element de dupa cel gasit pentru a l pune in campul next al elementului gasit)
egal_ebx_2:
	dec ecx
	;iau cate un element din vector si il compar cu ebx
	mov esi,[edx +8*ecx]
	cmp ebx,esi
	je retine_pozitie_2
	jmp egal_ebx_2

retine_pozitie_2:
	;pun in eax adresa elementului gasit
	;iau indicele elementului anterior
	;pun la adresa next a elementului anterior, adresa elementului curent
	;reiau in ecx numarul de noduri
	;cat timp elementul cautat nu depaseste numarul de noduri ma intorc la inceput,la primul label
	lea eax,[edx+8*ecx]
	pop ecx
	mov [edx+8*ecx+4],eax
	mov  ecx, [ebp + 8]
	cmp ecx,ebx
	jne egal_ebx


	;reiau in ecx numarul de noduri
	mov  ecx, [ebp + 8]
	;scad ecx
	dec ecx
	;de fiecare data cand am trecut prin label ul "retine_pozitie" am pus adresa elementului pe stiva
	;doresc sa pun in eax adresa primului element,astfel trebuie sa dau pop de cate ori am trecut prin label
		;pentru a lua adresa primului element
adresa_primu:
	dec ecx
	pop eax
	cmp ecx,0
	jne adresa_primu
	
	;pun valoarea initiala inapoi in ebx
	pop ebx
	
	leave
	ret
