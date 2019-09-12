REPORT demo_program_submit_line.

SELECTION-SCREEN BEGIN OF SCREEN 1100.
PARAMETERS: name   TYPE sy-repid
                   DEFAULT 'DEMO_PROGRAM_READ_TABLES' OBLIGATORY,
            width  TYPE i        DEFAULT 80,
            length TYPE i        DEFAULT 0.
SELECTION-SCREEN END OF SCREEN 1100.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS security_check
      IMPORTING name TYPE sy-repid
      RETURNING value(checked_name) TYPE sy-repid.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA prog_type TYPE trdir-subc.
    CALL SELECTION-SCREEN 1100 STARTING AT 10 10.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    SELECT SINGLE subc
           FROM trdir
           WHERE name = @name
           INTO @prog_type.
    IF sy-subrc <> 0 OR prog_type <> '1'.
      MESSAGE 'Program not found or wrong type' TYPE 'I'
                                                DISPLAY LIKE 'E'.
      RETURN.
    ENDIF.
    name = security_check( name ).
    IF  name IS INITIAL.
      MESSAGE 'Program execution not allowed' TYPE 'I'
                                              DISPLAY LIKE 'E'.
      RETURN.
    ENDIF.
    SUBMIT (name) LINE-SIZE width LINE-COUNT length AND RETURN.
  ENDMETHOD.
  METHOD security_check.
    DATA whitelist TYPE HASHED TABLE OF string
                   WITH UNIQUE KEY table_line.
    AUTHORITY-CHECK OBJECT 'S_DEVELOP'
      ID 'DEVCLASS' FIELD 'SABAPDEMOS'
      ID 'OBJTYPE'  FIELD 'PROG'
      ID 'OBJNAME'  DUMMY
      ID 'P_GROUP'  DUMMY
      ID 'ACTVT'    FIELD '16'.
    IF sy-subrc <>  0.
      CLEAR checked_name.
      RETURN.
    ENDIF.
    SELECT obj_name
           FROM tadir
           WHERE pgmid = 'R3TR' AND
                object = 'PROG' AND
                devclass = 'SABAPDEMOS'
           INTO TABLE @whitelist.
    TRY.
        checked_name = cl_abap_dyn_prg=>check_whitelist_tab(
          val = name
          whitelist = whitelist ).
      CATCH cx_abap_not_in_whitelist.
        CLEAR checked_name.
        RETURN.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
