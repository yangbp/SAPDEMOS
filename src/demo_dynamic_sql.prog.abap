REPORT demo_dynamic_sql.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    CONSTANTS left TYPE tabname VALUE 'SFLIGHT'.

    TYPES whitelist     TYPE HASHED TABLE OF string
                             WITH UNIQUE KEY table_line.

    DATA: right    TYPE tabname VALUE 'SPFLI',
          select   TYPE TABLE OF edpline,
          sublist  TYPE edpline,
          from     TYPE string,
          first_on TYPE abap_bool VALUE abap_true,
          tref     TYPE REF TO data.

    FIELD-SYMBOLS <itab> TYPE STANDARD TABLE.

    cl_demo_input=>request(
      EXPORTING text  = `Right Table of Join`
      CHANGING  field = right ).

    DATA(whitelist) =  VALUE whitelist( ( `SPFLI` )
                                        ( `SCARR` )
                                        ( `SAPLANE` ) ).

    TRY.
        right = cl_abap_dyn_prg=>check_whitelist_tab(
                  val = to_upper( right )
                  whitelist = whitelist ).
      CATCH cx_abap_not_in_whitelist.
        cl_demo_output=>write(
          `Only the following tables are allowed:` ).
        cl_demo_output=>display( whitelist ).
        LEAVE PROGRAM.
    ENDTRY.

    first_on = abap_true.
    CLEAR select.
    CLEAR sublist.
    CLEAR from.
    READ CURRENT LINE LINE VALUE INTO right.

    DATA(comp_tab1) =
      CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name(
                                  left ) )->get_components( ).
    DATA(comp_tab2) =
      CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name(
                                  right ) )->get_components( ).

    DELETE comp_tab1 WHERE name = 'MANDT'.
    DELETE comp_tab2 WHERE name = 'MANDT'.

    from = left && ` join ` && right && ` on `.

    LOOP AT comp_tab1 INTO DATA(comp1) WHERE name IS NOT INITIAL.
      sublist = left && '~' && comp1-name && ','.
      APPEND sublist TO select.
    ENDLOOP.

    LOOP AT comp_tab2 INTO DATA(comp2) WHERE name IS NOT INITIAL.
      TRY.
          comp1 = comp_tab1[ KEY primary_key name = comp2-name ].
          IF first_on = abap_false.
            from = from && ` and `.
          ELSE.
            first_on = abap_false.
          ENDIF.
          from = from && left  && `~` && comp2-name &&
                ` = ` && right && `~` && comp2-name.
        CATCH cx_sy_itab_line_not_found.
          APPEND comp2 TO comp_tab1.
          sublist = right && '~' && comp2-name && ','.
          APPEND sublist TO select.
      ENDTRY.
    ENDLOOP.

    DATA(struct_type) = cl_abap_structdescr=>create( comp_tab1 ).
    DATA(table_type) = cl_abap_tabledescr=>create( struct_type ).
    CREATE DATA tref TYPE HANDLE table_type.
    ASSIGN tref->* TO <itab>.

    ASSIGN select[ lines( select ) ] TO FIELD-SYMBOL(<comp>).
    REPLACE `,` IN <comp>  WITH ``.
    TRY.
        SELECT (select) FROM (from) INTO TABLE @<itab>.
        cl_demo_output=>display( <itab> ).
      CATCH cx_sy_dynamic_osql_syntax
            cx_sy_dynamic_osql_semantics INTO DATA(exc).
        cl_demo_output=>display( exc->get_text( ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
