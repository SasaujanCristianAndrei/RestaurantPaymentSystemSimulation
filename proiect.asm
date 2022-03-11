.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;intrebari: cand se da call scanf sau orice functie in eax se pune rezultatul?





;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern scanf:proc
extern fopen:proc
extern fclose:proc
extern fprintf:proc
extern printf:proc
extern fgets:proc
extern puts:proc
extern fscanf:proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date

file_name db "fisier.txt",0
pointer_fisier dd 0
mode_read db "r",0
produs db 0
cantitate db 0
alegere dd 0
sum_tot dd 0 ;folosim pentru nota de plata finala

msg1 db "Meniu restaurant",13,10,0
msg2 db "Alegeti produsul si cantitatea:",0
msg3 db "Produs ales: ",0
msg4 db "Cantitate: ",0
msg5 db "Pret total: ",0
msg6 db "1.Alta comanda",13,10,0
msg7 db "2.Iesire",13,10,0
msg8 db " ",13,10,0 ;il folosesc pentru newline fix dupa ce dau alta comanda
msg9 db "Pret final:",0
msg10 db "Ne pare rau, nu mai avem acest produs.",13,10,0
format_new_citire db "%d %s %d %d",13,10,0
format_new_scriere db "%d %s %d",13,10,0
format_int db "%d",13,10,0
format_int_fara db "%d",0
format_int_citire_produs_cantitate db "%d %d",0
format_char db "%s",0


magazin struct

	indice DB 0
	nume DB 20 dup(0) ; define byte 20     20 byte cu val zero deci un nume de 20bytes=20octeti;
	pret DB 0
	cantitate DB 0
	
magazin ends


meniu magazin {0," ",0},
		  {0," ",0},
          {0," ",0},
          {0," ",0}
		  
.code
start:
	
	push offset msg1
	call puts
	
	push offset mode_read
	push offset file_name
	call fopen
	mov pointer_fisier,eax

	
	; push offset meniu.indice[0]
	; push offset format_int
	; push pointer_fisier
	; call fscanf
	
	; mov eax,0
	; mov al,meniu.indice[0]
	; push eax
	; push offset format_int
	; call printf
	
	
	; push offset meniu.nume[0]
	; push offset format_char
	; push pointer_fisier
	; call fscanf
	
	; mov eax,0
	; mov eax,offset meniu.nume[0]
	; push eax
	; push offset format_char
	; call printf
	
	; push offset meniu.pret[0]
	; push offset format_int
	; push pointer_fisier
	; call fscanf
	
	; mov eax,0
	; mov al,meniu.pret[0]
	
	; push eax
	; push offset format_int
	; call printf
	
	push offset meniu.cantitate[0]
	push offset meniu.pret[0]
	push offset meniu.nume[0]
	push offset meniu.indice[0]
	push offset format_new_citire
	push pointer_fisier
	call fscanf
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	altacomanda: ;este loop ptr alta comanda
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	mov eax,0
	mov ecx,offset meniu.nume[0]
	mov ebx,0
	mov al,meniu.indice[0]
	mov bl, meniu.pret[0]
	
	push ebx
	push ecx
	push eax
	push offset format_new_scriere
	call printf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; prima citire 1 Orez 100
	
	push offset meniu.cantitate[23]
	push offset meniu.pret[23]
	push offset meniu.nume[23]
	push offset meniu.indice[23]
	push offset format_new_citire
	push pointer_fisier
	call fscanf
	
	mov eax,0
	mov ecx,offset meniu.nume[23]
	mov ebx,0
	mov al,meniu.indice[23]
	mov bl, meniu.pret[23]
	
	push ebx
	push ecx
	push eax
	push offset format_new_scriere
	call printf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; a doua citire 2 Burger 200

	push offset meniu.cantitate[46]
    push offset meniu.pret[46]
	push offset meniu.nume[46]
	push offset meniu.indice[46]
	push offset format_new_citire
	push pointer_fisier
	call fscanf
	
	mov eax,0
	mov ecx,offset meniu.nume[46]
	mov ebx,0
	mov al,meniu.indice[46]
	mov bl, meniu.pret[46]
	
	push ebx
	push ecx
	push eax
	push offset format_new_scriere
	call printf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; a treia citire 3 Supa 50	

	push offset meniu.cantitate[69]
    push offset meniu.pret[69]
	push offset meniu.nume[69]
	push offset meniu.indice[69]
	push offset format_new_citire
	push pointer_fisier
	call fscanf
	
	mov eax,0
	mov ecx,offset meniu.nume[69]
	mov ebx,0
	mov al,meniu.indice[69]
	mov bl, meniu.pret[69]
	
	push ebx
	push ecx
	push eax
	push offset format_new_scriere
	call printf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; a patra citire 4 Legume 70			
	push pointer_fisier
	call fclose;terminarea programului
	
	push offset msg2 ;Alegeti produsul si cantitatea:
	call puts

	push offset produs ;am citit indicele produsului
	push offset format_int_fara ;in produs vom avea indicele produsului
	call scanf
	
	
	push offset cantitate ;am citit cantitatea de mancare
	push offset format_int_fara
	call scanf ;aparent cand se da call scanf se pune in eax 1
			;am mutat liniile ptr produs aici ca mai sus dadea 1 de la call scanf
	mov eax,0
	mov al,produs ;trebuie sa il pun in registru ca pe push pot da doar variabile de 32 biti

	
	cmp al,meniu.indice[0]
	je orez
	
	cmp al,meniu.indice[23]
	je burger
	
	cmp al,meniu.indice[46]
	je supa
	
	cmp al,meniu.indice[69]
	je legume
	
	orez:
		push offset msg3
		call printf
		mov ecx,0;vom retine in ecx numele produsului
		mov ecx,offset meniu.nume[0] ;trimitem adresa
		push ecx ;in ecx avem Orez
		call puts
		
		push offset msg4;MSG5=Cantitate:
		push offset format_char
		call printf
		mov edx,0; vom folosi edx ptr a retine cantitatea citita mai sus
		mov dl,cantitate ;mutam in dl
		push edx;dam push la dl in care avem cantitatea
		push offset format_int
		call printf
		
		mov ebx,0
		mov bl,meniu.cantitate[0] ;punem in bl cantitatea totala
		sub bl,cantitate; din cantitatea totala scadem ce a fost comandat
		mov meniu.cantitate[0],bl;mutam inapoi cantitatea ramasa actualizata

		cmp meniu.cantitate[0],-1 ;daca stocul este gen gol afisam msg 
		je stoc_epuizat1 ;Ne pare rau, nu mai avem acest produs.
		
		push offset msg5
		call printf
		mov eax,0
		mov al,meniu.pret[0]
		mov edx,0
		mov dh,cantitate
		mul dh ;in AX ar trb sa avem pret total
		;mul dh ---> AX=AL*DH
		add sum_tot,eax ;in sum_tot vom retine nota de plata finala
		push eax
		push offset format_int
		call printf
		jmp gata
		
		
		
		
		
		stoc_epuizat1:
		push offset msg10
		call printf
		
		jmp gata
	
	burger:
		push offset msg3
		call printf
		mov ecx,0
		mov ecx,offset meniu.nume[23]
		push ecx
		call puts
		
		push offset msg4;MSG5=Cantitate:
		push offset format_char
		call printf
		mov edx,0
		mov dl,cantitate 
		push edx
		push offset format_int
		call printf
		
		mov ebx,0
		mov bl,meniu.cantitate[23]
		sub bl,cantitate
		mov meniu.cantitate[23],bl

		cmp meniu.cantitate[23],-1 ;daca stocul este gen gol afisam msg 
		je stoc_epuizat1
		
		push offset msg5
		call printf
		mov eax,0
		mov al,meniu.pret[23]
		mov edx,0
		mov dh,cantitate
		mul dh 
		add sum_tot,eax ;in sum_tot vom retine nota de plata finala
		push eax
		push offset format_int
		call printf
		jmp gata
		
		stoc_epuizat2:
		push offset msg10
		call printf
		
		jmp gata
	
	supa:
		push offset msg3
		call printf
		mov ecx,0
		mov ecx,offset meniu.nume[46]
		push ecx
		call puts
		
		push offset msg4;MSG4=Cantitate:
		push offset format_char
		call printf
		mov edx,0
		mov dl,cantitate 
		push edx
		push offset format_int
		call printf
		
		mov ebx,0
		mov bl,meniu.cantitate[46]
		sub bl,cantitate
		mov meniu.cantitate[46],bl

		cmp meniu.cantitate[46],-1
		je stoc_epuizat1
		
		push offset msg5
		call printf
		mov eax,0
		mov al,meniu.pret[46]
		mov edx,0
		mov dh,cantitate
		mul dh 
		add sum_tot,eax ;in sum_tot vom retine nota de plata finala
		push eax
		push offset format_int
		call printf
		jmp gata
		
		stoc_epuizat3:
		push offset msg10
		call printf
		
		jmp gata
		
	legume:
		push offset msg3
		call printf
		mov ecx,0
		mov ecx,offset meniu.nume[69]
		push ecx
		call puts
		
		push offset msg4;MSG5=Cantitate:
		push offset format_char
		call printf
		mov edx,0
		mov dl,cantitate 
		push edx
		push offset format_int
		call printf
		
		mov ebx,0
		mov bl,meniu.cantitate[69]
		sub bl,cantitate
		mov meniu.cantitate[69],bl

		cmp meniu.cantitate[69],-1
		je stoc_epuizat1
		
		push offset msg5
		call printf
		mov eax,0
		mov al,meniu.pret[69]
		mov edx,0
		mov dh,cantitate
		mul dh 
		add sum_tot,eax ;in sum_tot vom retine nota de plata finala
		push eax
		push offset format_int
		call printf

		jmp gata
		
		stoc_epuizat4:
		push offset msg10
		call printf
		
		jmp gata
		
	gata:
	
	
	push offset msg6
	call printf
	push offset msg7
	call printf
	
	push offset alegere
	push offset format_int_fara
	call scanf
	
	push offset msg8
	call printf
	
	cmp alegere,1
	je altacomanda
	jmp iesire
	
	iesire:
	push offset msg9
	call printf
	
	push sum_tot
	push offset format_int
	call printf
	
	push 0
	call exit
	

end start
