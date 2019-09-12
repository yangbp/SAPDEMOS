REPORT demo_dynpro_f1_help.

DATA:  text     TYPE c LENGTH 30,
       docu_num TYPE c LENGTH 4,
       int      TYPE i,
       links    TYPE TABLE OF tline,
       field5   TYPE c LENGTH 10,
       field6   TYPE c LENGTH 10.

TABLES demof1help.

text = text-001.

CALL SCREEN 100.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE f1_help_field4 INPUT.
  int = int + 1.
  CASE int.
    WHEN 1.
      docu_num = '0100'.
    WHEN 2.
      docu_num = '0200'.
      int = 0.
  ENDCASE.
ENDMODULE.

MODULE f1_help_field5 INPUT.
  CALL FUNCTION 'HELP_OBJECT_SHOW_FOR_FIELD'
       EXPORTING
            doklangu         = sy-langu
            doktitle         = text-002
            called_for_tab   = 'DEMOF1HELP'
            called_for_field = 'FIELD1'.
ENDMODULE.

MODULE f1_help_field6 INPUT.
  CALL FUNCTION 'HELP_OBJECT_SHOW'
       EXPORTING
            dokclass = 'TX'
            doklangu = sy-langu
            dokname  = 'DEMO_FOR_F1_HELP'
            doktitle = text-003
       TABLES
            links    = links.
ENDMODULE.
