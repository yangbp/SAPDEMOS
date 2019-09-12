REPORT demo_db_locator.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: otr_text_locator TYPE REF TO cl_abap_db_c_locator,
          length           TYPE i,
          hits             TYPE i,
          avg              TYPE p DECIMALS 2.

    DATA: pattern  TYPE string VALUE 'ABAP',
          language TYPE sy-langu.

    language = sy-langu.
    cl_demo_input=>add_field( CHANGING field = pattern ).
    cl_demo_input=>request(   CHANGING field = language ).

    TRY.
        SELECT text
               FROM sotr_textu
               WHERE langu = @language
               INTO @otr_text_locator.

          length = length + otr_text_locator->get_length( ).

          IF otr_text_locator->find( start_offset = 0
                                     pattern      = pattern ) <> -1.
            hits = hits + 1.
          ENDIF.

          otr_text_locator->close( ).
        ENDSELECT.
      CATCH cx_lob_sql_error.
        WRITE 'Exception in locator' COLOR = 6.
        RETURN.
    ENDTRY.

    avg = length / sy-dbcnt.

    cl_demo_output=>display(
      |Average length of strings in database table: { avg }\n\n| &&
      |Occurrences of "{ pattern WIDTH = strlen( pattern ) }" | &&
      |in strings of database table: { hits }| ).
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  demo=>main( ).
