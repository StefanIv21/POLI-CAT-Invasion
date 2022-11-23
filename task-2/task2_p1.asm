

section .text
	global cmmmc
	

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b

cmmmc:
	;am folosit algoritmul lui EUclid de calculare prin adunari succesive


	;push ebp
	;mov ebp,esp
	push ebp
	push esp
	pop ebp
	
	;pun pe stiva valoarea primului numar 
	push  dword [ ebp+8 ]
	;dau pop,punand astfel valoarea primului numar in registrul eax
	pop eax
	;pun pe stiva valoarea celui de al doilea numar
	push dword[ebp+12]
	pop edi
	;dau pop,punand astfel valoarea primului numar in registrul edi

comparatie:
	;comparam valorile initiale ale celor doua numere
	cmp eax,edi
	je final
	jl adauga_primu
	jg adauga_doi

;daca primul este mai mic,adun la el valoarea lui 
;pun pe stiva valoarea primului numar 
;dau pop pentru a l lua intr un registru
;fac adunarea
adauga_primu:
	push dword[ebp+8]
	pop ecx
	add eax,ecx
	jmp comparatie

;daca al doilea este mai mic,adun la el valoarea lui 
;pun pe stiva valoarea celui de al doilea numar 
;dau pop pentru a l lua intr un registru
;fac adunarea
adauga_doi:
	push dword[ebp+12]
	pop edx
	add edi,edx
	jmp comparatie

;restaurez ebp ul si esp ul
final:
	
	push ebp
	pop esp
	pop ebp
	
    
	ret
