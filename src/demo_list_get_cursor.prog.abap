REPORT demo_list_get_cursor NO STANDARD PAGE HEADING LINE-SIZE 40.

DATA: hotspot(10) TYPE c VALUE 'Click me!',
      f(10) TYPE c, off TYPE i, lin TYPE i, val(40) TYPE c, len TYPE i.

FIELD-SYMBOLS <fs> TYPE ANY.
ASSIGN hotspot TO <fs>.
WRITE 'Demonstration of GET CURSOR statement'.
SKIP TO LINE 4.
POSITION 20.
WRITE <fs> HOTSPOT COLOR 5 INVERSE ON.

AT LINE-SELECTION.

  WINDOW STARTING AT 5 6 ENDING AT 45 20.
  GET CURSOR FIELD f OFFSET off
             LINE lin VALUE val LENGTH len.
  WRITE: 'Result of GET CURSOR FIELD: '.
  ULINE AT /(28).
  WRITE: / 'Field: ', f,
         / 'Offset:', off,
         / 'Line:  ', lin,
         / 'Value: ', (10) val,
         / 'Length:', len.
  SKIP.
  GET CURSOR LINE lin OFFSET off VALUE val LENGTH len.
  WRITE: 'Result of GET CURSOR LINE: '.
  ULINE AT /(27).
  WRITE: / 'Offset:', off,
         / 'Value: ', val,
         / 'Length:', len.
