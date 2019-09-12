REPORT demo_cond_type_inference.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    TYPES c10 TYPE c LENGTH 10.
    CLASS-METHODS:
      main,
      meth1 IMPORTING p TYPE c10,
      meth2 IMPORTING p TYPE c,
      meth3 IMPORTING p TYPE csequence,
      descr IMPORTING p TYPE any.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    FIELD-SYMBOLS <fs> TYPE any.
    DATA txt TYPE c LENGTH 20.
    DATA num TYPE i.
    ASSIGN num TO <fs>.

    demo=>meth1( p = COND #( WHEN 1 = 1 THEN txt ) ).
    demo=>meth1( p = COND #( WHEN 1 = 1 THEN txt ) ).
    demo=>meth1( p = COND #( WHEN 1 = 1 THEN <fs> ) ).
    cl_demo_output=>line( ).

    demo=>meth2( p = COND #( WHEN 1 = 1 THEN txt ) ).
   "demo=>meth2( p = COND #( WHEN 1 = 1 THEN num ) ).  "not possible
   "demo=>meth2( p = COND #( WHEN 1 = 1 THEN <fs> ) ). "not possible
    cl_demo_output=>line( ).

    demo=>meth3( p = COND #( WHEN 1 = 1 THEN txt ) ).
    demo=>meth3( p = COND #( WHEN 1 = 1 THEN num ) )  ##type.
    demo=>meth3( p = COND #( WHEN 1 = 1 THEN <fs> ) ) ##type.
    cl_demo_output=>display( ).
  ENDMETHOD.
  METHOD meth1.
    descr( p ).
  ENDMETHOD.
  METHOD meth2.
    descr( p ).
  ENDMETHOD.
  METHOD meth3.
    descr( p ).
  ENDMETHOD.
  METHOD descr.
    DATA type   TYPE string.
    DATA length TYPE i.
    DESCRIBE FIELD p TYPE type.
    IF type = 'g'.
      type = 'STRING'.
      length = strlen( p ).
    ELSE.
      DESCRIBE FIELD p LENGTH length IN CHARACTER MODE.
    ENDIF.
    cl_demo_output=>write( |{ type } { length }| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
