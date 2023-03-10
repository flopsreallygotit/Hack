;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Exits to DOS
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Entry:    None
; Exit:     None
; Expects:  None
; Destroys: AX
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

EXIT        macro
            nop
            mov ax, 4c00h
            int 21h
            nop
            endm

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Pushes AX, BX, CX, DX, SP, BP, SI, DI, ES, DS
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Entry:    None
; Exit:     None
; Expects:  None
; Destroys: None
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PUSHALL     macro
            nop
            pusha
            push es ds
            nop
            endm

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Pops out AX, BX, CX, DX, SP, BP, SI, DI, ES, DS (in reverse order)
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Entry:    None
; Exit:     None
; Expects:  None
; Destroys: None
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

POPALL      macro
            nop
            pop ds es
            popa
            nop
            endm

DELAY       macro
            nop
            push bx cx

            mov bx, 400d
            @@Next:     mov cx, -1

            @@Delay:    loop @@Delay
            
                        dec bx
                        cmp bx, 00h
                        jne @@Next

            pop cx bx
            nop
            endm
            