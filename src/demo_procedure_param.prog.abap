REPORT demo_procedure_param.

CLASS demo_fibb DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF line,
               x TYPE i,
               y TYPE i,
               range TYPE i,
           END OF line.

    CLASS-DATA: param TYPE STANDARD TABLE OF line,
                res TYPE i.
    CLASS-METHODS: main,
                   fill_table  CHANGING  g_param LIKE param,
                   solve_table IMPORTING g_param LIKE param,
                   fibb IMPORTING VALUE(l_line) TYPE line
                        EXPORTING VALUE(r) TYPE i.
ENDCLASS.

CLASS demo_fibb IMPLEMENTATION.
  METHOD main.
    fill_table(  CHANGING  g_param = param ).
    solve_table( EXPORTING g_param = param ).
  ENDMETHOD.

  METHOD fill_table.
    g_param = VALUE #( FOR j = 1 UNTIL j > 3
                       ( x = j
                         y = j ** 2
                         range = 12 / j ) ).
  ENDMETHOD.

  METHOD solve_table.
    DATA l_line LIKE LINE OF g_param.
    LOOP AT g_param INTO l_line.
      fibb( EXPORTING l_line = l_line IMPORTING r = res ).
      cl_demo_output=>write(
      |Fibb( { l_line-x }, { l_line-y }, { l_line-range }) = { res }| ).
    ENDLOOP.
    cl_demo_output=>display( ).
  ENDMETHOD.

  METHOD fibb.
    IF l_line-range = 1.
      IF l_line-x < l_line-y.
        r = l_line-x.
      ELSE.
        r = l_line-y.
      ENDIF.
    ELSEIF l_line-range = 2.
      IF l_line-x < l_line-y.
        r = l_line-y.
      ELSE.
        r = l_line-x.
      ENDIF.
    ELSE.
      l_line-range = l_line-range - 2.
      DO l_line-range TIMES.
        IF l_line-x < l_line-y.
          l_line-x = l_line-x + l_line-y.
          r = l_line-x.
        ELSE.
          l_line-y = l_line-x + l_line-y.
          r = l_line-y.
        ENDIF.
      ENDDO.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo_fibb=>main( ).
