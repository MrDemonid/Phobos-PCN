; Создает очередь "первым пришел - первым ушел"
; Элементы хранятся в виде паскаль строк


struc QUEUE
  lpElem        dd ?    ; указатель на массив элементов
  nElem         dd ?    ; размер очереди
  nUsed         dd ?    ; количество эл. в очереди
  nGet          dd ?    ; номер элемента для извлечения
  nPut          dd ?    ; номер элемента для добавления
ends


; создает и инициализирует структуру очереди
; на выходе:
;   eax - адрес очереди или NULL при ошибке
procdesc queue_Create   @@numElem: dword

; уничтожает очередь
procdesc queue_Destroy  @@lpQueue: ptr QUEUE

; проверка очереди на отсутствие элементов
; на выходе:
;   eax - флаг (>0 - очередь пуста, 0 - что-то есть)
procdesc queue_IsEmpty  @@lpQueue: ptr QUEUE


; чтение элемента из очереди
; на выходе:
; eax   - признак успеха (>0 - считали, 0 - очередь пуста)
procdesc queue_Get      @@lpQueue: ptr QUEUE, @@lpElem: ptr byte


; добавление элемента в очередь
; на выходе:
; eax   - признак успеха (>0 - добавили, 0 - очередь переполнена)
procdesc queue_Put      @@lpQueue: ptr QUEUE, @@lpStr: dword, @@nSize: dword
;@@lpElem: ptr ELEM
