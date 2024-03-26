section .data
    newline db 10        

section .bss
    buffer resb 1

section .text
    global _start

_start:
    
    mov eax, 3           
    mov ebx, 0           
    mov ecx, buffer      
    mov edx, 1           
    int 0x80             

    cmp byte[buffer], 65
    jge check_uppercase  
    jl display_symbol   

    check_uppercase: 
        cmp byte[buffer], 91
        jge check_lowercase 
        jl  convert_to_lowercase    

    check_lowercase:
        cmp byte[buffer], 97
        jl display_symbol 

        cmp byte[buffer], 123
        jl convert_to_uppercase 
        jge display_symbol 

    display_symbol:
        mov eax, 4          
        mov ebx, 1          
        mov ecx, buffer
        mov edx, 1     
        int 0x80 
        jmp exit_program

    convert_to_lowercase:
        mov eax, 4          
        mov ebx, 1  
        add byte [buffer], 32          
        mov ecx, buffer
        mov edx, 1     
        int 0x80
        jmp exit_program

    convert_to_uppercase:
        mov eax, 4          
        mov ebx, 1  
        sub byte [buffer], 32          
        mov ecx, buffer
        mov edx, 1     
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