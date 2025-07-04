#include <windows.h>

#include "printtbl.h"


typedef struct
{
    int     startX;
    int     width;
} COLUMN;

static COLUMN *colBody;         // ��ࠬ���� �⮫�殢 ⠡����
static int     colNum;          // ������⢮ �⮫�殢 ⠡����
static int     rowY;            // ⥪��� ���न��� Y, ��� �뢮�� ��ப � ⠡����


static int pageWidth;           // �ਭ� � ���� ��࠭���
static int pageHeight;
static int pageSkip;            // ������ ��࠭���


static PRINTDLG prnDlg;
static DOCINFO docInfo;
static HGDIOBJ pageFont;        // ⥪�騩 䮭�
static int fontHeight;          // ࠧ��� 䮭� �� ����


/*


ScaleColumns C         @@hList: HWND, @@nColumn: DWORD, @@width: DWORD:?
        call    ScaleColumns, [@@hList], 6, 18, 16, 10, 40, 8, 8

*/



/*
  �뢮� �� �ਭ�� ��।��� ��ப� ⠡����.
  �� �室�:
    nRow  - ����� ��ப�
    ...   - ��ப� ��� ࠭�� �������� �⮫�殢 ����� ��ப�
*/
void __cdecl __export prn_Insert(int nCols, ...)
{
    RECT r;
    va_list argptr;
    int i;
    TCHAR *name;
    HGDIOBJ oldFnt;
    HPEN oldPen;

    oldFnt = SelectObject(prnDlg.hDC, pageFont);
    oldPen = SelectObject(prnDlg.hDC, CreatePen(PS_SOLID, 1, 0x000000));

    if (rowY >= (pageHeight+pageSkip/2))
    {
        EndPage(prnDlg.hDC);
        StartPage(prnDlg.hDC);
        rowY = pageSkip/2;
    }

    va_start(argptr, nCols);

    for (i = 0; i < colNum; i++)
    {
        if (i < nCols)
            name = va_arg(argptr, TCHAR * );
        else
            name = NULL;

        r.left   = colBody[i].startX;
        r.top    = rowY;
        r.right  = colBody[i].startX+colBody[i].width;
        r.bottom = rowY + fontHeight;
        Rectangle(prnDlg.hDC, r.left, r.top, r.right, r.bottom);
        if (name)
            DrawText(prnDlg.hDC, name, -1, &r, DT_CENTER | DT_SINGLELINE | DT_VCENTER);
        else
            DrawText(prnDlg.hDC, TEXT(" "), -1, &r, DT_CENTER | DT_SINGLELINE | DT_VCENTER);
    }
    va_end(argptr);
    rowY += fontHeight;

    SelectObject(prnDlg.hDC, oldFnt);
    SelectObject(prnDlg.hDC, oldPen);
}




int __cdecl __export prn_Begin(TCHAR *docName, int nColumns, ...)
{
    va_list argptr;
    int curWidth;
    int totalWidth;
    int curX;

    if (nColumns > MAX_COLUMNS)
        return FALSE;

    /*
      ��⮢�� ��࠭��� ��� �뢮�� �� �ਭ�� (�롮� �ਭ�� �
      �ਥ���� ��࠭���)
    */
    memset(&prnDlg, 0, sizeof(PRINTDLG));
    prnDlg.lStructSize = sizeof(PRINTDLG);
    prnDlg.Flags = PD_RETURNDC;
    // prnDlg.Flags |= PD_DISABLEPRINTTOFILE|PD_HIDEPRINTTOFILE|PD_NOPAGENUMS|PD_NOSELECTION;
    if (!PrintDlg(&prnDlg))
    {
        return FALSE;
    }

    if (prnDlg.hDC == NULL)
    {
        return FALSE;
    }
    memset(&docInfo, 0, sizeof(DOCINFO));
    docInfo.cbSize = sizeof(DOCINFO);
    docInfo.lpszDocName = docName;
    StartDoc(prnDlg.hDC, &docInfo);
    StartPage(prnDlg.hDC);

    /*
      ����砥� �ࠪ���⨪� ���ன�⢠ � ᮧ��� 䮭�
    */
    pageSkip = GetDeviceCaps(prnDlg.hDC, LOGPIXELSX);   // �祪 �� �, �㤥� ����㯮�
    pageWidth  = GetDeviceCaps(prnDlg.hDC, HORZRES) - pageSkip;   // �ਭ� ���� � ���ᥫ�� � ���⮬ ����㯮�
    pageHeight = GetDeviceCaps(prnDlg.hDC, VERTRES) - pageSkip;   // ���� ���� � ���ᥫ�� � ���⮬ ����㯮�

    colNum  = 0;
    colBody = NULL;
    rowY = pageSkip/2;

    /*
      �뤥�塞 ������ ��� �⮫���
    */
    colBody = malloc(sizeof(COLUMN) * nColumns);
    if (!colBody)
        return FALSE;

    /*
      ���樠�����㥬 �⮫���
    */
    totalWidth = 0;
    curX = pageSkip/2;
    va_start(argptr, nColumns);
    while (nColumns && totalWidth < 100)
    {
        // 㧭�� �ਭ� ��।���� �⮫��
        curWidth = va_arg(argptr, int );
        totalWidth += curWidth;
        if (totalWidth > 100)
        {
            curWidth = curWidth - (totalWidth - 100);
        }
        if (curWidth)
        {
            colBody[colNum].startX = curX;
            // ��ॢ���� �ਭ� � ��業�� � ���ᥫ�
            colBody[colNum].width = MulDiv(curWidth, pageWidth, 100);
            // ������塞 ⥪���� ���न���� �� X
            curX += colBody[colNum].width;
            colNum++;
        }

        nColumns--;
    }
    va_end(argptr);


    /*
      ᮧ��� 䮭�
    */
    if (pageWidth < pageHeight)
        fontHeight  = pageHeight / DEF_ROWS_ON_PAGE;
    else
        fontHeight  = pageHeight / (DEF_ROWS_ON_PAGE * 0.7);

    pageFont = CreateFont(MulDiv(fontHeight, 6, 10), 0,0,0, FW_NORMAL, FALSE, FALSE, FALSE,
                   DEFAULT_CHARSET, OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS,
                   PROOF_QUALITY, DEFAULT_PITCH | FF_DONTCARE, TEXT(DEF_FNT_NAME));

    /*
      ��࠭�� ��⮢�
    */

    return TRUE;
}

void __cdecl __export prn_End()
{
    if (colBody)
        free(colBody);

    colBody = NULL;
    colNum = 0;

    EndPage(prnDlg.hDC);
    EndDoc(prnDlg.hDC);
    DeleteDC(prnDlg.hDC);  // ?
    DeleteObject(pageFont);
}

