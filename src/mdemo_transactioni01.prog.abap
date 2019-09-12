*----------------------------------------------------------------------*
*   INCLUDE MTZ10I01                                                   *
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       Fetch data from SPFL or exit from transaction                  *
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'SHOW'.
      CLEAR ok_code.
      SELECT SINGLE *
             FROM spfli
             WHERE carrid = @spfli-carrid
               AND connid = @spfli-connid
             INTO @spfli.
      spfli_wa = spfli.
    WHEN space.
    WHEN OTHERS.
      CLEAR ok_code.
      SET SCREEN 0. LEAVE SCREEN.
  ENDCASE.
ENDMODULE.                             " USER_COMMAND_0100  INPUT
