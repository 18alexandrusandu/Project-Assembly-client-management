.586
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern _getch:proc
extern printf:proc
extern strlen:proc
extern scanf:proc
extern fopen:proc
extern fclose:proc
extern fscanf:proc
extern fprintf:proc
extern fgets:proc
extern gets:proc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
Util struct

username db 50 dup(0)
parola  db 50 dup(0)
nume db 50 dup(0)
prenume db 50 dup(0)
id db 6 dup(35),0
email db 50 dup(0)

Util ends





.data
;aici declaram date
cr db 100 dup(0)
dr db 100 dup(0)
username db 100 dup(0)
formatu db "username:",0
formatuc db"%s %s",0
formatuw db"%s",13,10,0
baza_de_date db "baza_de_date.txt"
format_sir db "%s ",0
format_sirs db "%s",0
format_nr db "numar %d",13,10,0


format_h db "here",0

contor dd 0
rulare db 1

local_key dd 14
format db "*",0
format2 db 8,32,8,0
format4 db 13,10,0
format5 db " lungimea este %d",13,10,0
format_empty db 32,13,10,0
format_sir_email db " email: %s",0



format3 db "parola este:%s",13,10,0
format6 db "sunt la fel? %d",0
format7 db "%d = %d",13,10,0
format_err db "eroare nu se poate efectua operatia",13,10,0
format_nerr db "totul merge ok",13,10,0
format_fisier db "baza_de_date.txt",0
format_citire db "r",0
format_scriere db "w",0
format_steluta db "*",0
format_bara db " / ",0
format_rn db  13,10,0



format_user db "username: ",0
format_parola db "parola:",0
format_np db "nume si prenume:",0
format_email db "email:",0
format_adaugare db " adaugare reusita",13,10,0
format_eroare db "username nume sau email deja exista in baza de date",0
pt_adaugare Util < >










test_text db "erasedmccue",0
test_email db "zilla@msn.com",0
test_name db  "Orion",0
test_prename db "Ahma",0
test_pasword db "abcdefghijklmopqrstuvwxyz",0

format_logare db "logare reusita",13,10,0



end_format db "gata",13,10,0

sU EQU (Util)
nr_utilizatori dd 0

utilizatori Util 10 dup(<>)

format_comanda db "comanda: ",0
comanda_add db "add",0
comanda_del db "del",0
comanda_list db "list",0
comanda_find db "find",0
comanda_find2 db "categorie:",0



comanda_exit db "exit",0

comanda_user db "username",0
comanda_email db "email",0
comanda_nume db "nume",0



format_logstart db "logare",13,10,0




logat dd 0
logat_index dd 0 


format_stergere_r db "s-a sters username %s",13,10,0


.code
;functia ia ca parametrii un nume de fisier
citire_fisier PROC
push ebp
mov ebp,esp
sub esp,24

;denumire fisier 
mov ebx,[ebp+8]







;pornire fisier
push offset format_citire
push  ebx
call fopen
add esp,12




;salveaza fisierul
mov [esp+8],eax


mov eax,0
mov [esp],eax




;counter pentru elemente 
mov eax,0
mov [esp+4],eax



ciclu_ctr:


mov ebx,[esp+4]
mov edx,ebx

mov eax,0
mov [esp],eax






bucla_citire:

mov ebx,[esp]
mov edx,[esp+4]


cmp ebx,0
jne peste_username





lea edx,utilizatori[edx].username

jmp peste_email

peste_username:

cmp ebx,1
jne peste_nume


lea edx,utilizatori[edx].nume
jmp peste_email

peste_nume:

cmp ebx,2
jne peste_prenume

lea edx,utilizatori[edx].prenume
jmp peste_email

peste_prenume:


cmp ebx,3
jne peste_parola

lea edx,utilizatori[edx].parola
jmp peste_email
peste_parola:


cmp ebx,4
jne peste_email







lea edx,utilizatori[edx].email

peste_email:

cmp ebx,5
jne peste_citire

mov ebx,[esp]
mov ecx,[esp+4]
mov ecx,[esp]


rdtsc

mov ebx,[esp]
mov ecx,[esp+4]
lea ecx ,utilizatori[ecx].id

mov ebx,0
mov bl,150

mov edi,0
mov di,48

add  [ecx],al

mov esi,0
mov si,[ecx]


cmp esi,ebx
jl peste_1

sub [ecx],bl

peste_1:

mov esi,0
mov si,[ecx]

cmp esi,edi
jg peste_11

mov [ecx],edi

peste_11:

add  [ecx+1],ah
mov esi,0
mov si,[ecx+1]


cmp esi,ebx
jl peste_2

add [ecx+1],bl


peste_2:


mov esi,0
mov si,[ecx+1]

cmp esi,edi
jg peste_22

mov [ecx+1],edi

peste_22:

shr eax,16

add [ecx+2],al

mov esi,0
mov si,[ecx+2]

cmp esi,ebx
jl peste_3

sub [ecx+2],bl

peste_3:

mov esi,0
mov si,[ecx+2]

cmp esi,edi
jg peste_33

mov [ecx+2],edi

peste_33:

add  [ecx+3],ah

mov esi,0
mov si,[ecx+3]

cmp esi,ebx
jl peste_4

sub [ecx+3],bl

peste_4:

mov esi,0
mov si,[ecx+3]

cmp esi,edi
jg peste_44

mov [ecx+3],edi

peste_44:

add [ecx+4],dl



mov esi,0
mov si,[ecx+4]

cmp esi,ebx
jl peste_5

sub [ecx+4],bl

peste_5:

mov esi,0
mov si,[ecx+4]

cmp esi,edi
jg peste_55

mov [ecx+4],edi

peste_55:


add  [ecx+5],dh
mov esi,0
mov si,[ecx+5]

cmp esi,ebx
jg peste_6

add [ecx+5],bl

peste_6:

mov esi,0
mov si,[ecx+5]

cmp esi,edi
jg peste_61

mov [ecx+5],edi

peste_61:

mov edi,0



mov ebx,[esp]
mov edx,[esp+4]



peste_citire:




cmp ebx,5
jge peste_bucla



mov ebx,[esp+8]


mov [esp+16],edx

push edx
push offset format_sir
push ebx
call fscanf
add esp,12

mov edx,[esp+16]


mov ebx,[esp]
mov edx,[esp+4]


cmp eax,0
jle afterctr







mov ebx,[esp]
add ebx,1
MOV [ESP],EBX



jmp bucla_citire

peste_bucla:





mov eax,[esp+4]
add eax,sU
mov [esp+4],eax


jmp ciclu_ctr


afterctr:

push [esp+8]
call fclose 
add esp,4

mov edx,0
mov ebx,sU
mov eax,[esp+4]
div ebx


mov esp,ebp
pop ebp
ret 4

citire_fisier endp


;denumire fisier ; numar elemente
scriere_in_fisier PROC
push ebp
mov ebp,esp
sub esp,8

;denumire fisier 
mov ebx,[ebp+8]

;pornire fisier
push offset format_scriere
push  ebx
call fopen
add esp,8


;salveaza fisierul
mov [esp+8],eax

;counter pentru elemente 
mov eax,0
mov [esp+4],eax

ciclu_scriere:

mov ebx,[esp+4]

mov eax,[ebp+12]
MOV EDX,sU
mul EDX


cmp ebx,eax 
jge after_scriere

mov ebx,[esp+4]

lea edx,utilizatori[ebx].username

mov ebx,[esp+8]

push edx
push offset formatuw
push ebx
call fprintf
add esp,12


mov ebx,[esp+4]

lea edx,utilizatori[ebx].nume

mov ebx,[esp+8]


push edx
push offset formatuw
push ebx
call fprintf
add esp,12

mov ebx,[esp+4]

lea edx,utilizatori[ebx].prenume

mov ebx,[esp+8]

push edx
push offset formatuw
push ebx
call fprintf
add esp,12


mov ebx,[esp+4]

lea edx,utilizatori[ebx].parola

mov ebx,[esp+8]


push edx
push offset formatuw
push ebx
call fprintf
add esp,12


mov ebx,[esp+4]

lea edx,utilizatori[ebx].email

mov ebx,[esp+8]

push edx
push offset formatuw
push ebx
call fprintf
add esp,12

mov ebx,[esp+4]
add ebx,sU
mov [esp+4],ebx

jmp ciclu_scriere

after_scriere:

push [esp+8]
call fclose
add esp,4

mov esp,ebp
pop ebp

ret 8

scriere_in_fisier ENDP



;se primeste ca parametru un index
listare_element PROC
push ebp
mov ebp,esp
sub esp,4

mov ebx,[ebp+8]
lea edx,utilizatori[ebx].nume


push edx
push offset format_sir
call printf
add esp,8


mov ebx,[ebp+8]
lea edx,utilizatori[ebx].prenume


push edx
push offset format_sir
call printf
add esp,8


push edx
push offset format_bara
call printf
add esp,8


mov ebx,[ebp+8]
lea edx,utilizatori[ebx].parola

push edx
call strlen
mov [esp],eax


scriere_parola:


push edx
push offset format_steluta
call printf
add esp,8


mov ebx,[esp]
dec ebx
mov [esp],ebx


cmp ebx,0
jg scriere_parola

push edx
push offset format_bara
call printf
add esp,8

mov ebx,[ebp+8]
lea edx,utilizatori[ebx].id


push edx
push offset format_sir
call printf
add esp,8


push edx
push offset format_bara
call printf
add esp,8

mov ebx,[ebp+8]
lea edx,utilizatori[ebx].email


push edx
push offset format_sir
call printf
add esp,8


push edx
push offset format_rn
call printf
add esp,8

mov esp,ebp
pop ebp
ret 4

listare_element endP

;parametru=numar de elemnete 
listare PROC
push ebp
mov ebp,esp
sub esp,4

mov eax,0
mov [esp],eax


listare_toti:
mov ebx,sU
mov eax,[esp]
mul ebx

mov ebx,eax

push ebx
call listare_element

mov ebx,[esp]
add ebx,1
mov [esp],ebx

cmp ebx,[ebp+8]
jl listare_toti

mov esp,ebp
pop ebp
ret 4

listare endP
;sir, lungime,key
encode_parola PROC

push ebp
mov ebp,esp
sub esp,4
	
mov esi,[ebp+12]

dec esi

;here is the key
mov ebx,[ebp+16]

mov edx,[ebp+8]

ciclu:

cmp esi,-1
je gata

mov ecx,esi
dec ecx

xor [edx+esi],ebx


dec esi

jmp ciclu
gata:
	
mov esp,ebp
pop ebp
ret 12

encode_parola endP


;ia ca parametru doar offset pentru un string
citire_parola PROC
    push ebp
	
	mov ebp,esp
	sub esp,4
	
	mov esi,0

    
	ciclu_parola:
	
	mov [esp],esi
	call _getch
	mov esi,[esp]

	
    mov edx,[ebp+8]
	mov[edx+esi],eax
	
	
	mov ebx,13
	cmp [edx+esi],ebx
	je gata_parola
	
	mov ebx,10
	cmp [edx+esi],ebx
	je gata_parola
	
	mov ebx,8
	cmp [edx+esi],ebx
	jne salt3
	


	mov [esp],esi
	
	push offset format2
	call printf
	add esp,4

	mov esi,[esp]
	dec esi
	
	jmp salt2

	salt3:
	mov [esp],esi
	
	push offset format
	call printf
	add esp,4
	
	mov esi,[esp]
	
	inc esi

	 salt2:
	 jmp ciclu_parola;
	
    gata_parola:
	MOV EAX,0
	MOV [EDX+ESI],EAX
	
    mov edx,[ebp+8]

	
	push offset format4
	call printf
	add esp,4
	
	mov esp,ebp
	pop ebp
	
	
    ret 4
	
 citire_parola endP
;sir1, lungime1,sir2,lungime2
 check_the_same proc
 
 mov ecx,[esp+8]
 mov ebx,[esp+16]
 
 
 cmp ecx,ebx
 je ciclu3

 negare:
 mov eax,0
 jmp gata3
 
 ciclu3:
 
 mov esi,[esp+4]
 mov edi,[esp+12]
 
  
 repe cmpsb
 jne negare 
 
  mov eax,1
 
 gata3:
 
 ret 16
 
 check_the_same  ENDP
 
 
 ;give lenght of array;give offset of username
 ;of email , of nume ;of prenume
 
 check_wrong_entry proc
  push ebp
  mov ebp,esp
  sub esp,32
  
  mov eax,0
  ;counter for main loop 
  mov [esp],eax
  
  
   ciclu_verificare:
  
  mov ebx,[esp]
  ;lenght array
  cmp ebx,[ebp+8]
  jge after_verificare
  
  
  
  ;WE CHECK FIRST FOR USERNAME
  mov eax,0
  cmp [ebp+12],eax
  je after_user
  
  
  
  
  
  ;compute the index of the utilizator
  mov eax,ebx
  mov ebx,sU
  mul ebx
  mov ebx,eax
  
 ; mov [esp+16],ebx
  
  ;push ebx
  ;push offset format_nr
  ;call printf
  ;add esp,8
 ; mov ebx,[esp+16]
  
  
  
  
  lea edx,utilizatori[ebx].username
  ;keeps temporally
  mov [esp+4],edx
  
  push edx
  call strlen
  add esp,4
  
  mov ebx,[esp+4]
  
  
 
  ;put lenght2 of string two
  push eax
  ;put string2 offset
  push ebx
  
  ;username to be checked
  push [ebp+12]
  
  
  ;find its lenght
  call strlen
  add esp,4
  
  mov ebx,[ebp+12]
  ;put lenght1 of string1
  push eax
  ;put string1
  push ebx
  
  call check_the_same
  cmp eax,1
  je after_verificare1
  after_user:
  
  ;WE CHECK FOR EMAIL NEXT 
  mov eax,0
  cmp [ebp+16],eax
  je after_email
  
  
  ;compute index
  mov eax,[esp]
  mov ebx,sU
  mul ebx
  mov ebx,eax
  
   mov [esp+16],ebx
  

  lea edx,utilizatori[ebx].email 
  
    ;keeps temporally
  mov [esp+4],edx
  
  push edx
  call strlen
  add esp,4
  

 
  
  mov ebx,[esp+4]
 
  ;put lenght2 of string two
  push eax
  ;put string2 offset
  push ebx
  
 
  
  ;username to be checked
  push [ebp+16]
  
  ;find its lenght
  call strlen
  add esp,4
 

  
 
  mov ebx,[ebp+16]
  ;put lenght1 of string1
  push eax
  ;put string1
  push ebx
  
  
  
  call check_the_same
  
  
  
  mov [esp+16],eax
  
  mov eax,[esp+16]
 
 
  cmp eax,1
  je after_verificare1
  after_email:
  
  ;WE CHECK FOR SURNAMR AND THEN FIRST NAME NEXT 
  
  ;WE CHECK FOR SURNAME
  mov eax,0
  cmp [ebp+20],eax
  
  je after_verificare
  
  
  ;compute index
  mov eax,[esp]
  mov ebx,sU
  mul ebx
  mov ebx,eax
  
  


  lea edx,utilizatori[ebx].nume 
  
 ;keeps temporally
  mov [esp+4],edx
  
  push edx
  call strlen
  add esp,4
  

 
  
  mov ebx,[esp+4]
 
  ;put lenght2 of string two
  push eax
  ;put string2 offset
  push ebx
  
 
  
  ;surname to be checked
  push [ebp+20]
  
  ;find its lenght
  call strlen
  add esp,4
 

  
 
  mov ebx,[ebp+20]
  ;put lenght1 of string1
  push eax
  ;put string1
  push ebx
  
  
  
  call check_the_same
  
  
  
  mov [esp+16],eax
  
  
  mov eax,[esp+16]
 
 
  cmp eax,1
  je after_nume
  jmp after_prenume
  
  
  
  after_nume:
  ;WE CHECK FOR FIRST NAME IF SURNAME IS THE SAME
  mov eax,0
  cmp [ebp+24],eax
  
  je after_verificare1
  
  
  ;compute index
  mov eax,[esp]
  mov ebx,sU
  mul ebx
  mov ebx,eax
  

  


  lea edx,utilizatori[ebx].prenume 
  
 ;keeps temporally
  mov [esp+4],edx
  
  push edx
  call strlen
  add esp,4
  

 
  
  mov ebx,[esp+4]
 
  ;put lenght2 of string two
  push eax
  ;put string2 offset
  push ebx
  
 
  
  ;surname to be checked
  push [ebp+24]
  
  ;find its lenght
  call strlen
  add esp,4
 

  
 
  mov ebx,[ebp+24]
  ;put lenght1 of string1
  push eax
  ;put string1
  push ebx
  
  
  
  call check_the_same
  
  
  
  mov [esp+16],eax
  
  cmp eax,1
  je after_verificare1
  
  after_prenume:
  
  

  
  
  mov ebx,[esp]
  add ebx,1
  mov [esp],ebx
  
  
 
 jmp ciclu_verificare
  after_verificare:
  mov eax,0
 jmp ver4
 
 
 after_verificare1:
  
 ver4:
 
 mov esp,ebp
 pop ebp
 ret 20
 

  check_wrong_entry endP
  
 ;se da un pointer cu lungimea sirului de utilizatori 
  add_element PROC 
  
  
  
 
  
  push offset format_user
  call printf 
  add esp,4
  
  lea edx,pt_adaugare.username
  push edx
  push offset format_sirs
  call scanf
  add esp,8


  
  
  push offset format_np
  call printf 
  add esp,4
  
  lea edx,pt_adaugare.nume
  push edx
  push offset format_sirs
  call scanf
  add  esp,8
  
  lea edx,pt_adaugare.prenume
  push edx
  push offset format_sirs
  call scanf
  add  esp,8
  
   push offset format_parola 
   call printf 
   add esp,4
   
  lea edx,pt_adaugare.parola
  push edx
  call citire_parola
  
   push offset format_email
   call printf 
   add esp,4
 
  
  lea edx,pt_adaugare.email
  push edx
  push offset format_sirs
  call scanf
  add esp,8 
  
  
  
  
  
  mov ebx,[esp+4]
  
   
  
  mov ebx,[esp+4]
  
  lea edx,pt_adaugare.prenume
  push edx
  lea edx,pt_adaugare.nume
  push edx
  lea edx,pt_adaugare.email
  push edx
  lea edx,pt_adaugare.username
  push edx
  push [ebx]
  call check_wrong_entry
 
  
  cmp eax,0
  jne add_salt
  
  push offset format_adaugare
  call printf
  add esp,4
 
 
 lea edx,pt_adaugare.parola
 push edx
 call strlen
 add esp,4
 
 push local_key
 push eax
 lea edx,pt_adaugare.parola
 push edx
 call encode_parola
 
    rdtsc
lea ecx,pt_adaugare.id
	
mov ebx,0
mov bl,150

mov edi,0
mov di,48

add  [ecx],al

mov esi,0
mov si,[ecx]


cmp esi,ebx
jl peste_1

sub [ecx],bl

peste_1:

mov esi,0
mov si,[ecx]

cmp esi,edi
jg peste_11

mov [ecx],edi

peste_11:

add  [ecx+1],ah
mov esi,0
mov si,[ecx+1]


cmp esi,ebx
jl peste_2

add [ecx+1],bl


peste_2:


mov esi,0
mov si,[ecx+1]

cmp esi,edi
jg peste_22

mov [ecx+1],edi

peste_22:

shr eax,16

add [ecx+2],al

mov esi,0
mov si,[ecx+2]

cmp esi,ebx
jl peste_3

sub [ecx+2],bl

peste_3:

mov esi,0
mov si,[ecx+2]

cmp esi,edi
jg peste_33

mov [ecx+2],edi

peste_33:

add  [ecx+3],ah

mov esi,0
mov si,[ecx+3]

cmp esi,ebx
jl peste_4

sub [ecx+3],bl

peste_4:

mov esi,0
mov si,[ecx+3]

cmp esi,edi
jg peste_44

mov [ecx+3],edi

peste_44:

add [ecx+4],dl



mov esi,0
mov si,[ecx+4]

cmp esi,ebx
jl peste_5

sub [ecx+4],bl

peste_5:

mov esi,0
mov si,[ecx+4]

cmp esi,edi
jg peste_55

mov [ecx+4],edi

peste_55:


add  [ecx+5],dh
mov esi,0
mov si,[ecx+5]

cmp esi,ebx
jg peste_6

add [ecx+5],bl

peste_6:

mov esi,0
mov si,[ecx+5]

cmp esi,edi
jg peste_61

mov [ecx+5],edi

peste_61:
	
   
  mov ebx,[esp+4]
  
  push [ebx]
  call move1
  mov ebx,[esp+4]
  
  mov ecx,[ebx]
  add ecx,1
  mov [ebx],ecx
  
  
  
   jmp add_end
  
  
  add_salt:
  
  push offset format_eroare
  call printf
  add esp,4
  
  add_end:
  
  ret 4

add_element endP

;PRIMESTE CA PARAMETRU UN INDEX(0 TO 10)
MOVE1 PROC


lea esi,pt_adaugare.username

push esi
call strlen
add esp,4

mov ecx,eax
add ecx,1
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].username
lea esi,pt_adaugare.username


rep movsb

mov ecx,eax
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].username


lea esi,pt_adaugare.nume

push esi
call strlen
add esp,4

mov ecx,eax
add ecx,1
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].nume
lea esi,pt_adaugare.nume


rep movsb

mov ecx,eax
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].nume


lea esi,pt_adaugare.prenume

push esi
call strlen
add esp,4

mov ecx,eax
add ecx,1
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].prenume
lea esi,pt_adaugare.prenume


rep movsb

mov ecx,eax
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].prenume


lea esi,pt_adaugare.email

push esi
call strlen
add esp,4

mov ecx,eax
add ecx,1
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].email
lea esi,pt_adaugare.email


rep movsb

mov ecx,eax
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].email



lea esi,pt_adaugare.parola

push esi
call strlen
add esp,4

mov ecx,eax
add ecx,1

mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].parola
lea esi,pt_adaugare.parola


rep movsb

mov ecx,eax
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].parola


ret 4
MOVE1 ENDP



;ia ca parametrii 2 indexi
MOVE2 PROC


mov ecx,eax
mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax


lea esi,utilizatori[ebx].username

push esi
call strlen
add esp,4

mov ecx,eax
add ecx,1
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].username


mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax
lea esi,utilizatori[ebx].username


rep movsb

mov ecx,eax
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].username


mov ecx,eax
mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax
lea esi,utilizatori[ebx].nume

push esi
call strlen
add esp,4

mov ecx,eax
add ecx,1



mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].nume
mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax
lea esi,utilizatori[ebx].nume


rep movsb

mov ecx,eax
mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].nume



mov ecx,eax
mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax
lea esi,utilizatori[ebx].prenume

push esi
call strlen
add esp,4

mov ecx,eax
add ecx,1

mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].prenume
mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax
lea esi,utilizatori[ebx].prenume


rep movsb


; push edi
; push offset formatuw
; call printf
; add esp,8



mov ecx,eax
mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax
lea esi,utilizatori[ebx].parola

push esi
call strlen
add esp,4

mov ecx,eax
add ecx,1

mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].parola
mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax
lea esi,utilizatori[ebx].parola


rep movsb


mov ecx,eax
mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax
lea esi,utilizatori[ebx].email

push esi
call strlen
add esp,4

mov ecx,eax
add ecx,1

mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].email
mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax
lea esi,utilizatori[ebx].email


rep movsb


mov ecx,eax
mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax
lea esi,utilizatori[ebx].id

push esi
call strlen
add esp,4

mov ecx,eax
add ecx,1

mov eax,sU
mov ebx, [esp+4]
mul ebx
mov ebx,eax
lea edi,utilizatori[ebx].id
mov eax,sU
mov ebx, [esp+8]
mul ebx
mov ebx,eax
lea esi,utilizatori[ebx].id


rep movsb


ret 8
MOVE2 ENDP
;LENGHT OF UTILIZATORI AS AN OFFSET 
;INDEX TO BE DELETED
DELETE PROC

ciclu_stergere:

;index 
mov eax,[esp+8]
;offset lung_sir
mov ebx,[esp+4]


mov ebx,[ebx]

cmp eax,ebx
jge after_stergere

mov ebx,eax
add ebx,1



push ebx
push eax
call move2


mov eax,[esp+8]
add eax,1
mov [esp+8],eax


jmp ciclu_stergere
after_stergere:
mov ebx,[esp+4]
mov eax,[ebx]
dec  eax
mov [ebx],eax

ret 8
DELETE ENDP

;ia ca parametrii:un numar care indica 
;tipul datei care va fi cautata
; sirul de caractere
;numarul de elemente in utilizatori
;prenume cand se da inainte un  nume 
find proc

push ebp
mov ebp,esp
sub esp,8

;mutam in ecx indicele pornind de la capat 







mov ecx,[ebp+16]
dec ecx
mov [ebp+16],ecx











ciclu_find:

mov ebx,[ebp+8]

mov ecx,[ebp+16]





cmp ecx,0
jl ciclu_find_end


mov ebx,[ebp+8]

mov eax,sU
mul ecx
mov ecx,eax


cmp ebx,0
jne find_nume_prenume

lea edx,utilizatori[ecx].username




push edx
call strlen 
add esp,4
;adaug lungimea sir1
push eax



mov ecx,[ebp+16]



mov eax,sU
mul ecx
mov ecx,eax
;adaug sir1

lea edx,utilizatori[ecx].username
push edx









mov ecx,[ebp+12]

push ecx
call strlen 
add esp,4
;adaug lungimea sir2
push eax
;adaug sir2
mov ecx,[ebp+12]
push ecx

call check_the_same


cmp eax,1
jne peste_find_ver_u


mov eax,[ebp+16]

jmp  sfarsit_find



peste_find_ver_u:

jmp find_peste

find_nume_prenume:

cmp ebx,1
jne find_id


lea edx,utilizatori[ecx].nume

push edx
call strlen 
add esp,4
;adaug lungimea sir1
push eax

mov ecx,[ebp+16]

mov eax,sU
mul ecx
mov ecx,eax
;adaug sir1
lea edx,utilizatori[ecx].nume
push edx

mov ecx,[ebp+12]

push ecx
call strlen 
add esp,4
;adaug lungimea sir2
push eax
;adaug sir2
mov ecx,[ebp+12]
push ecx

call check_the_same

cmp eax,1
jne peste_find_ver_n


mov eax,-1
jmp  find_prenume



peste_find_ver_n:

jmp find_peste


find_prenume:


; push [ebp+20]
; push offset formatuw
; call printf
; add esp,8



mov ebx,[ebp+8]

mov ecx,[ebp+16]

mov eax,sU
mul ecx
mov ecx,eax


lea edx,utilizatori[ecx].prenume

push edx
call strlen 
add esp,4
;adaug lungimea sir1
push eax

mov ecx,[ebp+16]

mov eax,sU
mul ecx
mov ecx,eax
;adaug sir1
lea edx,utilizatori[ecx].prenume
push edx

mov ecx,[ebp+20]

push ecx
call strlen 
add esp,4
;adaug lungimea sir2
push eax
;adaug sir2
mov ecx,[ebp+20]
push ecx

call check_the_same

cmp eax,1
jne peste_find_ver_p


mov eax,[ebp+16]
jmp  sfarsit_find



peste_find_ver_p:

jmp find_peste
find_id:

cmp ebx,2
jne find_email

lea edx,utilizatori[ecx].id

push edx
call strlen 
add esp,4
;adaug lungimea sir1
push eax

mov ecx,[ebp+16]

mov eax,sU
mul ecx
mov ecx,eax
;adaug sir1
lea edx,utilizatori[ecx].id
push edx

mov ecx,[ebp+12]

push ecx
call strlen 
add esp,4
;adaug lungimea sir2
push eax
;adaug sir2
mov ecx,[ebp+12]
push ecx

call check_the_same

cmp eax,1
jne peste_find_ver_i



mov eax,[ebp+16]
jmp  sfarsit_find



peste_find_ver_i:

jmp find_peste

find_email:

cmp ebx,3
jne find_pasword


lea edx,utilizatori[ecx].email

push edx
call strlen 
add esp,4
;adaug lungimea sir1
push eax

mov ecx,[ebp+16]

mov eax,sU
mul ecx
mov ecx,eax
;adaug sir1
lea edx,utilizatori[ecx].email
push edx

mov ecx,[ebp+12]

push ecx
call strlen 
add esp,4
;adaug lungimea sir2
push eax
;adaug sir2
mov ecx,[ebp+12]
push ecx

call check_the_same

cmp eax,1
jne peste_find_ver_e



mov eax,[ebp+16]
jmp  sfarsit_find



peste_find_ver_e:




jmp find_peste
find_pasword:

cmp ebx,4
jne find_peste

lea edx,utilizatori[ecx].parola

push edx
call strlen 
add esp,4
;adaug lungimea sir1
push eax

mov ecx,[ebp+16]

mov eax,sU
mul ecx
mov ecx,eax
;adaug sir1
lea edx,utilizatori[ecx].parola
push edx

mov ecx,[ebp+12]

push ecx
call strlen 
add esp,4
;adaug lungimea sir2
push eax
;adaug sir2
mov ecx,[ebp+12]
push ecx

call check_the_same

cmp eax,1
jne find_peste

mov eax,[ebp+16]
jmp  sfarsit_find


find_peste:

mov ebx,[ebp+16]
sub ebx,1
mov [ebp+16],ebx



jmp ciclu_find
ciclu_find_end:



mov eax,-1
mov [esp],eax

jmp final_find


sfarsit_find:



;mov [esp],eax

;push offset format_adaugare
;call printf
;add esp,4


mov eax,[ebp+16]



final_find:


mov esp,ebp
pop ebp
ret 16


 find endp

; parametru numar de utilizatori
logare PROC
push ebp
mov ebp,esp
sub esp,4

push offset format_user
call printf 
add esp,4


lea edx,pt_adaugare.username
push edx
push offset format_sirs
call scanf
add esp,8

push offset format_parola
call printf 
add esp,4

lea edx,pt_adaugare.parola

push edx
call citire_parola






mov ebx,0
mov eax,0


lea edx,pt_adaugare.username
mov ecx,[ebp+8]




push eax
push ecx
push edx
push ebx
call find







mov [esp],eax


cmp eax,0
jge check_pass

jmp sfarsit_log

check_pass:



mov ebx,[esp]
cmp ebx,[ebp+8]
jg sfarsit_log








mov ebx,[esp]
mov eax,sU
mul ebx
mov ebx,eax


lea edx,utilizatori[ebx].parola


push edx
call strlen
add esp,4

mov ebx,[esp]

mov logat_index,ebx

push eax


mov eax,sU
mul ebx
mov ebx,eax



lea edx,utilizatori[ebx].parola

push edx







lea edx,pt_adaugare.parola

push edx
call strlen 
add esp,4

push local_key
lea edx,pt_adaugare.parola
push eax
push edx
call encode_parola




lea edx,pt_adaugare.parola
push edx
call strlen 
add esp,4

push eax

lea edx,pt_adaugare.parola
push edx

call check_the_same


cmp eax,0
je sfarsit_log

push offset format_logare
call printf
add esp,4

mov ebx,1
mov logat,ebx


jmp log_end

sfarsit_log:
mov eax,-1
mov logat,eax

log_end:
mov esp,ebp
pop ebp

ret 4


logare endP
;ia ca parametrii un ofset pentu variabila cu numarul de elemnte din utilizatori
;si un offset pentru numele bazei de date_folosita_la_un_moment dat
api PROC


cmp logat,1
je peste_logare


mov ebx,[esp+4]
mov ebx,[ebx]

push offset format_logstart
call printf
add esp,4

mov ebx,[esp+4]
mov ebx,[ebx]

push ebx
call logare

mov eax,logat


cmp logat,1
jne end_api


peste_logare:




push offset format_comanda
call printf
add esp,4

lea edx,pt_adaugare.username

push edx
push offset format_sirs
call scanf
add esp,8

lea edx,pt_adaugare.username
push edx
call strlen
add esp,4

push eax

lea edx,pt_adaugare.username

push edx


push offset comanda_add
call strlen
add esp,4
push eax
push offset comanda_add
call check_the_same

cmp eax,1
jne peste_add


mov ebx,[esp+4]



push ebx
call add_element 
jmp end_api
peste_add:

lea edx,pt_adaugare.username
push edx
call strlen
add esp,4




push eax

lea edx,pt_adaugare.username

push edx


push offset comanda_del
call strlen
add esp,4
push eax
push offset comanda_del
call check_the_same

cmp eax,1
jne peste_del

push offset format_nerr
call printf
add esp,4

push offset format_user
call printf
add esp,4


lea edx,pt_adaugare.username

push edx
push offset format_sirs
call scanf
add esp,8



lea edx,pt_adaugare.username
mov ebx,[esp+4]
mov ebx,[ebx]
mov eax,0

push ebx
push offset format_nr
call printf
add esp,8




lea edx,pt_adaugare.username
mov ebx,[esp+4]
mov ebx,[ebx]
mov eax,0



push eax
push ebx
push edx
push eax
call find 


cmp eax,0
jl end_api
mov ebx,[esp+4]
mov ebx,[ebx]

cmp eax,ebx
jg end_api





mov ebx,[esp+4]

push eax


push ebx
call delete

lea edx,pt_adaugare.username
push edx
push offset format_stergere_r
call printf
add esp,8


jmp end_api
peste_del:


lea edx,pt_adaugare.username
push edx
call strlen
add esp,4

push eax

lea edx,pt_adaugare.username

push edx


push offset comanda_list
call strlen
add esp,4
push eax
push offset comanda_list
call check_the_same

cmp eax,1
jne peste_list

mov ebx,[esp+4]

mov ebx,[ebx]

push ebx
call listare


peste_list:

lea edx,pt_adaugare.username
push edx
call strlen
add esp,4


push eax

lea edx,pt_adaugare.username

push edx


push offset comanda_find
call strlen
add esp,4
push eax
push offset comanda_find
call check_the_same

cmp eax,1
jne peste_find

push offset format_nerr
call printf
add esp,4

push offset comanda_find2
call printf
add esp,4

lea edx,pt_adaugare.username
push edx
push offset format_sirs
call scanf
add esp,8




lea edx,pt_adaugare.username
push edx
call strlen
add esp,4


push eax

lea edx,pt_adaugare.username

push edx


push offset comanda_user
call strlen
add esp,4
push eax
push offset comanda_user
call check_the_same

cmp eax,1
jne peste_find_user

push offset format_user
call printf
add esp,4

lea edx,pt_adaugare.username
push edx
push offset format_sirs
call scanf
add esp,8

lea edx,pt_adaugare.username
mov ebx,[esp+4]
mov ebx,[ebx]
mov eax,0


lea edx,pt_adaugare.username
mov ebx,[esp+4]
mov ebx,[ebx]
mov eax,0


push eax
push ebx
push edx
push eax
call find 

cmp eax,0
jl peste_find_nu
mov ebx,sU
mul ebx

push eax

call listare_element
jmp peste_find


peste_find_nu:

push offset format_err
call printf
add esp,4


jmp peste_find




peste_find_user:


lea edx,pt_adaugare.username
push edx
call strlen
add esp,4


push eax

lea edx,pt_adaugare.username

push edx


push offset comanda_nume
call strlen
add esp,4
push eax
push offset comanda_nume
call check_the_same

cmp eax,1
jne peste_find_nume

push offset format_np
call printf
add esp,4

lea edx,pt_adaugare.nume
push edx
push offset format_sirs
call scanf
add esp,8

lea edx,pt_adaugare.prenume
push edx
push offset format_sirs
call scanf
add esp,8

lea edx,pt_adaugare.nume
lea ecx,pt_adaugare.prenume

mov ebx,[esp+4]
mov ebx,[ebx]
mov eax,1


push ecx
push ebx
push edx
push eax
call find 

cmp eax,0
jl peste_find_nn
mov ebx,sU
mul ebx
push eax


call listare_element
jmp peste_find_nume

peste_find_nn:

push offset format_err
call printf
add esp,4

jmp peste_find

peste_find_nume:

lea edx,pt_adaugare.username
push edx
call strlen
add esp,4


push eax

lea edx,pt_adaugare.username

push edx


push offset comanda_email
call strlen
add esp,4
push eax
push offset comanda_email
call check_the_same

cmp eax,1
jne peste_find

push offset format_email
call printf
add esp,4

lea edx,pt_adaugare.email
push edx
push offset format_sirs
call scanf
add esp,8

lea edx,pt_adaugare.email

mov ebx,[esp+4]
mov ebx,[ebx]
mov eax,3
mov ecx,0

push ecx
push ebx
push edx
push eax
call find 

cmp eax,0
jl peste_find_ne


mov ebx,sU
mul ebx
push eax




call listare_element
jmp peste_find
peste_find_ne:

push offset format_err
call printf
add esp,4

peste_find:


lea edx,pt_adaugare.username
push edx
call strlen
add esp,4


push eax

lea edx,pt_adaugare.username

push edx


push offset comanda_exit
call strlen
add esp,4
push eax
push offset comanda_exit
call check_the_same

cmp eax,1
jne end_api

 mov logat,0

  mov ecx,[esp+8]
  mov ebx,[esp+4]
  mov ebx,[ebx]
  
  
  push ecx
  push offset formatuw
  call printf
  add esp,8
  
  
  mov ecx,[esp+8]
  mov ebx,[esp+4]
  mov ebx,[ebx]
  
  push ebx
  push ecx
  call scriere_in_fisier

 PUSH offset format4
 call printf
 add esp,4
  
  


end_api:

ret 8
api endP








start:
	;aici se scrie codul
	 ;push offset utilizatori
	 push offset format_fisier
	 call citire_fisier
	
     mov nr_utilizatori,eax
	  
	 push nr_utilizatori
	 push offset format5
	 call printf 
	 
	 mov esi,0
	 
	 mov rulare,1
	ciclu_api:
	
	 push offset format_fisier
	 push offset nr_utilizatori
     call api
	
    cmp rulare,1
	je ciclu_api
	
	 
	;terminarea programului
	push 0
	call exit
end start
