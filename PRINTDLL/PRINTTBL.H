#ifndef __printtbl_h__
#define __printtbl_h__

//#include <sqltypes.h>


#define MAX_COLUMNS 100     // ����. ������⢮ �⮫�殢


// ����⠡ 䮭�
#define DEF_ROWS_ON_PAGE    48      // ������⢮ ��ப �� ��࠭��
#define DEF_FNT_NAME        "Arial" // ��� 䮭�, ��� ����� �� �� �����뢠����

// | 00.00.0000 | 00:00:00 | 00-0 | ����⠭������� ��࠭���� |




#ifdef __cplusplus
  extern "C" {
#endif

/*
  ����⨥ �ਭ�� � �����⮢�� � ����.
  �� �室�:
    docName - ��� ���㬥�� (�� ��砩 ���� � 䠩�)
    nColumns - ������⢮ �⮫�殢 � ���饩 ⠡���
    ... - ���ᨢ �ਭ �⮫�殢 (int), � ��業�� � �ਭ� ��࠭�/����
*/
int __cdecl prn_Begin(TCHAR *docName, int nColumns, ...);

/*
  �����蠥� �����
*/
void __cdecl prn_End();


/*
  �뢮� �� �ਭ�� ��।��� ��ப� ⠡����.
  �� �室�:
    nCols - ������⢮ ��।����� �⮫�殢
    ...   - ��ப� ��� ࠭�� �������� �⮫�殢 ����� ��ப�
*/
void __cdecl prn_Insert(int nCols, ...);










#ifdef __cplusplus
  }
#endif



#endif
