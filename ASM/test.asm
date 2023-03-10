.model tiny
.286

locals @@

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.data

;~~~Video Output~~~
video = 0b800h  ; Address of video segment start.
color = 3eh     ; Output color.     

;~~~Messages~~~
s1 db 'aboba', 0
s2 db 'aboba', 0

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

include macro.asm

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.code

org 100h

Start:      xor bx, video
            mov es, bx
            xor bx, bx

            mov si, offset s1
            mov di, offset s2
            call Strlen
            call Strncmp

            mov ah, 4eh
            mov di, 1980d
            stosw
            
            EXIT

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

include string.asm
include funcs.asm

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

end Start
