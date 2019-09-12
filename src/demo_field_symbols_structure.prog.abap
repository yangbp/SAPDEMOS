REPORT demo_field_symbols_structure.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: wa(10) TYPE c VALUE '0123456789'.

    DATA: BEGIN OF line1,
            col1(3) TYPE c,
            col2(2) TYPE c,
            col3(5) TYPE c,
          END OF line1.

    DATA: BEGIN OF line2,
            col1(2) TYPE c,
            col2 TYPE sy-datum,
          END OF line2.

* correct --------------------------------------------------------------

    FIELD-SYMBOLS: <f1> LIKE line1,
                   <f2> LIKE line2.

    ASSIGN wa TO: <f1> CASTING,
                  <f2> CASTING.

* obsolete, not supported in methods -----------------------------------

  "FIELD-SYMBOLS: <f1> STRUCTURE line1 DEFAULT wa,
  "               <f2> STRUCTURE line2 DEFAULT wa.

* ----------------------------------------------------------------------

    cl_demo_output=>display(
             |{ <f1>-col1 } { <f1>-col2 } { <f1>-col3 }\n| &&
             |{ <f2>-col1 } { <f2>-col2 }| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
