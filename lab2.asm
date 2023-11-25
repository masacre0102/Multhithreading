section .data
    turn dd 0
    flag1 dd 0
    flag2 dd 0

section .text
global _start

_start:
    ; Процес 1
    ; Крок 1: Встановити flag1 на 1
    mov eax, 1
    xchg eax, [flag1]

    ; Крок 2: Зробити перевірку flag2 та turn
    mov ebx, [flag2]
    mov ecx, [turn]
    cmp ebx, 0
    jz .critical_section_1
    jmp .start
    
.critical_section_1:
    ; Крок 3: Критична секція процесу 1

    ; Крок 4: Завершення процесу 1
    mov eax, 0
    xchg eax, [flag1]

    ; Процес 2
    ; Крок 1: Встановити flag2 на 1
    mov eax, 1
    xchg eax, [flag2]

    ; Крок 2: Зробити перевірку flag1 та turn
    mov ebx, [flag1]
    mov ecx, [turn]
    cmp ebx, 0
    jz .critical_section_2
    jmp .start

.critical_section_2:
    ; Крок 3: Критична секція процесу 2

    ; Крок 4: Завершення процесу 2
    mov eax, 0
    xchg eax, [flag2]
 
    ; Крок 5: Змінити чергу (turn)
    mov eax, 1
    xchg eax, [turn]
   
    ; Крок 6: Завершення
   