REPORT demo_conv_type_inference.

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

    demo=>meth1( p = CONV #( txt  ) ) ##operator.
    demo=>meth1( p = CONV #( num  ) ).
    demo=>meth1( p = CONV #( <fs> ) ).
    cl_demo_output=>line( ).

    demo=>meth2( p = CONV #( txt  ) ) ##operator.
    demo=>meth2( p = CONV #( num  ) ).
   "demo=>meth2( p = CONV #( <fs> ) ). "not possible
    cl_demo_output=>line( ).

    demo=>meth3( p = CONV #( txt  ) ) ##operator.
    demo=>meth3( p = CONV #( num  ) ) ##type.
    demo=>meth3( p = CONV #( <fs> ) ) ##type.
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
