REPORT demo_select_single_vs_up_to.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA carrid TYPE sbook-carrid VALUE 'UA'.
    cl_demo_input=>add_field( CHANGING  field = carrid ).
    DATA(n) = 1000.
    cl_demo_input=>request( EXPORTING text  = `Measurements`
                            CHANGING  field = n ).

    DATA key TYPE sbook.
    SELECT SINGLE *
           FROM sbook
           WHERE carrid = @( to_upper( carrid ) )
           INTO @key .
    IF sy-subrc <> 0.
      LEAVE PROGRAM.
    ENDIF.

    DATA wa TYPE sbook.
    DATA itab TYPE TABLE OF sbook WITH EMPTY KEY.

    DATA t1 TYPE i VALUE '10000'.
    DATA t2 TYPE i VALUE '10000'.
    DATA t3 TYPE i VALUE '10000'.
    DATA t4 TYPE i VALUE '10000'.
    DATA t5 TYPE i VALUE '10000'.
    DATA t6 TYPE i VALUE '10000'.

    DO n TIMES.
      "With WHERE condition
      GET RUN TIME FIELD DATA(t1a).
      SELECT SINGLE *
             FROM sbook
             WHERE carrid = @key-carrid AND
                   connid = @key-connid AND
                   fldate = @key-fldate AND
                   bookid = @key-bookid
                   INTO @wa.
      GET RUN TIME FIELD DATA(t1b).
      t1 = nmin( val1 = t1 val2 = t1b - t1a ).

      GET RUN TIME FIELD DATA(t2a).
      SELECT *
             FROM sbook
             WHERE carrid = @key-carrid AND
                   connid = @key-connid AND
                   fldate = @key-fldate AND
                   bookid = @key-bookid
             INTO @wa
             UP TO 1 ROWS.
      ENDSELECT.
      GET RUN TIME FIELD DATA(t2b).
      t2 = nmin( val1 = t2 val2 = t2b - t2a ).

      GET RUN TIME FIELD DATA(t3a).
      SELECT *
             FROM sbook
             WHERE carrid = @key-carrid AND
                   connid = @key-connid AND
                   fldate = @key-fldate AND
                   bookid = @key-bookid
             INTO TABLE @itab
        UP TO 1 ROWS.
      GET RUN TIME FIELD DATA(t3b).
      t3 = nmin( val1 = t3 val2 = t3b - t3a ).

      "Without WHERE condition
      GET RUN TIME FIELD DATA(t4a).
      SELECT SINGLE *
             FROM sbook
             INTO @wa.
      GET RUN TIME FIELD DATA(t4b).
      t4 = nmin( val1 = t4 val2 = t4b - t4a ).

      GET RUN TIME FIELD DATA(t5a).
      SELECT *
             FROM sbook
             INTO @wa
             UP TO 1 ROWS.
      ENDSELECT.
      GET RUN TIME FIELD DATA(t5b).
      t5 = nmin( val1 = t5 val2 = t5b - t5a ).

      GET RUN TIME FIELD DATA(t6a).
      SELECT *
             FROM sbook
             INTO TABLE @itab
             UP TO 1 ROWS.
      GET RUN TIME FIELD DATA(t6b).
      t6 = nmin( val1 = t6 val2 = t6b - t6a ).
    ENDDO.

    cl_demo_output=>display( |\n{ t1 }\n{ t2 }\n{ t3 }\n| &&
                             |\n{ t4 }\n{ t5 }\n{ t6 }\n| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
