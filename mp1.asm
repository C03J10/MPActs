section .text
    global _start

_start:

    ; Print 'T' character 
    mov   eax, 4      
    mov   ebx, 1      

    push  84
    mov   ecx, esp     
    mov   edx, 1      
    int   80h          

    ; Print new line 
    mov   eax, 4     
    mov   ebx, 1       

    push  10
    mov   ecx, esp    
    mov   edx, 1      
    int   80h         

    add   esp, 4      

    ; Print 'E' character
    mov   eax, 4      
    mov   ebx, 1      
    
    push  69
    mov   ecx, esp    
    mov   edx, 1      
    int   80h         

    add   esp, 4 

    ; Print new line 
    mov   eax, 4     
    mov   ebx, 1       

    push  10
    mov   ecx, esp    
    mov   edx, 1      
    int   80h

    ; System exit
    mov eax,1            
    mov ebx,0            
    int 80h