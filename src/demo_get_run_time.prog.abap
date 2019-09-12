REPORT demo_get_run_time.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: t1 TYPE i,
          t2 TYPE i,
          t  TYPE p DECIMALS 2.

    DATA n TYPE i value 10.
    cl_demo_input=>request(
      EXPORTING text  = 'Number of measurements'
      CHANGING  field = n ).

    DATA: toff  TYPE p DECIMALS 2,
          tsel1 TYPE p DECIMALS 2,
          tsel2 TYPE p DECIMALS 2.

    DATA sbook_wa TYPE sbook.

    t = 0.
    DO n TIMES.
      GET RUN TIME FIELD t1.
      GET RUN TIME FIELD t2.
      t2 = t2 - t1.
      t = t + t2 / n.
    ENDDO.
    toff = t.
    cl_demo_output=>write( |Mean Offset Runtime: {
                            toff } microseconds| ).
    t = 0.
    DO n TIMES.
      GET RUN TIME FIELD t1.

      SELECT *
             FROM sbook
             INTO @sbook_wa.
      ENDSELECT.

      GET RUN TIME FIELD t2.
      t2 = t2 - t1.
      t = t + t2 / n.
    ENDDO.
    tsel1 = t - toff.
    cl_demo_output=>write( |Mean Runtime SELECT * : {
                            tsel1 } microseconds| ).
    t = 0.
    DO n TIMES.
      GET RUN TIME FIELD t1.

      SELECT carrid, connid
             FROM sbook
             INTO (@sbook_wa-carrid, @sbook_wa-connid).
      ENDSELECT.

      GET RUN TIME FIELD t2.
      t2 = t2 - t1.
      t = t + t2 / n.
    ENDDO.
    tsel2 = t - toff.
    cl_demo_output=>display( |Mean Runtime SELECT list : {
                             tsel2 } microseconds| ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
