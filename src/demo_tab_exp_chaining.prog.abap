REPORT demo_tab_exp_chaining.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: main,
                   class_constructor.
  PRIVATE SECTION.
    CLASS-DATA: langu TYPE sy-langu,
                index TYPE cl_abap_docu=>abap_index_tab.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    "Read a column of a nested table with table statements
    out->begin_section( `Table Statements` ).
    READ TABLE index WITH KEY key1 = 'ASSIGNING'
                     ASSIGNING FIELD-SYMBOL(<wa1>).
    READ TABLE <wa1>-docu_objects WITH KEY key2 = 'READ TABLE itab'
                                  ASSIGNING FIELD-SYMBOL(<wa2>).
    IF sy-subrc = 0.
      DATA(title1) =
        cl_abap_docu=>get_title(
          langu  = langu
          object = <wa2>-docu_name ).
      out->write_data( title1 ).
    ELSE.
      out->write_text( `Nothing found` ).
    ENDIF.

    "Read a column of a nested table with chained table expressions
    out->next_section( `Table Expressions` ).
    TRY.
        DATA(title2) =
          cl_abap_docu=>get_title(
            langu  = langu
            object = index[ key1 = 'ASSIGNING'
                          ]-docu_objects[ key2 = 'READ TABLE itab'
                          ]-docu_name ).
        out->write_data( title2 ).
      CATCH cx_sy_itab_line_not_found ##no_handler.
        out->write_text( `Nothing found` ).
    ENDTRY.

    out->display( ).

  ENDMETHOD.
  METHOD class_constructor.
    langu = sy-langu.
    IF langu <> 'D'.
      langu = 'E'.
    ENDIF.
    DATA(index) = cl_abap_docu=>get_abap_index( langu = langu ).
    demo=>index = index->*.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
