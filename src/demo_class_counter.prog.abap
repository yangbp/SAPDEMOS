REPORT demo_class_counter .

CLASS counter DEFINITION.
  PUBLIC SECTION.
    METHODS: set
               IMPORTING value(set_value) TYPE i,
             increment,
             get
               EXPORTING value(get_value) TYPE i.
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

DATA number TYPE i VALUE 5.
DATA cnt TYPE REF TO counter.

START-OF-SELECTION.

  CREATE OBJECT cnt.

  cnt->set( number ).

  DO 3 TIMES.
    cnt->increment( ).
  ENDDO.

  cnt->get( IMPORTING get_value = number ).

  cl_demo_output=>display( number ).
