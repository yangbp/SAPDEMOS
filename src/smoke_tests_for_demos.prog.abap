REPORT smoke_tests_for_demos.

* This program calls the demo programs that have no controls.
* It can be called by an appropriate eCATT script.

PARAMETERS: group_01 RADIOBUTTON GROUP grps,
            group_02 RADIOBUTTON GROUP grps,
            group_03 RADIOBUTTON GROUP grps,
            group_04 RADIOBUTTON GROUP grps,
            group_05 RADIOBUTTON GROUP grps,
            group_06 RADIOBUTTON GROUP grps,
            group_07 RADIOBUTTON GROUP grps,
            group_08 RADIOBUTTON GROUP grps,
            group_09 RADIOBUTTON GROUP grps,
            group_10 RADIOBUTTON GROUP grps,
            group_11 RADIOBUTTON GROUP grps,
            group_12 RADIOBUTTON GROUP grps,
            group_13 RADIOBUTTON GROUP grps,
            group_14 RADIOBUTTON GROUP grps.
SELECTION-SCREEN SKIP.
PARAMETERS: group_pd RADIOBUTTON GROUP grps,
            group_ct RADIOBUTTON GROUP grps,
            group_ny RADIOBUTTON GROUP grps.

CLASS demo_programs DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS call_programs.
ENDCLASS.

CLASS demo_programs IMPLEMENTATION.
  METHOD call_programs.

    IF group_01 = 'X'. "ABAP Objects

      SUBMIT demo_abap_objects VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_abap_objects VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_abap_objects VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_abap_objects VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_class_counter VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_inheritance VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_interface VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_abap_objects_events VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_event_inheritance VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_02 = 'X'. "Database Access

      SUBMIT demo_joins VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_select_cursor VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_select_subquery VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_where_in_seltab VIA SELECTION-SCREEN AND RETURN.

      TRY.
          EXEC                                          "#EC CI_EXECSQL
            SQL.
            DROP TABLE abap_docu_demo_mytab
          ENDEXEC.
        CATCH cx_sy_native_sql_error.
      ENDTRY.
      SUBMIT demo_exec_sql VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_adbc_ddl_dml VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_adbc_ddl_dml_binding VIA SELECTION-SCREEN AND RETURN.

      DELETE FROM demo_blob_table WHERE name = 'picture_copy'.
      SUBMIT demo_db_copy VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_db_writer VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_db_locator VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_transaction_enqueue VIA SELECTION-SCREEN AND RETURN.

      DELETE FROM spfli WHERE carrid = 'LH' AND connid = '0123'.
      SUBMIT demo_create_persistent VIA SELECTION-SCREEN AND RETURN.
      WAIT UP TO 10 SECONDS.
      SUBMIT demo_transaction_service VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_create_persistent VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_query_service VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_03 = 'X'. "Internal Tables, Extracts

      SUBMIT demo_int_tables_append VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_int_tables_sort_text VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_int_tables_compare VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_read_table_result VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_read_table_using_key VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_int_tables_delete_adjacen VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_loop_at_itab_using_key VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_modify_table_using_key VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_int_tables_insert VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_int_tables_delete_ind_1 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_delete_table_using_key VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_int_tables_at_1 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_int_tables_sort VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_extract_at_new VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_extract_cnt_sum VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_04 = 'X'. "Dynpros

      SUBMIT demo_hello_world VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_value_select VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_context_menu VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_dictionary VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dropdown_list_box VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_dropdown_listbox VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_field VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_field_chain VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_get_cursor VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_gui_status VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_set_hold_data VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_input_output VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_modify_simple VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_on_condition VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_push_button VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_check_radio VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_set_cursor VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_module VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_status_icons VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_strings VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_subscreens VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_at_exit_command VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_automatic_checks VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_step_loop VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_tabcont_loop VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_tabcont_loop_at VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_tabstrip_local VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_tabstrip_server VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dialog_module VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_call_transaction_spa_gpa VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_modify_screen VIA SELECTION-SCREEN AND RETURN.


    ELSEIF group_05 = 'X'. "Selection Screen

      SUBMIT demo_sel_screen_function_key VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_at_selection_on_block VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_sel_screen_pushbutton VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_call_selection_screen VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_sel_screen_parameters_2 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_selection_screen_f1 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_selection_screen_f4 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_sel_screen_status VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_sel_screen_screen_opt VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_sel_screen_parameters_1 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_sel_screen_select_options VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_sel_screen_select_default VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_sel_screen_as_subscreen VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_sel_screen_in_tabstrip VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_sel_screen_with_subscreen VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_sel_screen_with_tabstrip VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_06 = 'X'. "Assignments etc.

      SUBMIT demo_conversion_costs VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_int_to_hex VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_data_conversion_structure VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_bit_set VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_data_bit VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_data_date_time VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_data_calculate VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_compute_exact VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_floating_point_numbers VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_numerical_function VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_nmax_nmin VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_round VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_data_process_fields VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_describe_distance VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_describe_field VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_assign_increment VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_field_symbols_casting VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_field_symbols_assign_deci VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_field_symbols_assign_type VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_field_symbols_structure VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_07 = 'X'. "Calls

      SUBMIT demo_call_function VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_method_chaining VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_parallel_rfc VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_procedure_param VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_rfc_exceptions VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_program_read_tables VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_program_submit_line VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_program_submit_sel_screen VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_program_submit_sel_screen VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_program_submit_rep VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_typing  VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_08 = 'X'. "String processing

      SUBMIT demo_cmax_cmin VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_matches VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_string_distance VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_escape VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_find_and_match VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_to_from_mixed VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_shift_substring VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_string_template_align_pad VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_string_template_case VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_string_template_sign VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_string_template_timezone VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_string_template_width VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_style VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_validate_rfc_822_address VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_09 = 'X'. "Create, types

      SUBMIT demo_create_data_via_handle VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_create_reference VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_create_simple_data VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_create_structured_data VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_create_tabular_data VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_rtti_data_types VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_rtti_object_types VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_types_lob_handle VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_10 = 'X'. "Exceptions

      SUBMIT demo_catch_exception VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_try VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_context_message VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_11 = 'X'. "Classical lists

      SUBMIT demo_leave_to_list_processing VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_format_color_1 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_format_color_2 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_hide VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_line_elements VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_pages VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_top_of_page VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_window VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_list_print VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_logical_database VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_logical_expr_seltab_1 VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_12 = 'X'. "Miscellaneous

      SUBMIT demo_macro VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_get_run_time VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_set_locale VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_13 = 'X'. "Lucky thirteen (demos not mentioned in docu)

      SUBMIT abap_objects_enjoy_0 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT abap_objects_enjoy_1 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT abap_objects_enjoy_2 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT abap_objects_enjoy_3 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT abap_objects_enjoy_4 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT abap_objects_enjoy_5 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_abap_objects_general VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_abap_objects_methods VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_class_counter_event VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_objects_references VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_selection_screen_events VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_dynpro_table_control_1 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpro_table_control_2 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_dynpros_and_lists VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_list_context_menu VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_get_cursor VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_output VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_set_titlebar VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_system_fields VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_list_write_currency VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_exception_text VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_local_exception_1 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_local_exception_2 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_local_exception_3 VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_propagate_exceptions VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_messages VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_function_group_counter VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_14 = 'X'. "Transactions

      CALL TRANSACTION 'DEMO_OO_METHOD' WITH AUTHORITY-CHECK.
      CALL TRANSACTION 'DEMO_REPORT_TRANSACT' WITH AUTHORITY-CHECK.
      CALL TRANSACTION 'DEMO_SCREEN_FLOW' WITH AUTHORITY-CHECK.
      CALL TRANSACTION 'DEMO_SELSCREEN_DYNP' WITH AUTHORITY-CHECK.
      CALL TRANSACTION 'DEMO_TRANSACTION'  WITH AUTHORITY-CHECK.

    ELSEIF group_ct = 'X'. "Contains controls

      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_asxml_elementary VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_abap_xml_schema_mapping VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_asxml_qname VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_asxml_structure VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_asxml_table VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_asxml_object VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_st VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_st_table VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_xsl_transformation  VIA SELECTION-SCREEN AND RETURN.

      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_adbc_query VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_adbc_prepared_statement VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_db_writer VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_db_reader VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_dynamic_sql VIA SELECTION-SCREEN AND RETURN.

      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_nested_internal_tables VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_secondary_keys VIA SELECTION-SCREEN AND RETURN.

      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_regex VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_regex_toy VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_string_template_ctrl_char VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_string_template_date_form VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_string_template_numb_form VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_string_template_time_form VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_string_template_env_sett VIA SELECTION-SCREEN AND RETURN.

      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_expressions VIA SELECTION-SCREEN AND RETURN.

      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_dynpro VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_custom_control VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_dynpro_f1_help VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_dynpro_f4_help_module VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_dynpro_f4_help_dictionary VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_dynpro_f4_help_dynpro VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_cfw_1 VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_cfw_3 VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_cfw VIA SELECTION-SCREEN AND RETURN.
      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_picture_control VIA SELECTION-SCREEN AND RETURN.

      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_call_transaction_bdc VIA SELECTION-SCREEN AND RETURN.

      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_show_text VIA SELECTION-SCREEN AND RETURN.

      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_html_browser VIA SELECTION-SCREEN AND RETURN.

      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_java_script_mini_editor VIA SELECTION-SCREEN AND RETURN.

      MESSAGE 'New Demo' TYPE 'I'.                          "#EC NOTEXT
      SUBMIT demo_dynpro_splitter_control VIA SELECTION-SCREEN AND RETURN.

    ELSEIF group_pd = 'X'. "Platform dependend or other problems

      SUBMIT demo_adbc_stored_procedure VIA SELECTION-SCREEN AND RETURN.

      SUBMIT demo_memory_usage VIA SELECTION-SCREEN AND RETURN.
      "Breakpoint in Program

      SUBMIT demo_cfw_2 VIA SELECTION-SCREEN AND RETURN.
      "Error in Script processing


    ELSEIF group_ny = 'X'. "Todo list, not yet tested

      SUBMIT demo_checkpoints VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_move_exact  VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_create_shared_object VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_create_shared_data_object VIA SELECTION-SCREEN AND RETURN.
      SUBMIT demo_free_selections VIA SELECTION-SCREEN AND RETURN.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo_programs=>call_programs( ).

* Unit test class to execute eCatts to see coverage in Unit Browser

CLASS smoke_test DEFINITION FINAL FOR TESTING RISK LEVEL HARMLESS DURATION LONG.
  PRIVATE SECTION.
    METHODS execute_ecatt_scripts FOR TESTING.
ENDCLASS.


CLASS smoke_test IMPLEMENTATION.
  METHOD execute_ecatt_scripts.

    CONSTANTS type TYPE etexe_obj-obj_name VALUE 'ECSC'.

    DATA  group             TYPE n LENGTH 2.
    DATA  name              TYPE etexe_obj-obj_name.
    DATA  ecatt_scripts     TYPE etexe_obj_tabtype.

    FIELD-SYMBOLS <ecatt_script>  TYPE etexe_obj.

    DO 14 TIMES.
      group = sy-index.
      name = 'ABAP_DEMOS_GROUP_' && group.
      CLEAR ecatt_scripts.
      INSERT INITIAL LINE INTO TABLE ecatt_scripts ASSIGNING <ecatt_script>.
      <ecatt_script>-obj_type =  type.
      <ecatt_script>-obj_name =  name.
      <ecatt_script>-obj_lnr  =  1.
      <ecatt_script>-start_lnr = 1.
      CALL FUNCTION 'ECATT_EXECUTE'
        EXPORTING
          to_execute              = ecatt_scripts
          display_log             = ' '
          display_start_popup     = abap_false
          i_supress_output        = abap_true
        EXCEPTIONS
          nothing_to_do           = 1
          too_many_scripts_called = 2
          OTHERS                  = 3.
      IF sy-subrc <> 0.
        cl_aunit_assert=>fail(
          EXPORTING
            msg    = 'Error executing eCATT'                "#EC NOTEXT
            level  = cl_aunit_assert=>critical ).
      ENDIF.
    ENDDO.
  ENDMETHOD.
ENDCLASS.

* Unit test class to check completeness of smoke tests

CLASS smoke_complete DEFINITION FINAL FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PRIVATE SECTION.
    METHODS check FOR TESTING.
ENDCLASS.


CLASS smoke_complete IMPLEMENTATION.
  METHOD check.
    DATA tested TYPE TABLE OF string.
    FIELD-SYMBOLS <str>    TYPE string.

    DATA tadir_tab TYPE TABLE OF string.
    DATA subc TYPE trdir-subc.
    DATA idx TYPE i.

    READ REPORT 'SMOKE_TESTS_FOR_DEMOS' INTO tested.

    DELETE tested WHERE table_line NS 'VIA SELECTION-SCREEN'.
    REPLACE ALL OCCURRENCES OF `"SUBMIT` IN TABLE tested WITH ``.
    REPLACE ALL OCCURRENCES OF `SUBMIT` IN TABLE tested WITH ``.
    REPLACE ALL OCCURRENCES OF `VIA SELECTION-SCREEN AND RETURN.` IN TABLE tested WITH ``.

    LOOP AT tested ASSIGNING <str>.
      CONDENSE <str>.
      TRANSLATE <str> TO UPPER CASE.
    ENDLOOP.

    SORT tested AS TEXT.

    SELECT obj_name                                     "#EC CI_GENBUFF
           FROM tadir
           WHERE pgmid = 'R3TR' AND
                 object = 'PROG' AND
                 srcsystem = 'B20' AND
                 devclass  = 'SABAPDEMOS'
           INTO TABLE @tadir_tab.

    SORT tadir_tab AS TEXT.

    DELETE tadir_tab WHERE table_line = 'SMOKE_TESTS_FOR_DEMOS' OR
                           table_line = 'UNIT_TEST_OF_DEMOS'.

    LOOP AT tadir_tab ASSIGNING <str>.
      idx = sy-tabix.
      SELECT SINGLE subc
             FROM trdir
             WHERE name = @<str>
             INTO @subc.
      IF sy-subrc <> 0.
        DELETE tadir_tab INDEX idx.
        CONTINUE.
      ELSE.
        IF subc <> '1'.
          DELETE tadir_tab INDEX idx.
        ENDIF.
      ENDIF.
    ENDLOOP.

    LOOP AT tested ASSIGNING <str>.
      DELETE tadir_tab WHERE table_line = <str>.
    ENDLOOP.

    cl_aunit_assert=>assert_initial(
      EXPORTING
        act              =     tadir_tab
        msg              =     'Unclassified programs in SABAPDEMOS' "#EC NOTEXT
        level            =     cl_aunit_assert=>tolerable ).

  ENDMETHOD.
ENDCLASS.
