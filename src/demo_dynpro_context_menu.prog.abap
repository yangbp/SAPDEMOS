REPORT demo_dynpro_context_menu.

DATA: field1 TYPE i VALUE 10,
      field2 TYPE p DECIMALS 4.

DATA: prog TYPE sy-repid,
      flag(1) TYPE c VALUE 'X'.

DATA: ok_code TYPE sy-ucomm,
      save_ok TYPE sy-ucomm.

prog = sy-repid.

CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  SET TITLEBAR 'TIT100'.
  IF flag = 'X'.
    SET PF-STATUS 'SCREEN_100' EXCLUDING 'REVEAL'.
  ELSEIF flag = ' '.
    SET PF-STATUS 'SCREEN_100' EXCLUDING 'HIDE'.
  ENDIF.
  LOOP AT SCREEN INTO DATA(screen_wa).
    IF screen_wa-group1 = 'MOD'.
      IF flag = 'X'.
        screen_wa-active = '1'.
      ELSEIF flag = ' '.
        screen_wa-active = '0'.
      ENDIF.
      MODIFY SCREEN FROM screen_wa.
    ELSEIF screen_wa-name = 'TEXT_IN_FRAME'.
      IF flag = 'X'.
        screen_wa-active = '0'.
      ELSEIF flag = ' '.
        screen_wa-active = '1'.
      ENDIF.
      MODIFY SCREEN FROM screen_wa.
    ENDIF.
  ENDLOOP.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command_0100.
  save_ok = ok_code.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'HIDE'.
      flag = ' '.
    WHEN 'REVEAL'.
      flag = 'X'.
    WHEN 'SQUARE'.
      field2 = field1 ** 2.
    WHEN 'CUBE'.
      field2 = field1 ** 3.
    WHEN 'SQUAREROOT'.
      field2 = field1 ** ( 1 / 2 ).
    WHEN 'CUBICROOT'.
      field2 = field1 ** ( 1 / 3 ).
  ENDCASE.
ENDMODULE.

************************************************************
* Callback-Routines:
************************************************************

FORM on_ctmenu_text USING l_menu TYPE REF TO cl_ctmenu.
  l_menu->load_gui_status(
                       EXPORTING program = prog
                                 status  = 'CONTEXT_MENU_1'
                                 menu    = l_menu ).
ENDFORM.

FORM on_ctmenu_frame USING l_menu TYPE REF TO cl_ctmenu.
  l_menu->load_gui_status(
                      EXPORTING program = prog
                                status  = 'CONTEXT_MENU_2'
                                menu    = l_menu ).
  l_menu->load_gui_status(
                      EXPORTING program = prog
                                status  = 'CONTEXT_MENU_1'
                                menu    = l_menu ).
  l_menu->set_default_function(
                      EXPORTING fcode = 'HIDE' ).
ENDFORM.

FORM on_ctmenu_reveal USING l_menu TYPE REF TO cl_ctmenu.
  l_menu->load_gui_status(
                      EXPORTING program = prog
                                status  = 'CONTEXT_MENU_3'
                                menu    = l_menu ).
  l_menu->load_gui_status(
                      EXPORTING program = prog
                                status  = 'CONTEXT_MENU_1'
                                menu    = l_menu ).
  l_menu->set_default_function(
                      EXPORTING fcode = 'REVEAL' ).
ENDFORM.

FORM on_ctmenu_input USING l_menu TYPE REF TO cl_ctmenu.
  DATA calculate_menu TYPE REF TO cl_ctmenu.
  CREATE OBJECT calculate_menu.
  calculate_menu->add_function(
                      EXPORTING fcode = 'SQUARE'
                                text  = text-001 ).
  calculate_menu->add_function(
                       EXPORTING fcode = 'CUBE'
                                 text  = text-002 ).
  calculate_menu->add_function(
                       EXPORTING fcode = 'SQUAREROOT'
                                 text  = text-003 ).
  calculate_menu->add_function(
                       EXPORTING fcode = 'CUBICROOT'
                                 text  = text-004 ).
  l_menu->add_submenu(
                       EXPORTING menu = calculate_menu
                                 text = text-005 ).
ENDFORM.
