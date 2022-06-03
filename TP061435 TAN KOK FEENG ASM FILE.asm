;TAN KOK FEENG
;TP061435
;APU2F2109CS(CYB)
;CSLLT INDIVIDUAL PROGRAM ASSIGNMENT

.model small
.stack 300h
.data  

;-----general variable-------
    count  db ?
    range   db ?
    number  db ?
    colour db 9

    banner_continue db "Please Enter Any Key To Continue$"

    banner      db "===========================================================================",13,10
                db "     123             Welcome to APU Digital EVENT!                      123",13,10
                db "     456   This Event is organized by APU EVENT MANAGEMENT DEPARTMENT   456",13,10
                db "     789               This event is all about digit!                   789",13,10
                db "     !@#             This event is brought to you by APU!               !@#",13,10
                db "     987                  Date:   06/06/2022                            654",13,10
                db "     654                   TIME:   2PM - 5 PM                           321",13,10
                db "===========================================================================$",13,10

    mainMenu    db "Main Menu",13,10
                db "1) Number Pattens",13,10
                db "2) Design Pattens",13,10
                db "3) Box Type Pattens",13,10
                db "4) Nested Loop Pattens$"
    choiceLine  db " Select your choice (1,2,3,4,5 for quit): $"
    againLine   db " Choose again? (1 for YES): $" 
    endLine db "Thank you for using this program$"
      
;-----diamond shape variable---------  
    messageRange db " Enter the range(1-9): $"
    display_count db ?
    halfnumber db ?    
    
;------design pattern variable------

    messageDesign db " Please choose how many shape you want(1-9): $"  
    shapesize db ? 
                                     
;------box pattern variable--------
    char1 db ?
    char2 db ?
    char3 db ?
    char4 db ?
    char5 db ? 
    messageBox db " Please enter your words (5 character): $"
    
                           
    
;-----nestedloop variable-----------
   
    
.code  
;-------functions start-------------

;-------general function start------------

AGAIN proc
    call Newline

    mov ah,09h
    lea dx,againLine
    int 21h

    mov ah, 01h
    int 21h                    
    MOV BH, AL
    
    sub bh,48
    mov count,bh

    CALL Newline
    
    cmp count,1
    jne again_end            ; Short conditional jump
    jmp start             ; Near unconditional jump 
    again_end:
    jmp end

    ret
    
AGAIN endp

RESET proc
    
    mov ax,0000
    mov bx,0000
    mov cx,0000
    mov dx,0000
    
    ret

RESET endp        

CLS proc  
    
    MOV AH, 06h    ; Scroll up function
    XOR AL, AL     ; Clear entire screen
    XOR CX, CX     ; Upper left corner CH=row, CL=column
    MOV DX, 184FH  ; lower right corner DH=row, DL=column 
    MOV BH, 0Fh    
    INT 10H
    ret

CLS endp 


DisplayColour proc
    mov  bh, 0  ;Display page
    mov  ah, 02h  ;SetCursorPosition
    int  10h
    mov  ah, 09h
    int  10h  
    ret
DisplayColour endp 

increase_colour proc
    
    cmp colour,15
    je  colour_limit_jump
    inc colour
    ret
    
    colour_limit_jump:
        mov colour,9
        ret
    
increase_colour endp

Newline proc 
        mov ah, 02h
        mov DL, 13
        int 21h
        mov ah, 02h  
        mov DL, 10
        int 21h
        ret
    
Newline endp 



;-------general function end----------


;--------menu function start----------




main_menu proc 
    
    CALL CLS
    
    
    mov ah,09h
    lea dx,mainMenu
    int 21h
    
    CALL Newline  
    
    CALL Newline
    mov ah,09h
    lea dx,choiceLine
    int 21h
    
    mov ah, 01h
    int 21h                    
    MOV BH, AL
    
    sub bh,48
    mov count,bh

    CALL Newline
    cmp count,1
    jne main_menu_choice_2
    jmp  numberPattern
    
    main_menu_choice_2:
    cmp count,2
    jne main_menu_choice_3
    jmp design_pattern
    
    main_menu_choice_3:
    cmp count,3
    jne main_menu_choice_4
    jmp boxTypePattern
    
    main_menu_choice_4:
    cmp count,4
    jne main_menu_choice_end
    jmp nestedLoopPattern_menu
    
    main_menu_choice_end:
    cmp count,5
    jmp end 

    
    ret

    
main_menu endp 

nestedLoopPattern_menu proc  
                            
    CALL nestedLoopPattern01                        
    CALL nestedLoopPattern02 
    CALL nestedLoopPattern03
    CALL nestedLoopPattern04 
    CALL AGAIN
        
nestedLoopPattern_menu endp       

banner_menu proc
    
    MOV AH, 06h    ; Scroll up function
    XOR AL, AL     ; Clear entire screen
    XOR CX, CX     ; Upper left corner CH=row, CL=column
    MOV DX, 184FH  ; lower right corner DH=row, DL=column 
    MOV BH, 0Ah   ;Colour
    INT 10H
    POP CX
    mov ah,09h
    lea dx,banner
    int 21h
    CALL Newline  
    mov ah,09h
    lea dx,banner_continue
    int 21h
    mov ah, 01h
    int 21h 
    jmp start
    ret
banner_menu endp


;--------menu function end------------  


;-------number pattern function start-----

upper_diamond proc
     ;upper diamond
    
    mov dl,0 ;col0
    mov dh,1 ;row1
    mov cx,0
    mov bx,0
    mov cl, range
    mov bl, range
    mov display_count,2
    mov number,0
    add number,48
    mov halfnumber,1
    
    
    jmp upper_diamond_start
    
    upper_diamond_loop_2:
        inc dh ;increasing row
        
        call Newline 
        mov dl,0 ;reseting column
        
        add display_count,2
        add halfnumber,1
        dec bx
        mov number,0
        add number,48
        
    
    upper_diamond_start:
    
    upper_diamond_loop1:   ;spacing
    
        ;-----new------
        push dx ;new_pushing dx 
        mov dh,0 ;clearing dh 
        ;-----new end----
        
        mov dl,' ' ;spacing
        mov ah,02h
        int 21h
        
        ;-----new-------
        pop dx ; new_poping dx
        inc dl ;increasing col
        ;-----new end-----
        
        cmp bx,0
        jne upper_diamond_loop_zone
        jmp end 

    upper_diamond_loop_zone:   
    loop upper_diamond_loop1
         
         mov al,display_count ;new
         mov count,al         ;new
         upper_diamond_loop_3: ;displaying number
         
         dec count 
         
         ;--------new--------
         mov al,number ;new
         push cx       ;new
         push bx       ;new
         
         mov bl,colour
         mov cx,1
         CALL DisplayColour
         inc dl ;increasing col
         
         
         CALL increase_colour
         pop bx
         pop cx
         mov al,count
         cmp al,halfnumber
         
         ;--------end new-----
         
         ja  upper_diamond_increase
         dec number
         jmp upper_diamond_skip
         upper_diamond_increase:
            inc number
         
         upper_diamond_skip:
         
         
         
         cmp count,1
         jne upper_diamond_loop_3
         mov cx,bx
    loop upper_diamond_loop_2
    ret
    
    
upper_diamond endp 

lower_diamond proc 
    ;downside diamond
    CALL Newline
    inc dh ;new row
    add display_count,2
    mov bx,0
    mov bl,range
    inc bl
    mov halfnumber,bl
    inc halfnumber 
    mov dl,0;reset column
    
    mov cx,1
    
    mov al,display_count
    mov count,al
    mov number,0
    add number,48
       
       
       
       
    lower_diamond_loop_1:   ;displaying number
       dec count
       mov al,number ;new
         push cx       ;new
         push bx       ;new
         
         mov bl,colour
         mov cx,1
         CALL DisplayColour
         inc dl ;increasing col
         CALL increase_colour
         pop bx
         pop cx
         mov al,count
         cmp al,halfnumber
         
        jae  lower_diamond_increase
        dec number
        jmp lower_diamond_skip
        lower_diamond_increase:
        inc number
     
        lower_diamond_skip:
       
       
       cmp count,1
       jne lower_diamond_loop_1
       
    lower_diamond_loop_2:
       inc dh
       CALL Newline
       mov dl,0 ;reseting row
       
       sub display_count,2
       mov al,display_count
       mov count,al 
       dec bx
       mov number,0
       add number,48
       dec halfnumber

    lower_diamond_loop_3: 
    
       push dx ;new_pushing dx 
       mov dh,0 ;clearing dh 
    
    
       mov dl,' '
       mov ah,02h
       int 21h
       
       pop dx ; new_poping dx
       inc dl ;increasing col
    
    loop lower_diamond_loop_3
       mov cx,0
       mov cl,range
       add cl,2
       sub cx,bx
       CMP bx,0
       je diamond_end 
       cmp count,1
       jne lower_diamond_loop_1
       
    loop lower_diamond_loop_2
    diamond_end:
    ret   
    
lower_diamond endp

numberPattern proc 
    CALL CLS
    mov ah,09h
    lea dx,messageRange
    int 21h
    
    
    mov ah, 01h
    int 21h                    
    MOV BH, AL
    
    sub bh,48
    mov range,bh
    
    CALL Newline 
    
    CALL upper_diamond
    CALL lower_diamond
    
    CALL RESET
    CALL AGAIN
    ret
        
        
numberPattern endp        



;-------number pattern function end------ 

;-------design pattern function start---- 

first_design proc
    
    mov cx,3
    mov ah,02h
    
    loop_first_design_1:
        mov dl,' '
        int 21h
        
    loop loop_first_design_1
    mov dl,'#'
    int 21h
    mov cx,2
    int 21h
    loop_first_design_2:
        mov dl,' '
        int 21h
        
      
    loop loop_first_design_2
    
    dec bl
    ret
    
first_design endp



second_design proc   
    mov cx,4 
    mov dh,0
    mov ah,02h
    
    loop_second_design_1:
        
        cmp dh,2
        je skip_second_design_1_1
        mov dl,' '
        int 21h
        jmp skip_second_design_1_2
        
    
    skip_second_design_1_1:
        mov dl,'#'
        int 21h
    
    skip_second_design_1_2:
        inc dh
        loop loop_second_design_1
        
        mov cx,3
        mov dh,0  
        
    
    loop_second_design_2:
        
        cmp dh,1
        je skip_second_design_2_1
        mov dl,' '
        int 21h
        jmp skip_second_design_2_2
        
    
    skip_second_design_2_1:
        mov dl,'#'
        int 21h
    
    skip_second_design_2_2:
        inc dh
        loop loop_second_design_2
        dec bl
    
    ret
    
second_design endp


third_design proc
   
    mov cx,4 
    mov dh,0
    mov ah,02h
    
    loop_third_design_1:
        
        cmp dh,1
        je skip_third_design_1_1
        mov dl,' '
        int 21h
        jmp skip_third_design_1_2
        
    
    skip_third_design_1_1:
        mov dl,'#'
        int 21h
    
    skip_third_design_1_2:
        inc dh
        loop loop_third_design_1
        
        mov cx,3
        mov dh,0  
        
    
    loop_third_design_2:
        
        cmp dh,2
        je skip_third_design_2_1
        mov dl,' '
        int 21h
        jmp skip_third_design_2_2
        
    
    skip_third_design_2_1:
        mov dl,'#'
        int 21h
    
    skip_third_design_2_2:
        inc dh
        loop loop_third_design_2
        dec bl
    
    ret
    
third_design endp


fourth_design proc
    mov cx,4 
    mov dh,0
    mov ah,02h
    
    loop_fourth_design_1:
        
        cmp dh,0
        je skip_fourth_design_1_1
        mov dl,' '
        int 21h
        jmp skip_fourth_design_1_2
        
    
    skip_fourth_design_1_1:
        mov dl,'#'
        int 21h
    
    skip_fourth_design_1_2:
        inc dh
        loop loop_fourth_design_1
        
        mov cx,3
        mov dh,0  
        
    
    loop_fourth_design_2:
        
        cmp dh,3
        je skip_fourth_design_2_1
        mov dl,' '
        int 21h
        jmp skip_fourth_design_2_2
        
    
    skip_fourth_design_2_1:
        mov dl,'#'
        int 21h
    
    skip_fourth_design_2_2:
        inc dh
        loop loop_fourth_design_2
        
        
        dec bl 
        cmp bl,0
        je skip_last_design_1_1
        jmp skip_last_design_1_2
        
    skip_last_design_1_1:
            mov dl,'#'
            int 21h
    skip_last_design_1_2:

    ret
    
fourth_design endp


design_pattern proc 
    
    mov ax,0
    mov bx,0
    mov cx,0
    mov dx,0
    
    
    mov ah,09h
    lea dx,messageDesign
    int 21h
    
    
    mov ah, 01h
    int 21h                    
    MOV BL, AL
    SUB BL,48
    MOV shapesize,bl
    CALL Newline
    mov bl,shapesize
    
    DESIGN_START_FIRST_1:
    CALL first_design
    cmp bl,0
    jne DESIGN_START_FIRST_1
    
    CALL Newline
    
    mov bl,shapesize
    DESIGN_START_SECOND_1:
    CALL second_design
    cmp bl,0
    jne DESIGN_START_SECOND_1 
                  
    CALL Newline
    
    mov bl,shapesize
    DESIGN_START_THIRD_1:
    CALL third_design
    cmp bl,0
    jne DESIGN_START_THIRD_1  
    
    CALL Newline
    
    mov bl,shapesize
    DESIGN_START_FOURTH:
    CALL fourth_design
    cmp bl,0
    jne DESIGN_START_FOURTH 
    
    CALL Newline
    
    mov bl,shapesize
    DESIGN_START_THIRD_2:
    CALL third_design
    cmp bl,0
    jne DESIGN_START_THIRD_2
    
    CALL Newline
    
    mov bl,shapesize
    DESIGN_START_SECOND_2:
    CALL second_design
    cmp bl,0
    jne DESIGN_START_SECOND_2  
    
    CALL Newline
    
    mov bl,shapesize
    DESIGN_START_FIRST_2:
    CALL first_design
    cmp bl,0
    jne DESIGN_START_FIRST_2 
    
    CALL RESET
    CALL AGAIn

design_pattern endp    


;-------design pattern function end------


;-------box pattern function start------
first_char proc
    mov count,9
    mov  dl, 0 ;Column 
    
    
    mov cx,1    ;set to display 1 word pertime
    first_char_start:
    mov  al, char1
    CALL DisplayColour
    
    inc dl ;next coloumn
    dec count
    cmp count,0
    je first_char_end
    jmp first_char_start
    first_char_end: 
    ret
            
first_char endp


second_char proc 
    mov count,9
    mov dl,0 ;column
    mov cx,1
    second_char_start:
    
        cmp count,9
        je skip_second_char1
        cmp count,1
        je skip_second_char1

    skip_second_char2:
        mov al,char2
        jmp start_loop_second_char  
    
    skip_second_char1:
        mov al,char1
        
    start_loop_second_char: 
        
        CALL DisplayColour
    
        inc dl ;next coloumn
        dec count
        cmp count,0
        jne second_char_start
        ret
           
second_char endp


third_char proc 
    mov count,9
    mov dl,0 ;column
    mov cx,1
    third_char_start:
    
        cmp count,9
        je skip_third_char1
        cmp count,1
        je skip_third_char1
        
        cmp count,8
        je skip_third_char2
        cmp count,2
        je skip_third_char2
        
    skip_third_char3:
        mov al,char3
        jmp start_loop_third_char

    skip_third_char2:
        mov al,char2
        jmp start_loop_third_char  
    
    skip_third_char1:
        mov al,char1
        
    start_loop_third_char:
        CALL DisplayColour
    
        inc dl ;next coloumn
        dec count
        cmp count,0
        jne third_char_start
        ret
           
    
third_char endp


fourth_char proc 
    mov count,9
    mov dl,0 ;column
    mov cx,1
    
    fourth_char_start:
    
        cmp count,9
        je skip_fourth_char1
        cmp count,1
        je skip_fourth_char1
        
        cmp count,8
        je skip_fourth_char2
        cmp count,2
        je skip_fourth_char2
        
        cmp count,7
        je skip_fourth_char3
        cmp count,3 
        je skip_fourth_char3
        
    skip_fourth_char4:
        mov al,char4
        jmp start_loop_fourth_char
        
    skip_fourth_char3:
        mov al,char3
        jmp start_loop_fourth_char

    skip_fourth_char2:
        mov al,char2
        jmp start_loop_fourth_char  
    
    skip_fourth_char1:
        mov al,char1
        
    start_loop_fourth_char:
        CALL DisplayColour
    
        inc dl ;next coloumn
        dec count
        cmp count,0
        jne fourth_char_start
        ret
    
fourth_char endp

fifth_char proc 
    mov count,9
    mov dl,0 ;column
    mov cx,1

    fifth_char_start:
    
        cmp count,9
        je skip_fifth_char1
        cmp count,1
        je skip_fifth_char1
        
        cmp count,8
        je skip_fifth_char2
        cmp count,2
        je skip_fifth_char2
        
        cmp count,7
        je skip_fifth_char3
        cmp count,3 
        je skip_fifth_char3
        
        cmp count,6
        je skip_fifth_char4
        cmp count,4
        je skip_fifth_char4
        
    skip_fifth_char5:
        mov al,char5
        jmp start_loop_fifth_char
        
    skip_fifth_char4:
        mov al,char4
        jmp start_loop_fifth_char
        
    skip_fifth_char3:
        mov al,char3
        jmp start_loop_fifth_char

    skip_fifth_char2:
        mov al,char2
        jmp start_loop_fifth_char  
    
    skip_fifth_char1:
        mov al,char1
        
    start_loop_fifth_char:
        CALL DisplayColour
    
        inc dl ;next coloumn
        dec count
        cmp count,0
        jne fifth_char_start
        ret
    
fifth_char endp 

boxTypePattern proc
    CALL CLS 

    mov ah,09h
    lea dx,messageBox
    int 21h
    
    mov  bl, 2  ;Color is red
    
    mov ah, 01h
    int 21h                    
    MOV char1, AL  
    mov ah, 01h
    int 21h                    
    MOV char2, AL
    mov ah, 01h
    int 21h                    
    MOV char3, AL  
    mov ah, 01h
    int 21h                    
    MOV char4, AL       
    mov ah, 01h
    int 21h                    
    MOV char5, AL  
     
    
     
    mov  dh, 1  ;Row
    call Newline  
    call first_char 
                  
    inc  bl; change colour              
    inc  dh; nex Row
    call Newline
    call second_char
    
    inc  bl; change colour
    inc  dh; nex Row
    call Newline
    call third_char
    
    inc  bl; change colour
    inc  dh; nex Row 
    call Newline
    call fourth_char
    
    inc  bl; change colour
    inc  dh; nex Row 
    call Newline
    call fifth_char 
    
    inc  bl; change colour
    inc  dh; nex Row
    call Newline
    call fifth_char 
    
    inc  bl; change colour
    inc  dh; nex Row
    call Newline
    call fourth_char
    
    inc  bl; change colour
    inc  dh; nex Row
    call Newline
    call third_char 
    
    inc  bl; change colour
    inc  dh; nex Row
    call Newline
    call second_char
    
    inc  bl; change colour
    inc  dh; nex Row
    call Newline
    call first_char
    
    
    CALL RESET
    CALL AGAIN
    
    
   
    
boxTypePattern endp


;-------box pattern function end--------

;-------nestedloop function start-------

;Nestedloop_again proc
;            CALL Newline
;            mov ah,09h            
;            lea dx,againLine
;            int 21h
;            
;            mov ah, 01h
;            int 21h                    
;            MOV BH, AL
;            
;            sub bh,48
;            mov count,bh
;            CALL Newline
;            
;            cmp count,1
;            JNE end
;            JMP nestedLoopPattern_menu
;            ret 
;Nestedloop_again endp            


nestedLoopPattern01 proc
    
    CALL CLS
    
    mov colour,10
    mov dh,1
    mov dl,0    
    mov cx,1
    mov bx,5
    jmp NP01start
    
    NP01L1:
        dec bx
        CMP bx,4
        JE  NP01L2
        CALL Newline
        inc dh
        mov dl,0
        
    
    NP01L2:
        
        push dx
        push cx
        push bx
        
        mov bl,colour    
        mov al,"*"
        mov cx,1
        CALL DisplayColour
      
        
        pop bx
        pop cx
        pop dx
        inc dl
        
        
    NP01start:
    
    loop NP01L2

    mov cx,7
    sub cx,bx
    CMP bx,0
    JE  nestedLoopPattern01_end ;jmp to end

    loop NP01L1
    nestedLoopPattern01_end: 
    
        ;CALL RESET
;        CALL Nestedloop_again  
        ret
    
nestedLoopPattern01 endp 


nestedLoopPattern02 proc
                
    mov colour,12
    mov cx, 7
    mov bx, 6
    mov dh,1
    mov dl,7
    jmp NP02start
    
    NP02L1:       
        dec bx
        CALL Newline
        mov dl,7
        inc dh                                     
        
    
    NP02L2: 
    
        push dx
        push cx
        push bx
        
        mov bl,colour    
        mov al,"*"
        mov cx,1
        CALL DisplayColour
       
        pop bx
        pop cx
        pop dx
        inc dl
    
    
    NP02start:
    
        loop NP02L2       
        
        mov cx,bx

        loop NP02L1
         
        ;CALL RESET 
;        CALL Nestedloop_again  
        ret
                
                
nestedLoopPattern02 endp 

nestedLoopPattern03 proc 
        
    ;CALL CLS 
    
    mov colour,14
    mov cx,1
    mov bx,5
    mov count,1 
    mov dh,8
    mov dl,0
     
    
    jmp NP03start
    NP03L1:
        dec bx
        CMP bx,4
        JE  NP03L2
        CALL Newline
        mov count,1
        inc dh
        mov dl,0
        
    
    NP03L2:
        
        
        mov al,count
        mov number,al
        mov al,number
        add al,48 
        inc count
        push dx
        push cx
        push bx   
        
        mov bl,colour
        mov cx,1
        CALL DisplayColour
        
        
        pop bx
        pop cx
        pop dx 
        inc dl
        
    NP03start:
    
        loop NP03L2
        
        mov cx,7
        sub cx,bx
        CMP bx,0
        JE  nestedLoopPattern03_end
   
    loop NP03L1
    
    nestedLoopPattern03_end: 
    
        ;CALL RESET
;        CALL Nestedloop_again
        ret
            
nestedLoopPattern03 endp

nestedLoopPattern04 proc 
     ;CALL CLS
     mov count,1
     mov cx, 7
     mov bx, 6
     mov number, 1
     mov dl,7
     mov dh,8
     jmp NP04start
     
    NP04L1:       
        dec bx
        
        CALL Newline
        inc count
        mov al,count
        mov number,al
        
        inc dh
        mov dl,7                                      
        
    
    NP04L2: 
    
        
        mov al,number
        add al,48 
        inc number
        
        push bx
        push cx
        push dx
         
        mov cx,1
        mov bl,colour
        CALL DisplayColour
        CALL increase_colour
        
        pop dx
        pop cx
        pop bx
        inc dl
    
    
    
    
    NP04start:
    
        loop NP04L2       
        
        mov cx,bx
    
        loop NP04L1
        
        ;CALL RESET
        ;CALL Nestedloop_again 
        ret       

nestedLoopPattern04 endp

;-------nestedloop function end---------



;-------functions end---------------   


;-------program start--------------    
   
Main proc
    mov ax,@data
    mov ds,ax  
    call banner_menu
    start:
        call main_menu

    end:
    
        mov ah,4ch
        int 21h

    
Main endp
end main

;-------program end---------------