struc DATE_STRUCT
         year                   dw ?
        month                   dw ?
        day                     dw ?
ends
typedef SQL_DATE_STRUCT         DATE_STRUCT
struc TIME_STRUCT
        hour                    dw ?
        minute                  dw ?
        second                  dw ?
ends
typedef SQL_TIME_STRUCT         TIME_STRUCT
struc TIMESTAMP_STRUCT
        year                    dw ?
        month                   dw ?
        day                     dw ?
        hour                    dw ?
        minute                  dw ?
        second                  dw ?
        fraction                dd ?
ends
typedef SQL_TIMESTAMP_STRUCT    TIMESTAMP_STRUCT
SQL_IS_YEAR                     equ 1
SQL_IS_MONTH                    equ 2
SQL_IS_DAY                      equ 3
SQL_IS_HOUR                     equ 4
SQL_IS_MINUTE                   equ 5
SQL_IS_SECOND                   equ 6
SQL_IS_YEAR_TO_MONTH            equ 7
SQL_IS_DAY_TO_HOUR              equ 8
SQL_IS_DAY_TO_MINUTE            equ 9
SQL_IS_DAY_TO_SECOND            equ 10
SQL_IS_HOUR_TO_MINUTE           equ 11
SQL_IS_HOUR_TO_SECOND           equ 12
SQL_IS_MINUTE_TO_SECOND         equ 13
struc SQL_YEAR_MONTH_STRUCT
                year            dd    ?
                month           dd    ?
ends
struc SQL_DAY_SECOND_STRUCT
                day             dd    ?
                hour            dd    ?
                minute          dd    ?
                second          dd    ?
                fraction        dd    ?
ends

struc SQL_INTERVAL_STRUCT
        interval_type           dd    ?
        interval_sign           dd    ?
        union
                year_month      SQL_YEAR_MONTH_STRUCT <>
                day_second      SQL_DAY_SECOND_STRUCT <>
        ends
ends
SQL_MAX_NUMERIC_LEN             equ 16
struc SQL_NUMERIC_STRUCT
        precision               db ?
        scale                   db ?
        sign                    db ?
        val                     db SQL_MAX_NUMERIC_LEN dup(?)
ends
struc SQLGUID
    Data1                       dd ?
    Data2                       dw ?
    Data3                       dw ?
    Data4                       db 8 dup(?)
ends
