REPORT demo_interface.

INTERFACE status.
  METHODS write.
ENDINTERFACE.

CLASS counter DEFINITION.
  PUBLIC SECTION.
    INTERFACES status.
    METHODS increment.
  PRIVATE SECTION.
    DATA count TYPE i.
ENDCLASS.

CLASS counter IMPLEMENTATION.
  METHOD status~write.
    cl_demo_output=>write_text( |Count in counter is { count }| ).
  ENDMETHOD.
  METHOD increment.
    ADD 1 TO count.
  ENDMETHOD.
ENDCLASS.

CLASS bicycle DEFINITION.
  PUBLIC SECTION.
    INTERFACES status.
    METHODS drive.
  PRIVATE SECTION.
    DATA speed TYPE i.
ENDCLASS.

CLASS bicycle IMPLEMENTATION.
  METHOD status~write.
    cl_demo_output=>write_text( |Speed of bicycle is { speed }| ).
  ENDMETHOD.
  METHOD drive.
    ADD 10 TO speed.
  ENDMETHOD.
ENDCLASS.

DATA: count      TYPE REF TO counter,
      bike       TYPE REF TO bicycle,
      status     TYPE REF TO status,
      status_tab TYPE TABLE OF REF TO status.

START-OF-SELECTION.

  CREATE OBJECT: count, bike.

  DO 5 TIMES.
    count->increment( ).
    bike->drive( ).
  ENDDO.

  APPEND: count TO status_tab,
          bike  TO status_tab.

  LOOP AT status_tab INTO status.
    status->write( ).
  ENDLOOP.
   cl_demo_output=>display( ).
