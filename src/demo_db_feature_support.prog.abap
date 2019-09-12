REPORT demo_db_feature_support.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      BEGIN OF dbfeature,
        name  TYPE abap_attrdescr-name,
        value TYPE ddfeature_nr,
      END OF dbfeature,
      dbfeatures TYPE STANDARD TABLE OF dbfeature WITH EMPTY KEY.

    TYPES: BEGIN OF list_line,
             feature TYPE abap_attrdescr-name,
             dbs     TYPE string,
           END OF list_line.

    DATA(attributes) = CAST cl_abap_classdescr(
      cl_abap_classdescr=>describe_by_name(
        'CL_ABAP_DBFEATURES' ) )->attributes.
    DATA(dbfeatures_osql) = VALUE dbfeatures(
      FOR wa IN attributes
             WHERE ( is_constant = 'X' AND
                     visibility  =  cl_abap_classdescr=>public AND
                     type_kind   = 'I' )
             ( name = wa-name ) ).

    LOOP AT dbfeatures_osql ASSIGNING FIELD-SYMBOL(<dbfeature>).
      ASSIGN cl_abap_dbfeatures=>(<dbfeature>-name)
             TO FIELD-SYMBOL(<value>).
      IF <value> < 0.
        DELETE dbfeatures_osql.
        CONTINUE.
      ENDIF.
      <dbfeature>-value = <value>.
    ENDLOOP.
    SORT dbfeatures_osql BY name.

    DELETE dbfeatures_osql WHERE name = 'OFFSET_CLAUSE'.
    IF sy-saprl >= '750'.
      DELETE dbfeatures_osql WHERE name = 'VIEWS_WITH_PARAMETERS'.
    ENDIF.

    "Mapping CL_ABAP_DBFEATURES to CL_DD_DBFEATURES
    DATA dbfeatures_dd LIKE dbfeatures_osql.
    LOOP AT dbfeatures_osql INTO DATA(dbfeature).
      CASE dbfeature-name.
        WHEN 'AMDP_TABLE_FUNCTION'.
          dbfeatures_dd = VALUE #( BASE dbfeatures_dd ( name = 'IS_AMDP_TABLEFUNCTION' value = 14 )  ). "HDB
        WHEN 'CALL_AMDP_METHOD'.
          dbfeatures_dd = VALUE #( BASE dbfeatures_dd ( name = 'IS_AMDP_TABLEFUNCTION' value = 14 )  ). "HDB
        WHEN 'CALL_DATABASE_PROCEDURE'.
          dbfeatures_dd = VALUE #( BASE dbfeatures_dd ( name = 'IS_AMDP_TABLEFUNCTION' value = 14 )  ). "HDB
        WHEN 'EXTERNAL_VIEWS'.
          dbfeatures_dd = VALUE #( BASE dbfeatures_dd ( name = 'EXTERNAL_VIEW' value = 3 )  ).
        WHEN 'TABLE_KEYCNT_MAX1'.
          dbfeatures_dd = VALUE #( BASE dbfeatures_dd ( name = 'TABLE_WITH_KEYCNT_MAX1' value = 7 )  ).
        WHEN 'TABLE_KEYLEN_MAX1'.
          dbfeatures_dd = VALUE #( BASE dbfeatures_dd ( name = 'TABLE_WITH_KEYLEN_MAX1' value = 8 )  ).
        WHEN 'TABLE_LEN_MAX1'.
          dbfeatures_dd = VALUE #( BASE dbfeatures_dd ( name = 'TABLE_WITH_LEN_MAX1' value = 9 )  ).
        WHEN 'VIEWS_WITH_PARAMETERS'.
          dbfeatures_dd = VALUE #( BASE dbfeatures_dd ( name = 'VIEW_WITH_PARAMETERS' value = 6 )  ).
      ENDCASE.
    ENDLOOP.
    IF lines( dbfeatures_osql ) <> lines( dbfeatures_dd ).
      cl_demo_output=>display( 'Open SQL feature list could not be mapped to dictionary feature list').
      RETURN.
    ENDIF.


    DATA tabl_list TYPE STANDARD TABLE OF list_line WITH EMPTY KEY.
    LOOP AT dbfeatures_dd INTO dbfeature.
      DATA(idx) = sy-tabix.
      tabl_list = VALUE #( BASE tabl_list
                      ( feature = dbfeatures_osql[ idx ]-name
                        dbs     = cl_dd_dbfeatures=>get_dbs_4_feature( ddtype = 'TABL'
                                                                       feature_nr = dbfeature-value ) ) ).


    ENDLOOP.

    DATA view_list TYPE STANDARD TABLE OF list_line WITH EMPTY KEY.
    LOOP AT dbfeatures_dd INTO dbfeature.
      idx = sy-tabix.
      view_list = VALUE #( BASE view_list
                      ( feature = dbfeatures_osql[ idx ]-name
                        dbs     = cl_dd_dbfeatures=>get_dbs_4_feature( ddtype = 'VIEW'
                                                                       feature_nr = dbfeature-value ) ) ).


    ENDLOOP.

    DATA db_support_list LIKE view_list.
    DO lines( view_list ) TIMES.
      idx = sy-index.
      DATA(view_string) = view_list[ idx ]-dbs.
      DATA(tabl_string) = tabl_list[ idx ]-dbs.
      REPLACE `REF` IN view_string WITH `` RESPECTING CASE.
      REPLACE `REF` IN tabl_string WITH `` RESPECTING CASE.
      SPLIT condense( view_string ) AT ` ` INTO TABLE DATA(view_dbs).
      SPLIT condense( view_string ) AT ` ` INTO TABLE DATA(tabl_dbs).
      DATA final_dbs TYPE TABLE OF string WITH EMPTY KEY.
      final_dbs = VALUE #( ( LINES OF view_dbs ) ( LINES OF tabl_dbs ) ).
      SORT final_dbs BY table_line.
      DELETE ADJACENT DUPLICATES FROM final_dbs COMPARING table_line.
      CONCATENATE LINES OF final_dbs INTO DATA(final_string) SEPARATED BY ` `.
      db_support_list = VALUE #( BASE db_support_list ( feature = view_list[ idx ]-feature
                                                        dbs     = condense( final_string ) ) ).
    ENDDO.
    cl_demo_output=>write( db_support_list ).
    cl_demo_output=>display( |Disclaimer:\nThis output is the result of a demonstration and supplied without liability.| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
