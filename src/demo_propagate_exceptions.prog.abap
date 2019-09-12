REPORT  demo_propagate_exceptions.

CLASS a_class DEFINITION.
  PUBLIC SECTION.
    METHODS foo IMPORTING p TYPE string
                 RAISING cx_demo_constructor cx_demo_abs_too_large.
ENDCLASS.

CLASS b_class DEFINITION.
  PUBLIC SECTION.
    DATA a TYPE REF TO a_class.
    METHODS bar RAISING cx_demo_constructor.
  ENDCLASS.

    DATA b TYPE REF TO b_class.

START-OF-SELECTION.

  CREATE OBJECT b.

  TRY.
      b->bar( ).
    CATCH cx_demo_constructor.
      cl_demo_output=>display( 'Catching CX_DEMO_CONSTRUCTOR' ).
  ENDTRY.

CLASS a_class IMPLEMENTATION.
  METHOD foo.
    RAISE EXCEPTION TYPE cx_demo_constructor.
  ENDMETHOD.
ENDCLASS.

CLASS b_class IMPLEMENTATION.
  METHOD bar.
    CREATE OBJECT a.
    TRY.
        ...
        a->foo( 'SOMETHING' ).
        ...
      CATCH cx_demo_abs_too_large.
        ...
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
