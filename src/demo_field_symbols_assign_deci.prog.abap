REPORT demo_field_symbols_assign_deci.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: pack1 TYPE p DECIMALS 2 VALUE '400',
          pack2 TYPE p DECIMALS 2,
          pack3 TYPE p DECIMALS 2.

    FIELD-SYMBOLS: <f1> TYPE ANY ,
                   <f2> TYPE ANY.

    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'Cast of decimal places' ).

    out->write_data( pack1 ).

* correct --------------------------------------------------------------

    ASSIGN pack1 TO <f1> CASTING TYPE p DECIMALS 1.
    out->write( |<f1>: { <f1> }| ).

    pack2 = <f1>.
    out->write( |pack2: { pack2 }| ).

    ASSIGN pack2 TO <f2> CASTING TYPE p DECIMALS 4.
    out->write( |<f2>: { <f2> }| ).

    pack3 = <f1> + <f2>.
    out->write( |pack3: { pack3 }| ).

    <f2> = '1234.56789'.
    out->write( |<f2>: { <f2> }| ).
    out->write( |pack2: { pack2 }| ).

    out->display( ).

* obsolete, not allowed in methods -------------------------------------

    "ASSIGN pack1 TO <f1> DECIMALS 1.

    "pack2 = <f1>.

    "ASSIGN pack2 TO <f2> DECIMALS 4.

    "pack3 = <f1> + <f2>.

    "<f2> = '1234.56789'.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
