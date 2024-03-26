section .data
    newline db 10        ; newline character

section .bss
    buffer resb 1

section .text
    global _start

_start:
    ; Read a character from stdin
    mov eax, 3           ; sys_read system call number
    mov ebx, 0           ; file descriptor: stdin
    mov ecx, buffer      ; buffer to read into
    mov edx, 1           ; number of bytes to read
    int 0x80             ; invoke system call

    cmp byte[buffer], 65
    jge check_uppercase ; check decimals 65 and above 
    jl display_symbol   ; display 64 and below

    check_uppercase: 
        cmp byte[buffer], 91
        jge check_lowercase ; check 91 and above
        jl  convert_to_lowercase    ;convert 90 and below

    check_lowercase:
        cmp byte[buffer], 97
        jl display_symbol ; display 96 and below

        cmp byte[buffer], 123
        jl convert_to_uppercase ;convert 122 and below 
        jge display_symbol ; display 123 and above

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
        ; Display a new line
        mov eax, 4           ; sys_write system call number
        mov ebx, 1           ; file descriptor: stdout
        mov ecx, newline     ; pointer to the newline character
        mov edx, 1           ; length of the newline character
        int 0x80             ; invoke system call

        ; Exit the program
        mov eax, 1           ; sys_exit system call number
        xor ebx, ebx         ; exit code 0
        int 0x80             ; invoke system call