REPORT demo_characters_in_lists.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES tcode  TYPE x LENGTH 2.
    DO 65536 TIMES.
      TRY.
          DATA(code) = CONV tcode( sy-index - 1 ).
          DATA(char) = |{ cl_abap_conv_in_ce=>uccp( code ) WIDTH = 1 }|.
          WRITE: / code,  char.
        CATCH  cx_sy_conversion_codepage.
          WRITE: / code, 'not in codpeage'.
      ENDTRY.
    ENDDO.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
