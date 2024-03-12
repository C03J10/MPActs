section .text
    global _start

_start:

    ; Print 'T' character 
    mov   eax, 4      
    mov   ebx, 1      

    push  'T'
    mov   ecx, esp     
    mov   edx, 1      
    int   80h          

    ; Print new line 
    mov   eax, 4     
    mov   ebx, 1       

    push  0x0A
    mov   ecx, esp    
    mov   edx, 1      
    int   80h         

    add   esp, 4      

    ; Print 'E' character
    mov   eax, 4      
    mov   ebx, 1      
    
    push  'E'
    mov   ecx, esp    
    mov   edx, 1      
    int   80h         

    ; return value in EAX = 1 (byte written), or error (-errno)

    add   esp, 4      ; restore esp if necessary

    ; System exit
    mov eax,1            
    mov ebx,0            
    int 80h