CLASS example_data DEFINITION.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF struc,
        idx        TYPE i,
        name        TYPE string,
        postal_code TYPE i,
      END OF struc,
      tabtype TYPE STANDARD TABLE OF struc.
    CLASS-METHODS get_table IMPORTING lines TYPE i DEFAULT 10000
                            EXPORTING table TYPE ANY TABLE.

ENDCLASS.                    "lcl_irs DEFINITION

CLASS example_data IMPLEMENTATION.

  METHOD get_table.

    DATA wa TYPE struc.

    CLEAR table.
    wa-name = sy-uname.
    DO lines TIMES.
      wa-idx = wa-postal_code = sy-index.
      INSERT wa INTO TABLE table.
    ENDDO.
  ENDMETHOD.

ENDCLASS.

CLASS measure DEFINITION.
  PUBLIC SECTION.
    CONSTANTS     n_mess  TYPE i VALUE 1000.
    CLASS-METHODS runtime IMPORTING lines        TYPE i
                          RETURNING value(rtime) TYPE decfloat16.
ENDCLASS.
