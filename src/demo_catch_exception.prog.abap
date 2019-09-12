REPORT demo_catch_exception.

DATA(in) = cl_demo_input=>new( ).
DATA: resumable     TYPE abap_bool VALUE abap_false,
      before_unwind TYPE abap_bool VALUE abap_false,
      resume        TYPE abap_bool VALUE abap_false.
in->add_field( EXPORTING as_checkbox = 'X'
                         text = 'RAISE RESUMABLE'
               CHANGING  field = resumable
 )->add_field( EXPORTING as_checkbox = 'X'
                         text = 'CATCH BEFORE UNWIND'
               CHANGING  field = before_unwind
 )->add_field( EXPORTING as_checkbox = 'X'
                         text = 'RESUME'
               CHANGING  field = resume
 )->request( ).

CLASS lcx_exception DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS exc_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA out TYPE REF TO if_demo_output.
    CLASS-METHODS: main,
      meth1 RAISING lcx_exception,
      meth2 RAISING RESUMABLE(lcx_exception).
ENDCLASS.

FIELD-SYMBOLS <fs> TYPE any.

CLASS exc_demo IMPLEMENTATION.
  METHOD main.
    out = cl_demo_output=>new( ).
    DATA exc TYPE REF TO lcx_exception.
    IF before_unwind = abap_false.
      TRY.
          out->write( 'Trying method call' ).
          IF resumable = abap_false.
            exc_demo=>meth1( ).
          ELSEIF resumable = abap_true.
            exc_demo=>meth2( ).
          ENDIF.
        CATCH lcx_exception.
          IF <fs> IS ASSIGNED.
            out->write( 'Context of method available' ).
          ELSE.
            out->write( 'Context of method not available' ).
          ENDIF.
      ENDTRY.
      out->write( 'Continue after main TRY block' ).
    ELSEIF before_unwind = abap_true.
      TRY.
          out->write( 'Trying method call' ).
          IF resumable = abap_false.
            exc_demo=>meth1( ).
          ELSEIF resumable = abap_true.
            exc_demo=>meth2( ).
          ENDIF.
        CATCH BEFORE UNWIND lcx_exception INTO exc.
          IF <fs> IS ASSIGNED.
            out->write( 'Context of method available' ).
          ELSE.
            out->write( 'Context of method not available' ).
          ENDIF.
          IF resume = abap_true.
            IF exc->is_resumable = abap_true.
              RESUME.
            ELSE.
              out->write( 'Resumption not possible' ).
            ENDIF.
          ENDIF.
      ENDTRY.
      out->write( 'Continue after main TRY block' ).
    ENDIF.
    out->display( ).
  ENDMETHOD.
  METHOD meth1.
    DATA loc TYPE i.
    ASSIGN loc TO <fs>.
    TRY.
        out->write( 'Raising non-resumable exception' ).
        RAISE EXCEPTION TYPE lcx_exception.
        out->write( 'Never executed' ).
      CLEANUP.
        out->write( 'Cleanup in method' ).
    ENDTRY.
    out->write( 'Continue after TRY block in method' ).
  ENDMETHOD.
  METHOD meth2.
    DATA loc TYPE i.
    ASSIGN loc TO <fs>.
    TRY.
        out->write( 'Raising resumable exception' ).
        RAISE RESUMABLE EXCEPTION TYPE lcx_exception.
        out->write( 'Resuming method' ).
      CLEANUP.
        out->write( 'Cleanup in method' ).
    ENDTRY.
    out->write( 'Continue after TRY block in method' ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  exc_demo=>main( ).
