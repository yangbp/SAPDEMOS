REPORT demo_st_structure.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: BEGIN OF struc1,
            col1 TYPE c LENGTH 10 VALUE 'ABCDEFGHIJ',
            col2 TYPE i VALUE 111,
            BEGIN OF struc2,
              col1 TYPE d VALUE '20040126',
              col2 TYPE t VALUE '084000',
            END OF struc2,
          END OF struc1,
          result LIKE struc1.
    DATA(out) = cl_demo_output=>new( ).
    TRY.
        "Serialization
        CALL TRANSFORMATION demo_st_structure
          SOURCE para = struc1
          RESULT XML data(xml).
        out->write_xml( xml ).
        "Deserialization
        CALL TRANSFORMATION demo_st_structure
          SOURCE XML xml
          RESULT para = result.
        IF result = struc1.
           out->write_text( 'Symmetric transformation!' ).
        ENDIF.
      CATCH cx_st_error.
        out->write_text( 'Error in Simple Transformation' ).
    ENDTRY.
    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
