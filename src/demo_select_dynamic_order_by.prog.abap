REPORT demo_select_dynamic_order_by.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES flag TYPE c LENGTH 1.
    DATA: flag_tab  TYPE TABLE OF flag WITH EMPTY KEY,
          order_by  TYPE string,
          spfli_tab TYPE TABLE OF spfli WITH EMPTY KEY.

    "Input screen for columns
    DATA(components) = CAST cl_abap_structdescr(
      cl_abap_typedescr=>describe_by_name( 'SPFLI' ) )->components.
    LOOP AT components FROM 2 ASSIGNING FIELD-SYMBOL(<component>).
      APPEND INITIAL LINE TO flag_tab ASSIGNING FIELD-SYMBOL(<flag>).
      cl_demo_input=>add_field(
        EXPORTING text = CONV string( <component>-name )
        CHANGING  field =  <flag> ).
    ENDLOOP.
    cl_demo_input=>request( ).

    "Create ORDER BY clause
    LOOP AT components FROM 2 ASSIGNING <component>.
      DATA(idx) = sy-tabix.
      DATA(flag) = flag_tab[ idx - 1 ].
      order_by = order_by &&
        COND string( WHEN to_upper( flag ) = `X` OR
                          to_upper( flag ) = `A`
                            THEN |, { <component>-name } ASCENDING|
                     WHEN to_upper( flag ) = `D`
                            THEN |, { <component>-name } DESCENDING|
                     ELSE `` ).
    ENDLOOP.
    SHIFT order_by BY 2 PLACES LEFT.

    "Database access
    TRY.
        SELECT *
               FROM spfli
               ORDER BY (order_by)
               INTO TABLE @spfli_tab.
      CATCH cx_sy_dynamic_osql_error INTO DATA(exc).
        cl_demo_output=>display( exc->get_text( ) ).
        RETURN.
    ENDTRY.
    cl_demo_output=>display( spfli_tab ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
