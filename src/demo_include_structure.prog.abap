REPORT demo_include_structure.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA week TYPE demo_week.
    week-monday-work    = 'WorkWork'.
    week-monday-free    = 'EatSleepSleepEat'.
    week-tuesday-work   = week-work_mo.
    week-tuesday-free   = week-free_mo.
    week-wednesday-work = week-work_tu.
    week-wednesday-free = week-free_tu.
    week-thursday-work  = week-work_we.
    week-thursday-free  = week-free_we.
    week-friday-work    = week-work_th.
    week-friday-free    = week-free_th.
    cl_demo_output=>display( week ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
