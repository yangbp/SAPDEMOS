REPORT demo_raise_message_reuse_attr.

CLASS msg_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS meth EXCEPTIONS exception.
ENDCLASS.

CLASS msg_demo IMPLEMENTATION.
  METHOD main.
    TRY.
        meth( EXCEPTIONS exception = 4 ).
        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE cx_demo_t100
            MESSAGE ID sy-msgid
                    NUMBER sy-msgno
            EXPORTING text1 = conv #( sy-msgv1 )
                      text2 = conv #( sy-msgv2 )
                      text3 = conv #( sy-msgv3 )
                      text4 = conv #( sy-msgv4 ).
        ENDIF.
      CATCH cx_demo_t100 INTO DATA(oref).
        cl_demo_output=>display(
          |Caught exception:\n\n| &&
          |"{ oref->get_text( ) }"| ).
        MESSAGE oref TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.
  METHOD meth.
    MESSAGE e888(sabapdemos) WITH 'I' 'am' 'an' 'Exception!'
                             RAISING exception.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  msg_demo=>main( ).
