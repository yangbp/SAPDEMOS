REPORT demo_class_counter_event.

CLASS counter DEFINITION.
  PUBLIC SECTION.
    METHODS increment_counter.
    EVENTS  critical_value EXPORTING value(excess) TYPE i.
  PRIVATE SECTION.
    DATA: count     TYPE i,
          threshold TYPE i VALUE 10.
ENDCLASS.

CLASS counter IMPLEMENTATION.
  METHOD increment_counter.
    DATA diff TYPE i.
    ADD 1 TO count.
    IF count > threshold.
      diff = count - threshold.
      RAISE EVENT critical_value EXPORTING excess = diff.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS handler DEFINITION.
  PUBLIC SECTION.
    METHODS handle_excess FOR EVENT critical_value OF counter
            IMPORTING excess.
ENDCLASS.

CLASS handler IMPLEMENTATION.
  METHOD handle_excess.
    cl_demo_output=>write_text( |Excess is { excess }| ).
  ENDMETHOD.
ENDCLASS.

DATA: r1 TYPE REF TO counter,
      h1 TYPE REF TO handler.

START-OF-SELECTION.

  CREATE OBJECT: r1, h1.

  SET HANDLER h1->handle_excess FOR ALL INSTANCES.

  DO 20 TIMES.
    CALL METHOD r1->increment_counter.
  ENDDO.

  cl_demo_output=>display( ).
