REPORT demo_db_copy.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA:
      source TYPE c LENGTH 255
             VALUE '/SAP/PUBLIC/BC/ABAP/mime_demo/ABAP_Docu_Logo.gif',
      target TYPE c LENGTH 255
             VALUE 'picture_copy'.

    DATA wa TYPE demo_blob_table LOCATOR FOR ALL COLUMNS.

    cl_demo_input=>add_field( CHANGING field = source ).
    cl_demo_input=>request(   CHANGING field = target ).

    SELECT SINGLE picture
           FROM demo_blob_table
           WHERE name = @source
           INTO @wa-picture.

    IF sy-subrc <> 0.
      cl_demo_output=>display(
        'Nothing found, run DEMO_DB_WRITER first!' ).
      RETURN.
    ENDIF.

    wa-name = target.
    INSERT demo_blob_table FROM @wa.

    IF sy-subrc = 0.
      cl_demo_output=>display(
        'You can run DEMO_DB_READER with new name now' ).
    ELSE.
      cl_demo_output=>display(
        'Target already exists' ).
    ENDIF.

    wa-picture->close( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
