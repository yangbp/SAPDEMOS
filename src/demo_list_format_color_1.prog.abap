REPORT demo_list_format_color_1 .

DATA i TYPE i VALUE 0.
DATA col(15) TYPE c.

WHILE i < 8.

  CASE i.
    WHEN 0. col = 'COL_BACKGROUND '.
    WHEN 1. col = 'COL_HEADING    '.
    WHEN 2. col = 'COL_NORMAL     '.
    WHEN 3. col = 'COL_TOTAL      '.
    WHEN 4. col = 'COL_KEY        '.
    WHEN 5. col = 'COL_POSITIVE   '.
    WHEN 6. col = 'COL_NEGATIVE   '.
    WHEN 7. col = 'COL_GROUP      '.
  ENDCASE.

  FORMAT INTENSIFIED COLOR = i.
  WRITE: /(4) i, AT 7            sy-vline,
            col,                 sy-vline,
            col INTENSIFIED OFF, sy-vline,
            col INVERSE.

  i = i + 1.

ENDWHILE.
