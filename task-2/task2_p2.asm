section .text
	global par

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:
	;push ebp
	;mov ebp,esp
	push ebp
	push esp 
	pop ebp
	;pun valoarea lui ebx pe stiva pentru a o retien
	push ebx

	;pun pe stiva adresa sirului de paranteze
	push dword [ebp+8]
	;dau pop,punand astfel adresa in registrul ecx
	pop ecx
	;pun pe stiva numarul de noduri
	push dword [ebp+12]
	;dau pop,punand astfel numarul de noduri in edx
	pop edx

	;pun 0 la adresa
	;cu ebx voi parcurge adresa sirului de paranteze,pentru a lua cate o paranteze
	;in edi voi retine numarul de paranteze (
	;in esi voi retine numarul de paranteze )
	xor ebx,ebx
	xor edi,edi
	xor esi,esi

;compar fiecare element din sir cu codul ascii pentru a mi da seama ce paranteza este
compara:
	cmp byte [edx+ebx], 40
	je parateza_1
	cmp byte [edx+ebx], 41
	je paranteza_2

parateza_1:
	;cresc numarul de paranteze (
	;cresc indicele cu care parcurg sirul de paranteze
	;scad numarul de noduri
	;daca numarul de noduri ajunge la 0 ma opresc
	inc edi
	inc ebx
	dec ecx
	cmp ecx,0
	jg compara
	jmp compar_numere

paranteza_2:
	;cresc numarul de paranteze )
	;cresc indicele cu care parcurg sirul de paranteze
	;scad numarul de noduri
	;daca numarul de noduri ajunge la 0 ma opresc
	inc esi
	inc ebx
	dec ecx
	cmp ecx,0
	jg compara
	jmp compar_numere


;daca numarul de paranteze este egal pun pe stiva 1 si ii dau pop cu eax pentru a ii lua valoarea
egal:
	push 1
	pop eax
	jmp final

;compar numarul de paranteze ( cu numarul de paranteze )
;daca sunt egale ma duc la labelul egal
;daca nu, pun pe stiva 0 si ii dau pop cu eax pentru a ii lua valoarea
compar_numere:
	cmp edi,esi
	je egal
	push 0
	pop eax


final:
	;dau pop la ebx pentru reia valoarea initiala
	pop ebx
	;restaurez ebp ul si esp ul
	push ebp
	pop esp
	pop ebp

	ret
