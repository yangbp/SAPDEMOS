REPORT demo_dynpro_status_icons.

DATA value TYPE i VALUE 1.

DATA: status_icon TYPE icons-text,
      icon_name(20) TYPE c,
      icon_text(10) TYPE c.

CALL SCREEN 100.

MODULE set_icon OUTPUT.

  SET PF-STATUS 'SCREEN_100'.

  CASE value.
    WHEN 1.
      icon_name = 'ICON_GREEN_LIGHT'.
      icon_text =  text-003.
    WHEN 2.
      icon_name = 'ICON_YELLOW_LIGHT'.
      icon_text =  text-002.
    WHEN 3.
      icon_name = 'ICON_RED_LIGHT'.
      icon_text =  text-001.
  ENDCASE.

  CALL FUNCTION 'ICON_CREATE'
       EXPORTING
            name                  = icon_name
            text                  = icon_text
            info                  = 'Status'
            add_stdinf            = 'X'
       IMPORTING
            result                = status_icon
       EXCEPTIONS
            icon_not_found        = 1
            outputfield_too_short = 2
            OTHERS                = 3.

  CASE sy-subrc.
    WHEN 1.
      MESSAGE e888(sabapdemos) WITH text-004.
    WHEN 2.
      MESSAGE e888(sabapdemos) WITH text-005.
    WHEN 3.
      MESSAGE e888(sabapdemos) WITH text-006.
  ENDCASE.

ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE change.
  CASE value.
    WHEN 1.
      value = 2.
    WHEN 2.
      value = 3.
    WHEN 3.
      value = 1.
  ENDCASE.
ENDMODULE.
