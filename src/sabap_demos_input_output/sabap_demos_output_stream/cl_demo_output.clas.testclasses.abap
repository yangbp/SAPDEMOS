*"* use this source file for your ABAP unit test classes

CLASS test_names DEFINITION FOR TESTING FINAL
                 DURATION SHORT
                 RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
"      names_scan  TYPE TABLE OF string WITH EMPTY KEY,
      names_anl TYPE TABLE OF string WITH EMPTY KEY,
      names       TYPE TABLE OF string WITH EMPTY KEY.
    DATA:
      m_test1 TYPE i.
    CLASS-DATA:
      s_test1 TYPE i.
    METHODS:
      test_names FOR TESTING,
      "write_scan    IMPORTING value    TYPE data ##needed
      "              RETURNING VALUE(r) TYPE REF TO test_names,
      write     IMPORTING value    TYPE data ##needed
                    RETURNING VALUE(r) TYPE REF TO test_names,
      "get_name_scan  RETURNING VALUE(name) TYPE string,
      get_name_anl   RETURNING VALUE(name) TYPE string.
ENDCLASS.


CLASS test_names IMPLEMENTATION.
  METHOD test_names.

    DATA l_test1 TYPE i.
    DATA l_test2 TYPE i.
    DATA l_test3 TYPE i.
    DATA l_test4 TYPE i.
    DATA:
      BEGIN OF l_struct,
        col1 TYPE i,
      END OF l_struct.
    DATA l_string TYPE string.

    "me->write_scan( l_test1 ).
    me->write( l_test1 ).
    APPEND `L_TEST1` TO names.
    "me->write_scan( m_test1 ).
    me->write( m_test1 ).
    APPEND `M_TEST1` TO names.
    "me->write_scan( s_test1 ).
    me->write( s_test1 ).
    APPEND `S_TEST1` TO names.
    "me->write_scan( me->m_test1 ).
    me->write( me->m_test1 ).
    APPEND `ME->M_TEST1` TO names.
    "me->write_scan( test_names=>s_test1 ).
    me->write( test_names=>s_test1 ).
    APPEND `TEST_NAMES=>S_TEST1` TO names.

    "me->write_scan( l_test2 )->write_scan( l_test3 )->write_scan( l_test4 ).
    me->write( l_test2 )->write( l_test3 )->write( l_test4 ).
    APPEND `L_TEST2` TO names.
    APPEND `L_TEST3` TO names.
    APPEND `L_TEST4` TO names.

    "me->write_scan( l_struct-col1 ).
    me->write( l_struct-col1 ).
    APPEND `L_STRUCT-COL1` TO names.

    "me->write_scan( 4 ).
    me->write( 4 ).
    APPEND `` TO names.

    "me->write_scan( to_upper( l_string ) ).
    me->write( to_upper( l_string ) ).
    APPEND `` TO names.

*    cl_abap_unit_assert=>assert_equals(
*      EXPORTING
*        act                  = names_scan
*        exp                  = names
*        msg                  = 'Wrong names' ) ##no_text .
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = names_anl
        exp                  = names
        msg                  = 'Wrong names' ) ##no_text .


  ENDMETHOD.
*  METHOD write_scan.
*    APPEND get_name_scan( ) TO names_scan.
*    r = me.
*  ENDMETHOD.
  METHOD write.
    APPEND get_name_anl( ) TO names_anl.
    r = me.
  ENDMETHOD.
*  METHOD get_name_scan.
*    DATA: lt_stack TYPE         abap_callstack,
*          ls_stack TYPE LINE OF abap_callstack,
*          lt_lines TYPE TABLE OF abap_callstack_line-line,
*          idx      TYPE sy-tabix.
*    FIELD-SYMBOLS <ls_stack> TYPE LINE OF abap_callstack.
*    CALL FUNCTION 'SYSTEM_CALLSTACK'
*      IMPORTING
*        callstack = lt_stack.
*    READ TABLE lt_stack INTO ls_stack WITH KEY blockname = 'TEST_NAMES'.
*    idx = sy-tabix.
*    LOOP AT lt_stack ASSIGNING <ls_stack> FROM idx.
*      APPEND <ls_stack>-line TO lt_lines.
*    ENDLOOP.
*    TRY.
*        name = code_scan=>get_par_name( stack_frame = ls_stack
*                                        lines       = lt_lines ).
*      CATCH cx_name.
*        CLEAR name.
*    ENDTRY.
*  ENDMETHOD.
  METHOD get_name_anl.
    DATA: lt_stack TYPE         abap_callstack,
    lt_lines TYPE TABLE OF abap_callstack_line-line,
    ls_stack TYPE LINE OF abap_callstack,
    idx      TYPE sy-tabix.
    FIELD-SYMBOLS <ls_stack> TYPE LINE OF abap_callstack.
    CALL FUNCTION 'SYSTEM_CALLSTACK'
      IMPORTING
        callstack = lt_stack.
    READ TABLE lt_stack INTO ls_stack WITH KEY blockname = 'TEST_NAMES'.
    idx = sy-tabix.
    LOOP AT lt_stack ASSIGNING <ls_stack> FROM idx.
      APPEND <ls_stack>-line TO lt_lines.
    ENDLOOP.
    TRY.
        name = code_analysis=>get_par_name( stack_frame = ls_stack
                                            lines       = lt_lines ).
      CATCH cx_name.
        CLEAR name.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
