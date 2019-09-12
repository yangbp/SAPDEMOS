REPORT demo_inheritance.

CLASS counter DEFINITION.
  PUBLIC SECTION.
    METHODS: set
              IMPORTING value(set_value) TYPE i,
             increment,
             get
              EXPORTING value(get_value) TYPE i.
  PROTECTED SECTION.
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

CLASS counter_ten DEFINITION INHERITING FROM counter.
  PUBLIC SECTION.
    METHODS increment REDEFINITION.
    DATA count_ten TYPE c LENGTH 1.
ENDCLASS.

CLASS counter_ten IMPLEMENTATION.
  METHOD increment.
    DATA modulo TYPE i.
    super->increment( ).
    modulo = count MOD 10.
    IF modulo = 0.
      count_ten = count_ten + 1.
      cl_demo_output=>write_text( |{ count } - { count_ten }| ).
    ELSE.
      cl_demo_output=>write_text( |{ count }| ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

DATA: count TYPE REF TO counter,
      number TYPE i VALUE 5.

START-OF-SELECTION.

  CREATE OBJECT count TYPE counter_ten.

  count->set( number ).

  DO 20 TIMES.
    count->increment( ).
  ENDDO.
  cl_demo_output=>display( ).
