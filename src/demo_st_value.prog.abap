REPORT demo_st_value.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: dat         TYPE d,
          tim         TYPE t,
          time_stamp  TYPE xsddatetime_z.

    dat = sy-datlo.
    tim = sy-timlo.
    CONVERT DATE dat TIME tim INTO TIME STAMP time_stamp TIME ZONE ``.

    CALL TRANSFORMATION demo_st_value
      SOURCE date = dat
             time = tim
             datetime = time_stamp
      RESULT XML data(xml).

    cl_demo_output=>display_xml( xml ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
