CLASS cl_demo_output_stream DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    INTERFACES if_demo_output_formats .

    ALIASES gc_heading                                      "#EC NOTEXT
      FOR if_demo_output_formats~heading .
    ALIASES gc_nonprop                                      "#EC NOTEXT
      FOR if_demo_output_formats~nonprop .
    ALIASES gc_text                                         "#EC NOTEXT
      FOR if_demo_output_formats~text .

    EVENTS completed
      EXPORTING
        VALUE(ev_output) TYPE xstring .

    CLASS-METHODS open
      RETURNING
        VALUE(ro_stream) TYPE REF TO cl_demo_output_stream .
    METHODS close
      RETURNING
        VALUE(rv_output) TYPE xstring .
    METHODS write_data
      IMPORTING
        !ia_value        TYPE data
        VALUE(iv_format) TYPE string OPTIONAL
        VALUE(iv_name)   TYPE string OPTIONAL .
    METHODS write_html
      IMPORTING
        VALUE(iv_html) TYPE string .
    METHODS write_text
      IMPORTING
        VALUE(iv_text)   TYPE string
        VALUE(iv_format) TYPE string DEFAULT gc_text
        VALUE(iv_level)  TYPE i DEFAULT 1 .
    METHODS write_xml
      IMPORTING
        VALUE(iv_xml)  TYPE string OPTIONAL
        VALUE(iv_xxml) TYPE xstring OPTIONAL
          PREFERRED PARAMETER iv_xml .
    METHODS write_json
      IMPORTING
        VALUE(iv_json)  TYPE string OPTIONAL
        VALUE(iv_xjson) TYPE xstring OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS gc_initial_name TYPE string VALUE `initial_name`. "#EC NOTEXT
    CONSTANTS gc_xml TYPE string VALUE `xml`.               "#EC NOTEXT
    CONSTANTS gc_json TYPE string VALUE `json`.             "#EC NOTEXT
    DATA mv_name TYPE string .
    DATA mt_stream TYPE abap_trans_srcbind_tab .
    CONSTANTS gc_html TYPE string VALUE `html`.             "#EC NOTEXT
    DATA mv_closed TYPE abap_bool VALUE abap_false. "#EC NOTEXT  .  .  .  .  .  .  .  .  .  .  .  .  . " .
    CONSTANTS gc_reference TYPE string VALUE `reference`.   "#EC NOTEXT

    METHODS add_elementary_object
      IMPORTING
        !ia_elementary TYPE data
        !io_elem_type  TYPE REF TO cl_abap_elemdescr
        !iv_format     TYPE string OPTIONAL .
    METHODS add_structured_object
      IMPORTING
        !ia_structured  TYPE data
        !io_struct_type TYPE REF TO cl_abap_structdescr
        !iv_format      TYPE string OPTIONAL
      RAISING
        cx_demo_output_not_possible .
    METHODS add_tabular_object
      IMPORTING
        !ia_tabular    TYPE ANY TABLE
        !io_table_type TYPE REF TO cl_abap_tabledescr
        !iv_format     TYPE string OPTIONAL
      RAISING
        cx_demo_output_not_possible .
    METHODS elementary2structured
      IMPORTING
        !ir_elementary       TYPE REF TO data
        !io_elem_type        TYPE REF TO cl_abap_elemdescr
      EXPORTING
        VALUE(er_structured) TYPE REF TO data
        !eo_struct_type      TYPE REF TO cl_abap_structdescr .
    METHODS structured2tabular
      IMPORTING
        !ir_structured    TYPE REF TO data
        !io_struct_type   TYPE REF TO cl_abap_structdescr
      RETURNING
        VALUE(rr_tabular) TYPE REF TO data .
    METHODS finalize_stream .
    METHODS finalize_xml
      IMPORTING
                VALUE(iv_xml) TYPE string
      RETURNING
                VALUE(rv_xml) TYPE xstring
      RAISING   cx_sy_regex_too_complex.
    METHODS check_structure
      IMPORTING
        !io_struct_type       TYPE REF TO cl_abap_structdescr
      RETURNING
        VALUE(ro_struct_type) TYPE REF TO cl_abap_structdescr
      RAISING
        cx_demo_output_not_possible .
    METHODS create_value
      IMPORTING
        !ir_tabular TYPE REF TO data
      CHANGING
        !cs_segment TYPE abap_trans_srcbind .
ENDCLASS.



CLASS CL_DEMO_OUTPUT_STREAM IMPLEMENTATION.


  METHOD add_elementary_object.
    DATA: lr_elementary  TYPE REF TO data,
          lr_structured  TYPE REF TO data,
          lr_tabular     TYPE REF TO data,
          lo_struct_type TYPE REF TO cl_abap_structdescr.

    FIELD-SYMBOLS <ls_segment> LIKE LINE OF mt_stream.

    IF mv_name = gc_initial_name.
      mv_name = `Field` ##no_text.
*    ELSE.
*      mv_name = `Field ` && mv_name ##no_text.
    ENDIF.

    IF iv_format = if_demo_output_formats=>nonprop.
      mv_name = `np` && mv_name.
    ENDIF.

    GET REFERENCE OF ia_elementary INTO lr_elementary.

    elementary2structured(
      EXPORTING ir_elementary  = lr_elementary
                io_elem_type   = io_elem_type
      IMPORTING er_structured  = lr_structured
                eo_struct_type = lo_struct_type ).

    lr_tabular = structured2tabular(
                   ir_structured  = lr_structured
                   io_struct_type = lo_struct_type ).

    APPEND INITIAL LINE TO mt_stream ASSIGNING <ls_segment>.
    <ls_segment>-name  = mv_name.
    create_value( EXPORTING ir_tabular = lr_tabular
                  CHANGING  cs_segment = <ls_segment> ).

  ENDMETHOD.                    "ADD_ELEMENTARY_OBJECT


  METHOD add_structured_object.
    DATA: lr_structured  TYPE REF TO data,
          lr_tabular     TYPE REF TO data,
          lo_struct_type LIKE io_struct_type.

    FIELD-SYMBOLS <ls_segment> LIKE LINE OF mt_stream.

    lo_struct_type = check_structure( io_struct_type ).

    IF mv_name = gc_initial_name.
      mv_name = `Structure` ##no_text.
*    ELSE.
*      mv_name = `Structure ` && mv_name ##no_text.
    ENDIF.

    IF iv_format = if_demo_output_formats=>nonprop.
      mv_name = `np` && mv_name.
    ENDIF.

    GET REFERENCE OF ia_structured INTO lr_structured.

    lr_tabular = structured2tabular(
                   ir_structured  = lr_structured
                   io_struct_type = lo_struct_type ).

    APPEND INITIAL LINE TO mt_stream ASSIGNING <ls_segment>.
    <ls_segment>-name  = mv_name.
    create_value( EXPORTING ir_tabular = lr_tabular
                  CHANGING  cs_segment = <ls_segment> ).

  ENDMETHOD.                    "ADD_STRUCTURED_OBJECT


  METHOD add_tabular_object.
    DATA: lr_elementary  TYPE REF TO data,
          lr_structured  TYPE REF TO data,
          lr_tabular_old TYPE REF TO data,
          lr_tabular_new TYPE REF TO data,
          lr_tabular     TYPE REF TO data,
          lo_line_type   TYPE REF TO cl_abap_datadescr,
          lo_elem_type   TYPE REF TO cl_abap_elemdescr,
          lo_struct_type TYPE REF TO cl_abap_structdescr,
          lo_table_type  TYPE REF TO cl_abap_tabledescr.

    FIELD-SYMBOLS <ls_segment> LIKE LINE OF mt_stream.

    FIELD-SYMBOLS: <ls_structured>  TYPE data,
                   <lt_tabular_old> TYPE ANY TABLE,
                   <lt_tabular_new> TYPE STANDARD TABLE,
                   <lt_tabular>     TYPE STANDARD TABLE.

    IF mv_name = gc_initial_name.
      mv_name = `Table` ##no_text.
*    ELSE.
*      mv_name = `Table ` && mv_name ##no_text.
    ENDIF.

    IF iv_format = if_demo_output_formats=>nonprop.
      mv_name = `np` && mv_name.
    ENDIF.

    lo_line_type = io_table_type->get_table_line_type( ).

    TRY.
        lo_struct_type ?= lo_line_type.
        lo_struct_type = check_structure( lo_struct_type ).
        GET REFERENCE OF ia_tabular INTO lr_tabular_old.
        ASSIGN lr_tabular_old->* TO <lt_tabular_old>.
        lo_table_type = cl_abap_tabledescr=>get(
                          p_line_type  = lo_struct_type
                          p_table_kind = cl_abap_tabledescr=>tablekind_std ).
        CREATE DATA lr_tabular_new TYPE HANDLE lo_table_type.
        ASSIGN lr_tabular_new->* TO <lt_tabular_new>.
        MOVE-CORRESPONDING <lt_tabular_old> TO <lt_tabular_new>.
        APPEND INITIAL LINE TO mt_stream ASSIGNING <ls_segment>.
        <ls_segment>-name  = mv_name.
        create_value( EXPORTING ir_tabular = lr_tabular_new
                      CHANGING  cs_segment = <ls_segment> ).
        RETURN.
      CATCH cx_sy_move_cast_error ##no_handler.
    ENDTRY.

    TRY.
        lo_elem_type ?= lo_line_type.
        IF ia_tabular IS NOT INITIAL.
          LOOP AT ia_tabular REFERENCE INTO lr_elementary.
            elementary2structured(
              EXPORTING ir_elementary  = lr_elementary
                        io_elem_type   = lo_elem_type
              IMPORTING er_structured  = lr_structured
                        eo_struct_type = lo_struct_type ).
            IF lr_tabular IS INITIAL.
              TRY.
                  lo_table_type = cl_abap_tabledescr=>get(
                    p_line_type  = lo_struct_type
                    p_table_kind = cl_abap_tabledescr=>tablekind_std ).
                  CREATE DATA lr_tabular TYPE HANDLE lo_table_type.
                  ASSIGN lr_tabular->* TO <lt_tabular>.
                CATCH cx_sy_table_creation.
                  GET REFERENCE OF 'Error' INTO lr_tabular ##no_text.
                  EXIT.
              ENDTRY.
            ENDIF.
            ASSIGN lr_structured->* TO <ls_structured>.
            APPEND <ls_structured> TO <lt_tabular>.
          ENDLOOP.
          APPEND INITIAL LINE TO mt_stream ASSIGNING <ls_segment>.
          <ls_segment>-name  = mv_name.
          create_value( EXPORTING ir_tabular = lr_tabular
                        CHANGING  cs_segment = <ls_segment> ).
        ELSE.
          "An initial table with elementary line type is treated as an empty string
          add_elementary_object( ia_elementary = ``
                                 io_elem_type  = cl_abap_elemdescr=>get_string( )
                                 iv_format     = iv_format ).
          REPLACE `Field` IN mv_name WITH `Table` ##no_text.
          REPLACE `Table Table` IN mv_name WITH `Table` ##no_text.
          REPLACE `npTable npTable` IN mv_name WITH `npTable` ##no_text.
          READ TABLE mt_stream ASSIGNING <ls_segment> INDEX lines( mt_stream ).
          <ls_segment>-name  = mv_name.
        ENDIF.
        RETURN.
      CATCH cx_sy_move_cast_error ##no_handler.
    ENDTRY.

    RAISE EXCEPTION TYPE cx_demo_output_not_possible.

  ENDMETHOD.                    "ADD_TABULAR_OBJECT


  METHOD check_structure.
    DATA:
      lt_components     TYPE cl_abap_structdescr=>included_view,
      ls_component      LIKE LINE OF lt_components,
      lt_components_new TYPE cl_abap_structdescr=>component_table,
      lo_elem_type      TYPE REF TO cl_abap_elemdescr ##needed.

    FIELD-SYMBOLS
     <ls_component_new> LIKE LINE OF lt_components_new.

    lt_components = io_struct_type->get_included_view( ).

    LOOP AT lt_components INTO ls_component.
      TRY.
          "Check elementary
          lo_elem_type ?= ls_component-type.
          "Build new component table with resolved includes
          APPEND INITIAL LINE TO lt_components_new ASSIGNING  <ls_component_new>.
          <ls_component_new>-name = ls_component-name.
          <ls_component_new>-type = ls_component-type.
        CATCH cx_sy_move_cast_error.
          RAISE EXCEPTION TYPE cx_demo_output_not_possible.
      ENDTRY.
    ENDLOOP.

    "Structure type with resolved included structures
    ro_struct_type = cl_abap_structdescr=>get( lt_components_new ).

  ENDMETHOD.


  METHOD close.
    DATA lv_xml TYPE string.

    IF mv_closed = abap_true.
      RETURN.
    ENDIF.

    finalize_stream( ).

    TRY.
        CALL TRANSFORMATION id
           SOURCE (mt_stream)
           RESULT XML lv_xml.
           "OPTIONS VALUE_HANDLING = 'move'.
      CATCH cx_sy_conversion_no_number cx_transformation_error.
        CALL TRANSFORMATION id SOURCE XML
           `<ab:abapOutput xmlns:ab="http://www.sap.com/abapdemos">` &
           ` <ab:output>` &
           `  <ab:text format="normal">Invalid data , output not possible.</ab:text>` &
           ` </ab:output>` &
           `</ab:abapOutput>` ##no_text
           RESULT XML rv_output.
    ENDTRY.

    IF rv_output IS INITIAL.
      TRY.
          rv_output = finalize_xml( lv_xml ).
        CATCH cx_sy_regex_too_complex.
          CALL TRANSFORMATION id SOURCE XML
             `<ab:abapOutput xmlns:ab="http://www.sap.com/abapdemos">` &
             ` <ab:output>` &
             `  <ab:text format="normal">Data too complex or too large, output not possible.</ab:text>` &
             ` </ab:output>` &
             `</ab:abapOutput>` ##no_text
             RESULT XML rv_output.
      ENDTRY.
    ENDIF.

    IF mt_stream IS NOT INITIAL.
      RAISE EVENT completed EXPORTING ev_output = rv_output.
    ENDIF.

    CLEAR mt_stream.
    mv_closed = abap_true.
  ENDMETHOD.                    "CLOSE


  METHOD create_value.
    DATA
      lo_table_type  TYPE REF TO cl_abap_tabledescr.

    FIELD-SYMBOLS:
      <lt_tabular_old> TYPE ANY TABLE,
      <lt_tabular_new> TYPE ANY TABLE.

    ASSIGN ir_tabular->* TO <lt_tabular_old>.
    lo_table_type ?= cl_abap_typedescr=>describe_by_data( <lt_tabular_old> ).

    CREATE DATA cs_segment-value TYPE HANDLE lo_table_type.
    ASSIGN cs_segment-value->* TO <lt_tabular_new>.
    <lt_tabular_new> = <lt_tabular_old>.

  ENDMETHOD.


  METHOD elementary2structured.
    DATA: lt_components TYPE cl_abap_structdescr=>component_table,
          ls_component  LIKE LINE OF lt_components.

    FIELD-SYMBOLS: <lv_elementary> TYPE data,
                   <ls_structured> TYPE data,
                   <lv_component>  TYPE data.

    ls_component-name = `ab_elmntry` ##no_text.
    ls_component-type = io_elem_type.
    APPEND ls_component TO lt_components.

    TRY.
        eo_struct_type = cl_abap_structdescr=>get( lt_components ).
        CREATE DATA er_structured TYPE HANDLE eo_struct_type.
        ASSIGN ir_elementary->* TO <lv_elementary>.
        ASSIGN er_structured->* TO <ls_structured>.
        ASSIGN COMPONENT 1 OF STRUCTURE <ls_structured> TO <lv_component>.
        <lv_component> = <lv_elementary>.
      CATCH cx_sy_struct_creation.
        elementary2structured(
          EXPORTING ir_elementary  = REF #( 'Unexpected error' )
                    io_elem_type   = CAST cl_abap_elemdescr( cl_abap_typedescr=>describe_by_data( 'Unexpected error' ) )
          IMPORTING er_structured  = er_structured
                    eo_struct_type = eo_struct_type ) ##no_text.
    ENDTRY.

  ENDMETHOD.                    "ELEMENTARY2STRUCTURED


  METHOD finalize_stream.
    DATA:
      lo_data_type       TYPE REF TO cl_abap_typedescr,
      lo_elem_type_new   TYPE REF TO cl_abap_elemdescr,
      lo_struct_type     TYPE REF TO cl_abap_structdescr,
      lo_struct_type_new TYPE REF TO cl_abap_structdescr,
      lo_struct_type_obj TYPE REF TO cl_abap_structdescr,
      lo_table_type      TYPE REF TO cl_abap_tabledescr,
      lo_table_type_new  TYPE REF TO cl_abap_tabledescr,
      lt_components      TYPE cl_abap_structdescr=>component_table,
      lt_components_new  TYPE cl_abap_structdescr=>component_table,
      lt_components_obj  TYPE cl_abap_structdescr=>component_table,
      lr_tabular_new     TYPE REF TO data,
      lr_structured_new  TYPE REF TO data,
      lr_structured_obj  TYPE REF TO data,
      lr_elementary_new  TYPE REF TO data,
      lv_index           LIKE sy-tabix,
      lv_name            TYPE string,
      lv_hex_flag        TYPE abap_bool,
      lv_subrc           TYPE sy-subrc.


    FIELD-SYMBOLS: <ls_segment>        LIKE LINE OF mt_stream,
                   <lt_tabular>        TYPE ANY TABLE,
                   <ls_component>      LIKE LINE OF lt_components,
                   <lt_tabular_new>    TYPE ANY TABLE,
                   <ls_structured>     TYPE data,
                   <ls_structured_new> TYPE data,
                   <ls_structured_obj> TYPE data,
                   <lv_elementary_new> TYPE data,
                   <lv_component>      TYPE string,
                   <lv_component_obj>  TYPE data,
                   <lv_old>            TYPE data,
                   <lv_new>            TYPE data.

    lo_elem_type_new = cl_abap_elemdescr=>get_string( ).

    LOOP AT mt_stream ASSIGNING <ls_segment> WHERE name <>  `ab_` && gc_text AND
                                                   name <>  `ab_xml`  AND
                                                   name <>  `ab_json`  AND
                                                   name <>  `ab_html` AND
                                                   name NP |ab_{ gc_heading }+| AND
                                                   name NP |ab_{ gc_nonprop }|.

      lv_index = sy-tabix.
      lv_name  = <ls_segment>-name.
      "Replace component names with "compi" in table
      ASSIGN <ls_segment>-value->* TO  <lt_tabular>.
      lo_data_type = cl_abap_typedescr=>describe_by_data( <lt_tabular> ).
      lo_table_type  ?= lo_data_type.
      lo_struct_type ?= lo_table_type->get_table_line_type( ).
      "Resolve included structures
      TRY.
          lo_struct_type = check_structure( lo_struct_type ).
        CATCH cx_demo_output_not_possible.
          DELETE mt_stream INDEX lv_index.
          CONTINUE.
      ENDTRY.
      lt_components = lo_struct_type->get_components( ).
      lt_components_new = lt_components.
      LOOP AT lt_components_new ASSIGNING <ls_component>.
        <ls_component>-name = |ab_compvalue{ sy-tabix ALIGN = LEFT }|.
        "Special handling for x and xstring: to avoid base64Binary use type string instead
        IF <ls_component>-type->type_kind = cl_abap_elemdescr=>typekind_hex OR
           <ls_component>-type->type_kind = cl_abap_elemdescr=>typekind_xstring.
          lv_hex_flag = abap_true.
          <ls_component>-type = cl_abap_elemdescr=>get_string( ).
        ENDIF.
      ENDLOOP.
      lo_struct_type_new = cl_abap_structdescr=>get( lt_components_new ).
      CREATE DATA lr_structured_new TYPE HANDLE lo_struct_type_new.
      ASSIGN lr_structured_new->* TO <ls_structured_new>.
      lo_table_type_new = cl_abap_tabledescr=>get(
      p_line_type  = lo_struct_type_new
      p_table_kind = cl_abap_tabledescr=>tablekind_std ).
      CREATE DATA lr_tabular_new TYPE HANDLE lo_table_type_new.
      ASSIGN lr_tabular_new->* TO <lt_tabular_new>.
      IF lv_hex_flag = abap_false.
        <lt_tabular_new> = <lt_tabular>.
      ELSE.
        "If type of x/xstring was changed to string, assignment is possible only field by field
        CLEAR  <lt_tabular_new>.
        LOOP AT <lt_tabular> ASSIGNING <ls_structured>.
          lv_subrc = 0.
          WHILE lv_subrc = 0.
            ASSIGN COMPONENT sy-index OF STRUCTURE <ls_structured> TO <lv_old>.
            ASSIGN COMPONENT sy-index OF STRUCTURE <ls_structured_new> TO <lv_new>.
            lv_subrc = sy-subrc.
            IF lv_subrc = 0.
              <lv_new> = <lv_old>.
            ENDIF.
          ENDWHILE.
          INSERT <ls_structured_new> INTO TABLE <lt_tabular_new>.
        ENDLOOP.
      ENDIF.
      "Create new structure "components" with names of components
      LOOP AT lt_components_new ASSIGNING <ls_component>.
        REPLACE 'ab_compvalue' IN <ls_component>-name WITH 'ab_compname' IGNORING CASE ##no_text.
        <ls_component>-type = cl_abap_elemdescr=>get_string( ).
      ENDLOOP.
      lo_struct_type_new = cl_abap_structdescr=>get( lt_components_new ).
      CREATE DATA lr_structured_new TYPE HANDLE lo_struct_type_new.
      ASSIGN lr_structured_new->* TO <ls_structured_new>.
      LOOP AT lt_components ASSIGNING <ls_component>.
        ASSIGN COMPONENT sy-tabix OF STRUCTURE <ls_structured_new> TO <lv_component>.
        <lv_component> = <ls_component>-name.
      ENDLOOP.
      "Create new string "name" with name of data
      CREATE DATA lr_elementary_new TYPE string.
      ASSIGN lr_elementary_new->* TO <lv_elementary_new>.
      <lv_elementary_new> = lv_name.
      "Create structure with components for name, components, and data
      CLEAR lt_components_obj.
      APPEND INITIAL LINE TO lt_components_obj ASSIGNING <ls_component>.
      <ls_component>-name = `ab_name` ##no_text.
      <ls_component>-type = lo_elem_type_new.
      APPEND INITIAL LINE TO lt_components_obj ASSIGNING <ls_component>.
      <ls_component>-name = `ab_components` ##no_text.
      <ls_component>-type = lo_struct_type_new.
      APPEND INITIAL LINE TO lt_components_obj ASSIGNING <ls_component>.
      <ls_component>-name = `ab_data` ##no_text.
      <ls_component>-type = lo_table_type_new.
      lo_struct_type_obj = cl_abap_structdescr=>get( lt_components_obj ).
      CREATE DATA lr_structured_obj TYPE HANDLE lo_struct_type_obj.
      ASSIGN lr_structured_obj->* TO <ls_structured_obj>.
      ASSIGN COMPONENT 'AB_NAME' OF STRUCTURE <ls_structured_obj> TO <lv_component_obj>.
      <lv_component_obj> = <lv_elementary_new>.
      ASSIGN COMPONENT 'AB_COMPONENTS' OF STRUCTURE <ls_structured_obj> TO <lv_component_obj>.
      <lv_component_obj> = <ls_structured_new>.
      ASSIGN COMPONENT 'AB_DATA' OF STRUCTURE <ls_structured_obj> TO <lv_component_obj>.
      "Replace data table with structure in stream
      <lv_component_obj> = <lt_tabular_new>.
      <ls_segment>-name = `ab_object` ##no_text.
      <ls_segment>-value = lr_structured_obj.
    ENDLOOP.

  ENDMETHOD.                    "finalize_stream


  METHOD finalize_xml.
    DATA lv_off TYPE i.
    DATA lv_subrc TYPE sy-subrc.

    REPLACE `<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">`
            IN iv_xml WITH `<ab:abapOutput xmlns:ab="http://www.sap.com/abapdemos">` ##no_text.
    REPLACE `</asx:abap>`
            IN iv_xml WITH `</ab:abapOutput>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<asx:values`
            IN iv_xml WITH `<ab:output` ##no_text.
    REPLACE ALL OCCURRENCES OF `</asx:values`
            IN iv_xml WITH `</ab:output` ##no_text.
    REPLACE ALL OCCURRENCES OF `AB_COMPONENTS>`
            IN iv_xml WITH `ab_components>` ##no_text.
    REPLACE ALL OCCURRENCES OF `AB_DATA>`
            IN iv_xml WITH `ab:data>` ##no_text.
    REPLACE ALL OCCURRENCES OF `item>`
            IN iv_xml WITH `ab:row>` ##no_text.
    REPLACE ALL OCCURRENCES OF REGEX `AB_COMPNAME\d+>`
            IN iv_xml WITH `ab:compName>` ##no_text.
    REPLACE ALL OCCURRENCES OF REGEX `AB_COMPVALUE\d+>`
            IN iv_xml WITH `ab:compValue>` ##no_text.
    REPLACE ALL OCCURRENCES OF REGEX `AB_COMPVALUE\d+/>`
            IN iv_xml WITH `ab:compValue/>` ##no_text.
    REPLACE ALL OCCURRENCES OF `AB_NAME>`
            IN iv_xml WITH `ab:name>` ##no_text.
    REPLACE ALL OCCURRENCES OF `<ab_`
            IN iv_xml WITH `<ab:` ##no_text.
    REPLACE ALL OCCURRENCES OF `</ab_`
            IN iv_xml WITH `</ab:` ##no_text.
    REPLACE ALL OCCURRENCES OF REGEX `(<)(ab:text)(_)([^>]+)(>)`
            IN iv_xml WITH `$1$2 format="$4"$5` ##no_text.
    REPLACE ALL OCCURRENCES OF REGEX `(</)(ab:text)(_)([^>]+)(>)`
            IN iv_xml WITH `$1$2$5` ##no_text.
    REPLACE ALL OCCURRENCES OF  `<ab:compName>AB_ELMNTRY</ab:compName>`
            IN iv_xml WITH `` ##no_text.


    WHILE lv_subrc = 0.
      FIND `<ab:name>np` IN iv_xml MATCH OFFSET lv_off.
      lv_subrc = sy-subrc.
      IF lv_subrc = 0.
        REPLACE FIRST OCCURRENCE OF `<ab:name>np` IN iv_xml WITH `<ab:name>` ##no_text.
        REPLACE FIRST OCCURRENCE OF `<ab:data>` IN SECTION OFFSET lv_off OF iv_xml
                                    WITH `<ab:data format="nonprop">` ##no_text.
      ENDIF.
    ENDWHILE.

    CALL TRANSFORMATION id
      SOURCE XML iv_xml
      RESULT XML rv_xml.

  ENDMETHOD.


  METHOD open.
    CREATE OBJECT ro_stream.
  ENDMETHOD.                    "OPEN


  METHOD structured2tabular.

    DATA lo_table_type  TYPE REF TO cl_abap_tabledescr.
    DATA lo_struct_type TYPE REF TO cl_abap_structdescr.
    DATA lr_structured TYPE REF TO data.

    FIELD-SYMBOLS: <ls_structured_old> TYPE data,
                   <ls_structured_new> TYPE data,
                   <lt_tabular>        TYPE STANDARD TABLE.

    TRY.
        lo_table_type = cl_abap_tabledescr=>get(
          p_line_type  = io_struct_type
          p_table_kind = cl_abap_tabledescr=>tablekind_std ).
        CREATE DATA rr_tabular TYPE HANDLE lo_table_type.
        CREATE DATA lr_structured TYPE HANDLE io_struct_type.
        ASSIGN ir_structured->* TO <ls_structured_old>.
        ASSIGN lr_structured->* TO <ls_structured_new>.
        ASSIGN rr_tabular->* TO <lt_tabular>.
        MOVE-CORRESPONDING <ls_structured_old> TO <ls_structured_new>.
        APPEND <ls_structured_new> TO <lt_tabular>.
      CATCH cx_sy_table_creation.
        elementary2structured(
          EXPORTING ir_elementary  = REF #( 'Unexpected error' )
                    io_elem_type   = CAST cl_abap_elemdescr( cl_abap_typedescr=>describe_by_data( 'Unexpected error' ) )
          IMPORTING er_structured  = lr_structured
                    eo_struct_type = lo_struct_type ) ##no_text.
        rr_tabular = structured2tabular(
                       ir_structured  = lr_structured
                       io_struct_type = lo_struct_type ).
    ENDTRY.

  ENDMETHOD.                    "STRUCTURED2TABULAR


  METHOD write_data.
*    DATA: lo_type        TYPE REF TO cl_abap_typedescr,
*          lo_ref_type    TYPE REF TO cl_abap_refdescr ##NEEDED,
*          lo_elem_type   TYPE REF TO cl_abap_elemdescr,
*          lo_struct_type TYPE REF TO cl_abap_structdescr,
*          lo_table_type  TYPE REF TO cl_abap_tabledescr.
*
*    IF mv_closed = abap_true.
*      RETURN.
*    ENDIF.
*
*    CLEAR mv_name.
*    IF iv_name IS NOT INITIAL.
*      mv_name = iv_name.
*    ELSE.
*      mv_name = gc_initial_name.
*    ENDIF.
*
*    IF iv_format IS NOT INITIAL.
*      IF iv_format <> if_demo_output_formats=>nonprop.
*        CLEAR iv_format.
*      ENDIF.
*    ENDIF.
*
*    lo_type = cl_abap_typedescr=>describe_by_data( ia_value ).
*
*    TRY.
*        lo_ref_type ?= lo_type.
*        lo_elem_type ?= cl_abap_typedescr=>describe_by_data( gc_reference ).
*        add_elementary_object( ia_elementary = gc_reference
*                               io_elem_type  = lo_elem_type
*                               iv_format     = iv_format ).
*        RETURN.
*      CATCH cx_sy_move_cast_error ##no_handler.
*    ENDTRY.
*
*
*    TRY.
*        lo_elem_type ?= lo_type.
*        add_elementary_object( ia_elementary = ia_value
*                               io_elem_type  = lo_elem_type
*                               iv_format     = iv_format ).
*        RETURN.
*      CATCH cx_sy_move_cast_error ##no_handler.
*    ENDTRY.
*
*    TRY.
*        lo_struct_type ?= lo_type.
*        add_structured_object( ia_structured   = ia_value
*                               io_struct_type  = lo_struct_type
*                               iv_format     = iv_format ).
*        RETURN.
*      CATCH cx_sy_move_cast_error       ##no_handler.
*      CATCH cx_demo_output_not_possible ##no_handler.
*    ENDTRY.
*
*    TRY.
*        lo_table_type ?= lo_type.
*        add_tabular_object( ia_tabular    = ia_value
*                            io_table_type = lo_table_type
*                            iv_format     = iv_format ).
*        RETURN.
*      CATCH cx_sy_move_cast_error       ##no_handler.
*      CATCH cx_demo_output_not_possible ##no_handler.
*    ENDTRY.
*
*    write_text(
*      EXPORTING
*        iv_text = `Data type not yet supported ...` ) ##no_text.

    FIELD-SYMBOLS <la_elem> TYPE data.

    IF mv_closed = abap_true.
      RETURN.
    ENDIF.

    CLEAR mv_name.
    IF iv_name IS NOT INITIAL.
      mv_name = iv_name.
    ELSE.
      mv_name = gc_initial_name.
    ENDIF.

    IF iv_format IS NOT INITIAL.
      IF iv_format <> if_demo_output_formats=>nonprop.
        CLEAR iv_format.
      ENDIF.
    ENDIF.

    TRY.

        DATA(lo_type) = cl_abap_typedescr=>describe_by_data( ia_value ).
        IF lo_type IS INSTANCE OF cl_abap_refdescr.
          lo_type = cl_abap_typedescr=>describe_by_data( gc_reference ).
          ASSIGN gc_reference TO <la_elem>.
        ELSE.
          ASSIGN ia_value TO <la_elem>.
        ENDIF.

        CASE TYPE OF lo_type.
          WHEN TYPE cl_abap_elemdescr INTO DATA(lo_elem_type).
            add_elementary_object( ia_elementary = <la_elem>
                                   io_elem_type  = lo_elem_type
                                   iv_format     = iv_format ).
          WHEN TYPE cl_abap_structdescr INTO DATA(lo_struct_type).
            add_structured_object( ia_structured   = ia_value
                                   io_struct_type  = lo_struct_type
                                   iv_format       = iv_format ).
          WHEN TYPE cl_abap_tabledescr INTO DATA(lo_table_type).
            add_tabular_object( ia_tabular    = ia_value
                                io_table_type = lo_table_type
                                iv_format     = iv_format ).
          WHEN OTHERS.
            RAISE EXCEPTION TYPE cx_demo_output_not_possible.
        ENDCASE.

      CATCH cx_demo_output_not_possible.
        write_text( iv_text = `Data type not yet supported ...` ) ##no_text.
    ENDTRY.

  ENDMETHOD.                    "WRITE


  METHOD write_html.

    FIELD-SYMBOLS: <ls_segment> LIKE LINE OF mt_stream,
                   <lv_html>    TYPE string.

    IF mv_closed = abap_true.
      RETURN.
    ENDIF.

    IF iv_html IS INITIAL.
      RETURN.
    ENDIF.

    REPLACE ALL OCCURRENCES OF  `<` IN iv_html WITH `ab:lt`  ##no_text.
    REPLACE ALL OCCURRENCES OF  `>` IN iv_html WITH `ab:gt`  ##no_text.
    REPLACE ALL OCCURRENCES OF  `&` IN iv_html WITH `ab:amp` ##no_text.

    APPEND INITIAL LINE TO mt_stream ASSIGNING <ls_segment>.
    <ls_segment>-name  = gc_html.
    <ls_segment>-name = `ab_` && <ls_segment>-name.
    CREATE DATA <ls_segment>-value TYPE string.
    ASSIGN <ls_segment>-value->* TO <lv_html>.
    <lv_html> = iv_html.
  ENDMETHOD.


  METHOD write_json.
    DATA lv_json TYPE string.
    DATA lv_xjson TYPE xstring.

    FIELD-SYMBOLS: <ls_segment> LIKE LINE OF mt_stream,
                   <lv_json>    TYPE string.

    IF mv_closed = abap_true.
      RETURN.
    ENDIF.

    IF iv_json IS INITIAL AND
       iv_xjson IS INITIAL.
      RETURN.
    ENDIF.
    IF iv_json IS NOT INITIAL AND
       iv_xjson IS NOT INITIAL.
      RETURN.
    ENDIF.

    IF iv_json IS NOT INITIAL.
      lv_xjson = cl_abap_codepage=>convert_to( iv_json ).
    ENDIF.

    IF iv_xjson IS NOT INITIAL.
      lv_xjson = iv_xjson.
    ENDIF.

    "Check and pretty print JSON
    TRY.
        DATA(reader) = cl_sxml_string_reader=>create( lv_xjson ).
        DATA(writer) = CAST if_sxml_writer(
                              cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ) ).
        writer->set_option( option = if_sxml_writer=>co_opt_linebreaks ).
        writer->set_option( option = if_sxml_writer=>co_opt_indent ).
        reader->next_node( ).
        reader->skip_node( writer ).
        lv_json = cl_abap_codepage=>convert_from( CAST cl_sxml_string_writer( writer )->get_output( ) ).
      CATCH cx_sxml_parse_error.
        RETURN.
    ENDTRY.

    lv_json = escape( val = lv_json format = cl_abap_format=>e_xml_text ).

    APPEND INITIAL LINE TO mt_stream ASSIGNING <ls_segment>.
    <ls_segment>-name  = gc_json.
    <ls_segment>-name = `ab_` && <ls_segment>-name.
    CREATE DATA <ls_segment>-value TYPE string.
    ASSIGN <ls_segment>-value->* TO <lv_json>.
    <lv_json> = lv_json.
  ENDMETHOD.


  METHOD write_text.

    FIELD-SYMBOLS: <ls_segment> LIKE LINE OF mt_stream,
                   <lv_text>    TYPE string.

    IF mv_closed = abap_true.
      RETURN.
    ENDIF.

    IF iv_text IS INITIAL.
      RETURN.
    ENDIF.

    IF iv_format <> gc_text AND iv_format <> gc_heading AND iv_format <> gc_nonprop.
      iv_format = gc_text.
    ENDIF.

    IF iv_level < 1 OR iv_level > 4.
      iv_level = 1.
    ENDIF.

    iv_text = escape( val = iv_text format = cl_abap_format=>e_xml_text ).

    APPEND INITIAL LINE TO mt_stream ASSIGNING <ls_segment>.
    <ls_segment>-name  = iv_format.
    IF <ls_segment>-name = gc_heading.
      <ls_segment>-name =  <ls_segment>-name && |{ iv_level ALIGN = LEFT WIDTH = 1 }|.
    ENDIF.
    <ls_segment>-name = `ab_` && <ls_segment>-name.
    CREATE DATA <ls_segment>-value TYPE string.
    ASSIGN <ls_segment>-value->* TO <lv_text>.
    <lv_text> = iv_text.

  ENDMETHOD.                    "WRITE_TEXT´ENDCLASS.


  METHOD write_xml.

    DATA lv_xml TYPE string.
    DATA lv_xxml TYPE xstring.

    FIELD-SYMBOLS: <ls_segment> LIKE LINE OF mt_stream,
                   <lv_xml>     TYPE string.

    IF mv_closed = abap_true.
      RETURN.
    ENDIF.

    IF iv_xml IS INITIAL AND
       iv_xxml IS INITIAL.
      RETURN.
    ENDIF.
    IF iv_xml IS NOT INITIAL AND
       iv_xxml IS NOT INITIAL.
      RETURN.
    ENDIF.

    IF iv_xml IS NOT INITIAL.
      lv_xxml = cl_abap_codepage=>convert_to( iv_xml ).
*    TRY.
*        CALL TRANSFORMATION id SOURCE XML iv_xml
*                               RESULT XML lv_xxml.
*      CATCH cx_transformation_error.
*        RETURN.
*    ENDTRY.
    ENDIF.

    IF iv_xxml IS NOT INITIAL.
      lv_xxml = iv_xxml.
    ENDIF.

    "Standardize XML
    TRY.
        DATA(reader) = cl_sxml_string_reader=>create( lv_xxml ).
        DATA(writer) = CAST if_sxml_writer(
                              cl_sxml_string_writer=>create( ) ).
        writer->set_option( option = if_sxml_writer=>co_opt_linebreaks ).
        writer->set_option( option = if_sxml_writer=>co_opt_indent ).
        reader->next_node( ).
        reader->skip_node( writer ).
        lv_xml = cl_abap_codepage=>convert_from( CAST cl_sxml_string_writer( writer )->get_output( ) ).
      CATCH cx_sxml_parse_error.
        RETURN.
    ENDTRY.

    lv_xml = escape( val = lv_xml format = cl_abap_format=>e_xml_text ).

    APPEND INITIAL LINE TO mt_stream ASSIGNING <ls_segment>.
    <ls_segment>-name  = gc_xml.
    <ls_segment>-name = `ab_` && <ls_segment>-name.
    CREATE DATA <ls_segment>-value TYPE string.
    ASSIGN <ls_segment>-value->* TO <lv_xml>.
    <lv_xml> = lv_xml.

  ENDMETHOD.
ENDCLASS.
