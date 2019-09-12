REPORT demo_is_instance_of.

INTERFACE intf.
ENDINTERFACE.

CLASS c1 DEFINITION.
  PUBLIC SECTION.
    INTERFACES intf.
ENDCLASS.

CLASS c2 DEFINITION INHERITING FROM c1.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      oref  TYPE REF TO object,
      iref  TYPE REF TO intf,
      c1ref TYPE REF TO c1,
      c2ref TYPE REF TO c2.

    FIELD-SYMBOLS <fs> TYPE any.

    DATA(out) = cl_demo_output=>new( ).

    out->next_section( `Reference Variable Not Initial`).

    out->begin_section( `TYPE REF TO object`).
    oref = NEW c1( ).
    ASSERT oref IS NOT INSTANCE OF c2.
    out->write( `oref pointing to c1 is not instance of c2` ).
    ASSERT oref IS INSTANCE OF c1.
    out->write( `oref pointing to c1 is instance of c1` ).
    ASSERT oref IS INSTANCE OF intf.
    out->write( `oref pointing to c1 is instance of intf` ).
    oref = NEW c2( ).
    ASSERT oref IS INSTANCE OF c2.
    out->write( `oref pointing to c2 is instance of c2` ).
    ASSERT oref IS INSTANCE OF c1.
    out->write( `oref pointing to c2 is instance of c1` ).
    ASSERT oref IS INSTANCE OF intf.
    out->write( `oref pointing to c2 is instance of intf` ).
    out->end_section( ).

    out->begin_section( `TYPE REF TO intf`).
    iref = NEW c1( ).
    ASSERT iref IS NOT INSTANCE OF c2.
    out->write( `iref pointing to c1 is not instance of c2` ).
    ASSERT iref IS INSTANCE OF c1.
    out->write( `iref pointing to c1 is instance of c1` ).
    ASSERT iref IS INSTANCE OF intf.
    out->write( `iref pointing to c1 is instance of intf` ).
    iref = NEW c2( ).
    ASSERT iref IS INSTANCE OF c2.
    out->write( `iref pointing to c2 is instance of c2` ).
    ASSERT iref IS INSTANCE OF c1.
    out->write( `iref pointing to c2 is instance of c1` ).
    ASSERT iref IS INSTANCE OF intf.
    out->write( `iref pointing to c2 is instance of intf` ).
    out->end_section( ).

    out->begin_section( `TYPE REF TO c1`).
    c1ref = NEW c1( ).
    ASSERT c1ref IS NOT INSTANCE OF c2.
    out->write( `c1ref pointing to c1 is not instance of c2` ).
    ASSERT c1ref IS INSTANCE OF c1.
    out->write( `c1ref pointing to c1 is instance of c1` ).
    ASSERT c1ref IS INSTANCE OF intf.
    out->write( `c1ref pointing to c1 is instance of intf` ).
    c1ref = NEW c2( ).
    ASSERT c1ref IS INSTANCE OF c2.
    out->write( `c1ref pointing to c2 is instance of c2` ).
    ASSERT c1ref IS INSTANCE OF c1.
    out->write( `c1ref pointing to c2 is instance of c1` ).
    ASSERT c1ref IS INSTANCE OF intf.
    out->write( `c1ref pointing to c2 is instance of intf` ).
    out->end_section( ).

    out->begin_section( `TYPE REF TO c2`).
    c2ref = NEW c2( ).
    ASSERT c2ref IS INSTANCE OF c2.
    out->write( `c2ref pointing to c2 is instance of c2` ).
    ASSERT c2ref IS INSTANCE OF c1.
    out->write( `c2ref pointing to c2 is instance of c1` ).
    ASSERT c2ref IS INSTANCE OF intf.
    out->write( `c2ref pointing to c2 is instance of intf` ).
    out->end_section( ).

    out->next_section( `Reference Variable Initial`).

    out->begin_section( `TYPE REF TO object`).
    ASSIGN oref TO <fs>.
    CLEAR <fs>.
    ASSERT <fs> IS NOT INSTANCE OF c1.
    out->write( `oref pointing to nothing is not instance of c1` ).
    ASSERT <fs> IS NOT INSTANCE OF c2.
    out->write( `oref pointing to nothing is not instance of c2` ).
    ASSERT <fs> IS NOT INSTANCE OF intf.
    out->write( `oref pointing to nothing is not instance of intf` ).
    out->end_section( ).

    out->begin_section( `TYPE REF TO intf`).
    ASSIGN iref TO <fs>.
    CLEAR <fs>.
    ASSERT <fs> IS NOT INSTANCE OF c1.
    out->write( `iref pointing to nothing is not instance of c1` ).
    ASSERT <fs> IS NOT INSTANCE OF c2.
    out->write( `iref pointing to nothing is not instance of c2` ).
    ASSERT <fs> IS INSTANCE OF intf.
    out->write( `iref pointing to nothing is instance of intf` ).
    out->end_section( ).

    out->begin_section( `TYPE REF TO c1`).
    ASSIGN c1ref TO <fs>.
    CLEAR <fs>.
    ASSERT <fs> IS INSTANCE OF c1.
    out->write( `c1ref pointing to nothing is instance of c1` ).
    ASSERT <fs> IS NOT INSTANCE OF c2.
    out->write( `c1ref pointing to nothing is not instance of c2` ).
    ASSERT <fs> IS INSTANCE OF intf.
    out->write( `c1ref pointing to nothing is instance of intf` ).
    out->end_section( ).

    out->begin_section( `TYPE REF TO c2`).
    ASSIGN c2ref TO <fs>.
    CLEAR <fs>.
    ASSERT <fs> IS INSTANCE OF c1.
    out->write( `c2ref pointing to nothing is instance of c1` ).
    ASSERT <fs> IS INSTANCE OF c2.
    out->write( `c2ref pointing to nothing is instance of c2` ).
    ASSERT <fs> IS INSTANCE OF intf.
    out->write( `c2ref pointing to nothing is instance of intf` ).
    out->end_section( ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
