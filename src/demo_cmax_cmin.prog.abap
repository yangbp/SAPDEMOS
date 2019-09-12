REPORT demo_cmax_cmin.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:  txt TYPE string,
           max TYPE string,
           min TYPE string,
           msg TYPE string.
    txt = `one two three four five six seven eight nine ten`.
    max = | |.
    min = |§|.
    DO.
      TRY.
          max = cmax( val1 = max
                      val2 = segment( val   = txt
                                      index = sy-index sep = ` ` ) ).
          min = cmin( val1 = min
                      val2 = segment( val   = txt
                                      index = sy-index sep = ` ` ) ).
        CATCH cx_sy_strg_par_val.
          EXIT.
      ENDTRY.
    ENDDO.
    cl_demo_output=>display(
      |Maximum is { max } and minimum is { min }| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
