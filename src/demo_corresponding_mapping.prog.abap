REPORT demo_corresponding_mapping.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA:
      BEGIN OF struct1,
        a1 TYPE string VALUE `a1_XX`,
        a2 TYPE string VALUE `a2_XX`,
        a3 TYPE string VALUE `a3_XX`,
        a4 TYPE string VALUE `a4_XX`,
      END OF struct1,
      BEGIN OF struct2,
        a1 TYPE string VALUE `a1_YY`,
        a2 TYPE string VALUE `a2_YY`,
        b3 TYPE string VALUE `b3_YY`,
        b4 TYPE string VALUE `b4_YY`,
      END OF struct2.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->begin_section( `struct1`
      )->write( struct1
      )->next_section( `struct2`
      )->write( struct2 ).

    struct2 = CORRESPONDING #( struct1 ).
    out->begin_section(
      `struct2 = CORRESPONDING #( struct1 )`
     )->write( struct2 ).

    struct2 = CORRESPONDING #( struct1 MAPPING b4 = a3 ).
    out->begin_section(
      `struct2 = CORRESPONDING #( struct1 MAPPING b4 = a3 )`
     )->write( struct2 ).

    struct2 = CORRESPONDING #( struct1 MAPPING b4 = a1 ).
    out->begin_section(
      `struct2 = CORRESPONDING #( struct1 MAPPING b4 = a1 )`
     )->write( struct2 ).

    struct2 = CORRESPONDING #( struct1 EXCEPT a1 ).
    out->begin_section(
      `struct2 = CORRESPONDING #( struct1 EXCEPT a1 )`
     )->write( struct2 ).

    struct2 = CORRESPONDING #( struct1  MAPPING b4 = a3 EXCEPT a1 ).
    out->begin_section(
      `struct2 = CORRESPONDING #( struct1 MAPPING b4 = a3 EXCEPT a1 )`
     )->write( struct2 ).

    struct2 = CORRESPONDING #( struct1  MAPPING b4 = a3 EXCEPT * ).
    out->begin_section(
      `struct2 = CORRESPONDING #( struct1 MAPPING b4 = a3 EXCEPT * )`
     )->write( struct2 ).

    struct2 = CORRESPONDING #( struct1 EXCEPT * ).
    out->begin_section(
      `struct2 = CORRESPONDING #( struct1 EXCEPT * )`
     )->write( struct2 ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
