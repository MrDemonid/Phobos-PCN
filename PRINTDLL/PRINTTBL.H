#ifndef __printtbl_h__
#define __printtbl_h__

//#include <sqltypes.h>


#define MAX_COLUMNS 100     // макс. количество столбцов


// масштаб фонта
#define DEF_ROWS_ON_PAGE    48      // количество строк на странице
#define DEF_FNT_NAME        "Arial" // имя фонта, под который все это рассчитывалось

// | 00.00.0000 | 00:00:00 | 00-0 | Восстановление ретранслятора |




#ifdef __cplusplus
  extern "C" {
#endif

/*
  Открытие принтера и подготовка к печати.
  На входе:
    docName - имя документа (на случай печати в файл)
    nColumns - количество столбцов в будущей таблице
    ... - массив ширин столбцов (int), в процентах к ширине экрана/листа
*/
int __cdecl prn_Begin(TCHAR *docName, int nColumns, ...);

/*
  Завершаем печать
*/
void __cdecl prn_End();


/*
  Вывод на принтер очередной строки таблицы.
  на входе:
    nCols - количество переданных столбцов
    ...   - строки для ранее заданных столбцов одной строки
*/
void __cdecl prn_Insert(int nCols, ...);










#ifdef __cplusplus
  }
#endif



#endif
