REPORT demo_list_top_of_page NO STANDARD PAGE HEADING
                             LINE-SIZE 80 LINE-COUNT 7.

DATA: h1(10) TYPE c VALUE '    Number',
      h2(10) TYPE c VALUE '    Square',
      h3(10) TYPE c VALUE '      Cube',
      n1 TYPE i, n2 TYPE i, n3 TYPE i,
      x TYPE i.

TOP-OF-PAGE.

  x = sy-colno + 8.  POSITION x. WRITE h1.
  x = sy-colno + 8.  POSITION x. WRITE h2.
  x = sy-colno + 8.  POSITION x. WRITE h3.
  x = sy-colno + 16. POSITION x. WRITE sy-pagno.
  ULINE.

START-OF-SELECTION.

  DO 10 TIMES.
    n1 = sy-index. n2 = sy-index ** 2. n3 = sy-index ** 3.
    NEW-LINE.
    WRITE: n1 UNDER h1,
           n2 UNDER h2,
           n3 UNDER h3.
  ENDDO.
