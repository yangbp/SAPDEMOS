REPORT demo_field_symbols_assign_type.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA txt(8) TYPE c VALUE '20050606'.

    DATA mytype(1) VALUE 'X'.

    FIELD-SYMBOLS <fs> TYPE ANY.

    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'Cast with built-in types' ).

    ASSIGN txt TO <fs>.
    out->write( |<fs> with inherited type c: { <fs> }| ).

* correct -------------------------------------------------------------

    ASSIGN txt TO <fs> CASTING TYPE i.
    out->write( |<fs> casted with i: { <fs> }| ).

    ASSIGN txt TO <fs> CASTING TYPE (mytype).
    out->write( |<fs> casted with x: { <fs> }| ).

    out->display( ).

* obsolete, not allowed in methods ------------------------------------

    "ASSIGN txt TO <fs> TYPE 'D'.

    "ASSIGN txt TO <fs> TYPE mytype.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
