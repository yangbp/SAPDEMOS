REPORT demo_dynpro_dropdown_listbox.

DATA: name  TYPE vrm_id,
      list  TYPE vrm_values,
      value LIKE LINE OF list.

DATA: wa_spfli TYPE spfli,
      ok_code TYPE sy-ucomm,
      save_ok TYPE sy-ucomm.

TABLES demof4help.

name = 'DEMOF4HELP-CONNID'.

CALL SCREEN 100.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE init_listbox OUTPUT.

  CLEAR: demof4help-connid,
         list.

  SELECT  connid, cityfrom, cityto, deptime
          FROM spfli
          WHERE carrid = @demof4help-carrier2
          INTO CORRESPONDING FIELDS OF @wa_spfli.

    value-key  = wa_spfli-connid.

    WRITE wa_spfli-deptime TO value-text USING EDIT MASK '__:__:__'.

    value-text =
      |{ value-text } { wa_spfli-cityfrom } { wa_spfli-cityto }|.
    APPEND value TO list.

  ENDSELECT.

  IF sy-subrc <> 0.
    MESSAGE 'No connections for that airline' TYPE 'I' DISPLAY LIKE 'E'.
    LEAVE TO SCREEN 100.
  ENDIF.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = name
      values = list.

ENDMODULE.

MODULE user_command_100.
  save_ok = ok_code.
  CLEAR ok_code.
  IF save_ok = 'CARRIER' AND NOT demof4help-carrier2 IS INITIAL.
    LEAVE TO SCREEN 200.
  ELSE.
    SET SCREEN 100.
  ENDIF.
ENDMODULE.

MODULE user_command_200.
  save_ok = ok_code.
  CLEAR ok_code.
  IF save_ok = 'SELECTED'.
    MESSAGE i888(sabapdemos) WITH text-001 demof4help-carrier2
                                          demof4help-connid.
    CLEAR demof4help.
  ENDIF.
ENDMODULE.
