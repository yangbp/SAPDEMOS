REPORT demo_list_system_fields NO STANDARD PAGE HEADING
                                LINE-COUNT 12 LINE-SIZE 40.

DATA: l TYPE i, t(1) TYPE c.

DO 100 TIMES.
  WRITE: / 'Loop Pass:', sy-index.
ENDDO.

TOP-OF-PAGE.

  WRITE: 'Basic List, Page', sy-pagno.
  ULINE.

TOP-OF-PAGE DURING LINE-SELECTION.

  WRITE 'Secondary List'.
  ULINE.

AT LINE-SELECTION.

  DESCRIBE FIELD sy-lisel LENGTH l IN CHARACTER MODE TYPE t.

  WRITE: 'SY-LSIND:', sy-lsind,
       / 'SY-LISTI:', sy-listi,
       / 'SY-LILLI:', sy-lilli,
       / 'SY-CUROW:', sy-curow,
       / 'SY-CUCOL:', sy-cucol,
       / 'SY-CPAGE:', sy-cpage,
       / 'SY-STARO:', sy-staro,
       / 'SY-LISEL:', 'Length =', l, 'Type =', t,
       /  sy-lisel.
