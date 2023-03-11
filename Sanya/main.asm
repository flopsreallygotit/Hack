.model tiny
.code 
.386
org 100h

locals @@			; Сравнение db и vd ->


Start:  

        ; read str from input
        mov di, offset PasswordBuffer
        call getline
        ; compare strings
        mov di, offset PasswordBuffer   ; getting hash of input line
        call get_hash
        
        cmp ax, CorrectPasswordHash     ; comparing with hash
        jne @@wrong_password

        mov dx, offset CorrectPhare
        call Puts
        jmp @@correct_password
        @@wrong_password:

        mov dx, offset IncorrectPhrase
        call Puts

        @@correct_password:


        mov ax, 4c00h
        int 21h

;------------------------------------------------
;   Ultra super mega complicated hash func
;   Returns hash of string in ax
;------------------------------------------------
;	Entry:	  di: pointer to string you want to be hashed
;	Destroys: ax, cx
;   Returns:  Hash in ax
;------------------------------------------------
get_hash    proc

            xor ax, ax  ; ax = 0
            mov cx, 5   ; starting to salt
    @@L1:
            add ax, [di]   ; just some really difficult hashing algorithms
            mov bx, cx
            add bx, 04eh

            add ax, bx 

            inc di
            inc cx
            cmp byte ptr [di], "$"
            jne @@L1

            ret
            endp

;------------------------------------------------
;   Compares  2 strings
;------------------------------------------------
;	Entry:	  si: pointer to str1
;             di: pointer to str2
;   Exit:     None
;	Expects:  nice cock, es = ds
;	Destroys: cx
;   Returns:  Flags will be set according to comparison
;------------------------------------------------
strcmp      proc

@@L1:
            cmp byte ptr [si], "$"      ; in case chars in each string is $, they are equal
            jne @@skip
            cmp byte ptr [di], "$"
            je @@all_eq

            @@skip:

            cmpsb                       ; ds:[si] - es:[di]
            je @@L1                     ; in case of unequality the status of flags is returned
        
            ret                         ; returning flags in last status
@@all_eq:
            cmp ax, ax                  ; setting flags to establish equality
            ret

            endp


;------------------------------------------------
;   Reads line from stdin until \n 
;------------------------------------------------
;	Entry:	  keyboard input
;             di - pointer to string to write into
;	Exit:     None
;	Expects:  none
;	Destroys: ax, di 
;------------------------------------------------
getline     proc
            mov ax, 0                   ; preparing ax for double penetration

            mov ah, 01h                 ; going to getch() mode      

@@l1:       
            int 21h                     ; getch()
            cmp al, 0dh                 ; reading until stop symbol
            je @@end

            mov [di], al                ; symb -> memory
            inc di                      ; ptr++
            jmp @@l1
@@end:
            mov byte ptr [di], 024h      ; replace stop sym with endline "$"

            ; mov di, offset mystring
            ; call printline			     ; printing

            ret
            endp


;------------------------------------------------
;	Prints string
;------------------------------------------------
;	Entry:    string in dx
;	Exit:     not defined
;	Expects:  none
;	Destroys: ah, dx 
;------------------------------------------------

Puts	proc
        mov ah, 09h		    ; puts()
        int 21h			    ; by interupting prog, printing the message

        ret
        endp

CorrectPasswordHash = 7dbbh
CorrectPhare    db "Correct Password!$"
IncorrectPhrase db "You cock sucker!$"
PasswordBuffer  db 10d dup(11d)

end Start
