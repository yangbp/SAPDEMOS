REPORT demo_raise_exception.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: oref    TYPE REF TO cx_demo_constructor,
          text     TYPE string,
          position TYPE i.
    TRY.
        TRY.
            RAISE EXCEPTION TYPE cx_demo_constructor
              EXPORTING
                my_text = sy-repid.
          CATCH cx_demo_constructor INTO oref.
            text = oref->get_text( ).
            oref->get_source_position(
              IMPORTING  source_line  = position ).
            cl_demo_output=>WRITE_text( |{ position } { text }| ).
            RAISE EXCEPTION oref.
        ENDTRY.
      CATCH cx_demo_constructor INTO oref.
        text = oref->get_text( ).
        oref->get_source_position(
          IMPORTING source_line  = position ).
        cl_demo_output=>WRITE_text( |{ position } { text }| ).
    ENDTRY.
    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
