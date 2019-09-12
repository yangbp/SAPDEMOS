REPORT demo_reduce_method_call.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS to_string IMPORTING wa          TYPE scarr
                            RETURNING VALUE(text) TYPE string.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA carriers TYPE TABLE OF scarr.
    SELECT * FROM scarr INTO TABLE @carriers.

    DATA out TYPE REF TO if_demo_output.
    out = REDUCE #(
            INIT o = cl_demo_output=>new( )
            FOR wa IN carriers
            NEXT o = o->write( to_string( wa ) ) ).
    out->display( ).
  ENDMETHOD.
  METHOD to_string.
    DO.
      ASSIGN COMPONENT sy-index OF STRUCTURE wa TO FIELD-SYMBOL(<wa>).
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.
      DESCRIBE FIELD <wa> OUTPUT-LENGTH DATA(olen).
      text = |{ text }{ CONV string( <wa> ) WIDTH = olen + 2 }|.
    ENDDO.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
