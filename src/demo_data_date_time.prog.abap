REPORT demo_data_date_time.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: ultimo TYPE d,
          t1 TYPE t VALUE '000000',
          t2 TYPE t,
          diff TYPE i,
          seconds TYPE i,
          hours TYPE i.

    "date calculation

    ultimo      = sy-datlo.
    ultimo+6(2) = '01'.
    ultimo      = ultimo - 1.
    cl_demo_output=>write(
      |Last day of last month: { ultimo }| ).

    "time calculation

    t2 = sy-timlo.
    diff = t2 - t1.
    seconds = diff MOD 86400.
    hours = seconds / 3600.
    cl_demo_output=>display(
      |Number of hours since midnight: { hours }| ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
