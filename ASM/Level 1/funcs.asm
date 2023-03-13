;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Puts address string in register and terminates it
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Entry:    SI = Address of buffer
; Exit:     SI = Address of the end of string
; Expects:  None
; Destroys: AX
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Parse       proc                                                                                                                                                                                ; VULNERABILITY: NO LENGTH CONTROL
            mov ah, 01h

@@Next:     int 21h
            cmp al, 0dh
            je @@End

            mov [si], al
            inc si     

            jmp @@Next

@@End:      mov byte ptr [si], 00h

            ret
            endp

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Encryptes cipher and compares it with given password
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Entry:    SI = Address of terminated password string
;           DI = Address of terminated cipher string
; Exit:     AX = 0  if password is correct
;           AX != 0 if password isn't correct
; Expects:  None
; Destroys: CX
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encrypte    proc
            push si

@@Next:     mov ax, [si]
            cmp al, 00h
            je @@End

            add ax, 3d
            mov [si], ax
            inc si

            jmp @@Next

@@End:      pop si

		xchg si, di
            call Strlen
            call Strncmp

            ret
            endp

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Prints label on center
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Entry:    SI = Address of label
; Exit:     None
; Expects:  None
; Destroys: DI
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PrintLbl    proc
            mov di, 2 * (40 + 80 * 12)

            call Strlen
            shr cx, 1d
            shl cx, 1d
            sub di, cx

            call PrintStr

            ret
            endp
