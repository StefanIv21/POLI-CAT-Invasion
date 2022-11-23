
global get_words
global compare_func
global sort

;un string in care am pus delimitatorii
section .data
    token :db ",. ",0

section .text
    extern strtok
    extern strlen
    extern strcmp
    extern qsort


;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    enter 0, 0

    ;pun argumentele functiei qsort in ordine inversa pentru a apela functia
    ;functia de comparare,size-ul,numarul de cuvinte si adresa vectorului de stringuri
    push comparere
    push dword [ebp+16]
    push dword [ebp+12]
    push dword [ebp+8]
    call qsort
    ;aducem stiva la punctul initial
    add esp,16

    leave
    ret

comparere:
    enter 0,0

    ;pun registrele pe care le v om folosi pe stiva pentru a retine valorile
    push ebx
    push edi

    ;pun in 2 registre adresele celor 2 stringuri pe care le v om compara
    ;pentru fiecare,pun valoare pe stiva apelez functia strlen si iau valoarea
    ;intr -un registru
    mov ebx,[ebp+8]
    mov edi,[ebp+12]
    mov ebx,[ebx]
    mov edi,[edi]

    push ebx
    call strlen
    add esp,4
    mov ebx,eax

    push edi
    call strlen
    add esp,4
    mov edi,eax
    
    ;scad in primul registru in care am pus numarul de litere al doilea registru
    ;pun rezultatul in eax
    ;daca primul este mai mic,in eax va fi un numar negativ
    ;daca primul este mai mare,in eax va fi un numar pozitiv
    ;daca sunt egale,le compar lexicografic cu ajutorul functiei strcmp
    sub ebx,edi
    mov eax,ebx
    cmp eax,0
    je egal
    jmp final
   
egal:
    ;comparam cu ajutorul functiei strcmp
    ;pun in 2 registre adresele celor 2 stringuri pe care le v om compara
    ;pun valorile celor doua pe stiva si apelez functia
    mov eax,[ebp+8]
    mov ebx,[ebp+12]
    mov eax,[eax]
    mov ebx,[ebx]
    push ebx
    push eax
    call strcmp
    ;aducem stiva la punctul initial
    add esp,8

final:
    ;reiau in registrele folosite valorile initiale
    pop edi
    pop ebx
    leave
    ret


;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0
    ;pun valoarea lui ebx pe stiva pentru a l retine
    push ebx
    ;ebx este indicele cu care parcurgem adresa vectorului in care trebuie sa punem stringurile
    mov ebx,0
    ;pun in registrele ecx,esi,edi adresa textului din care extragem,
    ;numarul de cuvinte si adresa vectorului de stringuri 
    mov ecx,[ebp+8]
    mov esi,[ebp+16]
    mov edi,[ebp+12]
    ;pun pe stiva in ordine inversa argumentele functiei strtok pentru a o apela
    ;stringul de delimitatori si adresa textului din care extragem
    push token
    push ecx
    call strtok
    ;aducem stiva la punctul initial
    add esp,12
    ;scad numarul de cuvinte si pun rezultatul functei apelate la adresa vectorului cerut
    dec esi
    mov  [edi+4*ebx], eax
    ;cresc indicele  
    inc ebx


extragere_cuvinte: 
    ;pun argumentele necesare in ordine inversa pe stiva pentru a apela functia strtok
    ;aducem stiva la punctul initial
    ;pun rezultatul functei apelate la adresa vectorului cerut
    ;scad numarul de cuvinte 
    ;parcurg acest label pana cand numarul de cuvinte devine 0
    push token
    push 0
    call strtok
    add esp,8
    mov [edi+4*ebx],eax  
    inc ebx
    dec esi
    cmp esi,0
    jg extragere_cuvinte

    ;reiau valoarea initiala a lui ebp
    pop ebx 
    leave
    ret
