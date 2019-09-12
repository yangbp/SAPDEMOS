REPORT demo_sel_screen_function_key.

TABLES sscrfields.

SELECTION-SCREEN BEGIN OF SCREEN 1100.
PARAMETERS: p_carrid TYPE s_carr_id,
            p_cityfr TYPE s_from_cit.
SELECTION-SCREEN: FUNCTION KEY 1,
                  FUNCTION KEY 2.
SELECTION-SCREEN END OF SCREEN 1100.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
      WHEN'FC01'.
      p_carrid = 'LH'.
      p_cityfr = 'Frankfurt'.
    WHEN 'FC02'.
      p_carrid = 'UA'.
      p_cityfr = 'Chicago'.
  ENDCASE.

CLASS start DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS start IMPLEMENTATION.
  METHOD main.

    sscrfields-functxt_01 = 'LH'.
    sscrfields-functxt_02 = 'UA'.

    CALL SELECTION-SCREEN 1100 STARTING AT 10 10.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  start=>main( ).
