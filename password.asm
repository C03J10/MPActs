section .data
    newline db 10
    input db 'Enter Password: ', 0
    weak_msg db 'Weak Password', 0
    strong_msg db 'Strong Password', 0       

section .bss
    buffer resb 254 

section .text
    global _start

_start:

    mov eax, 4          
    mov ebx, 1           
    mov ecx, input
    mov edx, 16  
    int 0x80  

    mov eax, 3           
    mov ebx, 0           
    mov ecx, buffer      
    mov edx, 254         
    int 0x80             

    mov ecx, 0
    jmp cal_length

    cal_length:
        cmp byte [ buffer + ecx ], 0
        je compare_pass

        inc ecx
        jmp cal_length

    compare_pass:
        cmp ecx, 8 ; NOTE somehow it prints as strong for 7 characters so i changed it a bit
        jle is_weak_pass
        jg is_strong_pass
        
    is_strong_pass:
        mov eax, 4          
        mov ebx, 1           
        mov ecx, strong_msg
        mov edx, 15  
        int 0x80
        jmp exit_program

    is_weak_pass:
        mov eax, 4          
        mov ebx, 1           
        mov ecx, weak_msg
        mov edx, 13  
        int 0x80
        jmp exit_program

    exit_program:

        mov eax, 4          
        mov ebx, 1           
        mov ecx, newline
        mov edx, 1  
        int 0x80

        mov eax, 1           
        xor ebx, ebx         
        int 0x80             