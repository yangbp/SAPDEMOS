*&---------------------------------------------------------------------*
*& Report  DEMO_DROPDOWN_LIST_BOX                                      *
*&---------------------------------------------------------------------*

REPORT demo_dropdown_list_box.

* Dynpro Interfaces

TABLES sdyn_conn.
DATA   ok_code TYPE sy-ucomm.

* Local class definition

CLASS dynpro_utilities DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS value_help.
ENDCLASS.

* Local class implementation

CLASS dynpro_utilities IMPLEMENTATION.
  METHOD value_help.
    TYPES: BEGIN OF carrid_line,
             carrid   TYPE spfli-carrid,
             carrname TYPE scarr-carrname,
           END OF carrid_line.
    DATA carrid_list TYPE STANDARD TABLE OF carrid_line.
    SELECT carrid, carrname
                FROM scarr
                INTO CORRESPONDING FIELDS OF TABLE @carrid_list.
    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
         EXPORTING
              retfield        = 'CARRID'
              value_org       = 'S'
         TABLES
              value_tab       = carrid_list
         EXCEPTIONS
              parameter_error = 1
              no_values_found = 2
              OTHERS          = 3.
    IF sy-subrc <> 0.
      ...
    ENDIF.
  ENDMETHOD.
ENDCLASS.

* Event Blocks and Dialog Modules

START-OF-SELECTION.
  CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'SELECTED'.
      MESSAGE i888(sabapdemos) WITH sdyn_conn-carrid.
  ENDCASE.
ENDMODULE.

MODULE create_dropdown_box INPUT.
  dynpro_utilities=>value_help( ).
ENDMODULE.
