REPORT demo_dynpro_f4_help_module .

TYPES: BEGIN OF values,
         carrid TYPE spfli-carrid,
         connid TYPE spfli-connid,
       END OF values.

DATA: carrier(3) TYPE c,
      connection(4) TYPE c.

DATA: progname TYPE sy-repid,
      dynnum   TYPE sy-dynnr,
      dynpro_values TYPE TABLE OF dynpread,
      field_value LIKE LINE OF dynpro_values,
      values_tab TYPE TABLE OF values.

CALL SCREEN 100.

MODULE init OUTPUT.
  progname = sy-repid.
  dynnum   = sy-dynnr.
  CLEAR: field_value, dynpro_values.
  field_value-fieldname = 'CARRIER'.
  APPEND field_value TO dynpro_values.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE value_carrier INPUT.

  CALL FUNCTION 'F4IF_FIELD_VALUE_REQUEST'
       EXPORTING
            tabname     = 'DEMOF4HELP'
            fieldname   = 'CARRIER1'
            dynpprog    = progname
            dynpnr      = dynnum
            dynprofield = 'CARRIER'.

ENDMODULE.

MODULE value_connection INPUT.

  CALL FUNCTION 'DYNP_VALUES_READ'
       EXPORTING
            dyname             = progname
            dynumb             = dynnum
            translate_to_upper = 'X'
       TABLES
            dynpfields         = dynpro_values.

  field_value = dynpro_values[ 1 ].

  SELECT  carrid, connid
    FROM  spfli
    WHERE carrid = @field_value-fieldvalue
    INTO  CORRESPONDING FIELDS OF TABLE @values_tab.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
       EXPORTING
            retfield    = 'CONNID'
            dynpprog    = progname
            dynpnr      = dynnum
            dynprofield = 'CONNECTION'
            value_org   = 'S'
       TABLES
            value_tab   = values_tab.

ENDMODULE.
