REPORT demo_objects_references.

CLASS counter DEFINITION.
  PUBLIC SECTION.
    METHODS: set IMPORTING VALUE(set_value) TYPE i,
             increment,
             get EXPORTING VALUE(get_value) TYPE i.
  PRIVATE SECTION.
    DATA count TYPE i.
ENDCLASS.

CLASS counter IMPLEMENTATION.
  METHOD set.
    count = set_value.
  ENDMETHOD.
  METHOD increment.
    ADD 1 TO count.
  ENDMETHOD.
  METHOD get.
    get_value = count.
  ENDMETHOD.
ENDCLASS.

DATA: cnt_1 TYPE REF TO counter,
      cnt_2 TYPE REF TO counter,
      cnt_3 TYPE REF TO counter,
      cnt_tab TYPE TABLE OF REF TO counter.

DATA number TYPE i.

START-OF-SELECTION.

  CREATE OBJECT: cnt_1,
                 cnt_2.

  MOVE cnt_2 TO cnt_3.

  CLEAR cnt_2.

  cnt_3 = cnt_1.

  CLEAR cnt_3.

  APPEND cnt_1 TO cnt_tab.

  CREATE OBJECT: cnt_2,
                 cnt_3.

  APPEND: cnt_2 TO cnt_tab,
          cnt_3 TO cnt_tab.

  CALL METHOD cnt_1->set EXPORTING set_value = 1.

  CALL METHOD cnt_2->set EXPORTING set_value = 10.

  CALL METHOD cnt_3->set EXPORTING set_value = 100.

  DO 3 TIMES.
    CALL METHOD: cnt_1->increment,
                 cnt_2->increment,
                 cnt_3->increment.
  ENDDO.

  LOOP AT cnt_tab INTO cnt_1.
    CALL METHOD cnt_1->get IMPORTING get_value = number.
    cl_demo_output=>write_text( |{ number }| ).
  ENDLOOP.

  cl_demo_output=>display( ).
