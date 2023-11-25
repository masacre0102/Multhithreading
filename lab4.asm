timerID dd 1 ; Timer ID
timerInterval dd 600000 ; 10 minutes in milliseconds


TimerProc :
    ; логіка збереження
    push offset editHandle ; hWnd
    call dword ptr [GetWindowTextLengthA] ; user32.dll
    add eax, 1 ; Include null terminator
    lea ebx, [eax+1] ; Size of buffer needed

    ; виділення пам`яті для буферу
    push ebx ; nSize
    call dword ptr [GlobalAlloc] ; kernel32.dll
    mov esi, eax ; esi points to allocated buffer

    ; отримання тексту з елемента редагування
    push ebx ; nBufferMax
    push esi ; lpBuffer
    push eax ; hWnd
    call dword ptr [GetWindowTextA] ; user32.dll

    ; відкриттся файлу для
    push offset fileName ; File path
    push 1 ; dwCreationDisposition (CREATE_ALWAYS)
    call dword ptr [CreateFileA] ; kernel32.dll
    mov ebx, eax ; ebx points to the file handle

    ; запис тексту у файл
    push ebx ; hFile
    push esi ; lpBuffer
    push eax ; nNumberOfBytesToWrite
    push offset bytesWritten ; lpNumberOfBytesWritten
    call dword ptr [WriteFile] ; kernel32.dll

    ; закриття файлу
    push ebx ; hFile
    call dword ptr [CloseHandle] ; kernel32.dll

    ; Звільнення виділеного буферу
    push esi ; hMem
    call dword ptr [GlobalFree] ; kernel32.dll

    ; знову засетити таймер на 10 хв
    push timerInterval ; uElapse
    push 0 ; hWnd
    push timerID ; nIDEvent
    push offset TimerProc ; lpTimerFunc
    call dword ptr [SetTimer] ; user32.dll

    ret
