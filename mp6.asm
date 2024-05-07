section .data
    newline db 10
    plaintextprompt db 'Enter plain text message: ', 0
    keyprompt db 'Enter key (shift value): ', 0  
    encryptedtextprompt db 'Encrypted Message: ', 0
    
section .bss
    text resb 254 
    key resb 1  

section .text
    global _start

_start:

    mov eax, 4          
    mov ebx, 1           
    mov ecx, plaintextprompt
    mov edx, 26  
    int 0x80  

    mov eax, 3           
    mov ebx, 0           
    mov ecx, text      
    mov edx, 254         
    int 0x80

    mov eax, 4          
    mov ebx, 1           
    mov ecx, keyprompt
    mov edx, 25  
    int 0x80  

    mov eax, 3           
    mov ebx, 0           
    mov ecx, key      
    mov edx, 1         
    int 0x80             

    sub byte [key], '0'

    mov ecx, 0
    jmp text_length
    
    text_length:

        mov al, byte [text + ecx]
        cmp al, 0
        je exit_program

        add al, byte [key]
        mov byte [text + ecx], al

        inc ecx
        jmp text_length

    exit_program:

        mov eax, 4          
        mov ebx, 1           
        mov ecx, encryptedtextprompt
        mov edx, 19
        int 0x80

        mov eax, 4          
        mov ebx, 1           
        mov ecx, text
        mov edx, 254
        int 0x80

        mov eax, 4          
        mov ebx, 1           
        mov ecx, newline
        mov edx, 1  
        int 0x80

        mov eax, 1           
        xor ebx, ebx         
        int 0x80             