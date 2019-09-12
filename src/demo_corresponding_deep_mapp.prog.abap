REPORT demo_corresponding_deep_mapp.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    CLASS-DATA:
      BEGIN OF struct1,
        a1 TYPE string VALUE `a1_XX`,
        a2 TYPE string VALUE `a2_XX`,
        BEGIN OF istruct,
          a1 TYPE string VALUE `a1_YY`,
          a2 TYPE string VALUE `a2_YY`,
        END OF istruct,
        itab LIKE STANDARD TABLE OF struct1-istruct WITH EMPTY KEY,
      END OF struct1,
      BEGIN OF struct2,
        b1 TYPE string,
        a2 TYPE string,
        BEGIN OF istruct,
          b1 TYPE string,
          a2 TYPE string,
        END OF istruct,
        jtab LIKE STANDARD TABLE OF struct2-istruct WITH EMPTY KEY,
      END OF struct2.
    TYPES:
      BEGIN OF out1,
        a1 LIKE struct1-a1,
        a2 LIKE struct1-a2,
      END OF out1,
      BEGIN OF out2,
        a1 LIKE struct2-b1,
        a2 LIKE struct2-a2,
      END OF out2.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->begin_section( `struct1`
      )->write( CORRESPONDING out1( struct1 )
      )->write( struct1-istruct
      )->write( struct1-itab ).

    struct2 = CORRESPONDING #( struct1 ).
    out->next_section(
      `struct2 = CORRESPONDING #( struct1 )`
      )->write( CORRESPONDING out2( struct2 )
      )->write( struct2-istruct
      )->write( struct2-jtab ).

    struct2 = CORRESPONDING #( struct1 MAPPING jtab = itab ).
    out->next_section(
      `struct2 = CORRESPONDING #( struct1 MAPPING jtab = itab )`
      )->write( CORRESPONDING out2( struct2 )
      )->write( struct2-istruct
      )->write( struct2-jtab ).

    struct2 = CORRESPONDING #( struct1 MAPPING
               ( istruct = istruct MAPPING b1 = a1 EXCEPT a2 )
               ( jtab = itab MAPPING b1 = a1 ) ).
    out->next_section(
      `struct2 = CORRESPONDING #( struct1  MAPPING ( ... ) )`
      )->write( CORRESPONDING out2( struct2 )
      )->write( struct2-istruct
      )->write( struct2-jtab ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    struct1-itab = VALUE #(
      ( a1 = `a1_xx` a2 = `a2_xx` )
      ( a1 = `a1_yy` a2 = `a2_yy` ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
