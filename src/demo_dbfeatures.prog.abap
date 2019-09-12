REPORT demo_dbfeatures.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      BEGIN OF dbfeature,
        flag  TYPE abap_bool,
        name  TYPE abap_attrdescr-name,
        value TYPE ddfeature_nr,
      END OF dbfeature,
      dbfeatures TYPE STANDARD TABLE OF dbfeature WITH EMPTY KEY.

    DATA supported   TYPE TABLE OF string WITH EMPTY KEY.
    DATA unsupported TYPE TABLE OF string WITH EMPTY KEY.
    DATA obsolete    TYPE TABLE OF string WITH EMPTY KEY.

    obsolete = VALUE #( ( `VIEWS_WITH_PARAMETERS` ) ).

    DATA(attributes) = CAST cl_abap_classdescr(
      cl_abap_classdescr=>describe_by_name(
        'CL_ABAP_DBFEATURES' ) )->attributes.
    DATA(dbfeatures) = VALUE dbfeatures(
      FOR wa IN attributes
             WHERE ( is_constant = 'X' AND
                     visibility  =  cl_abap_classdescr=>public AND
                     type_kind   = 'I' )
             ( flag = 'X' name = wa-name ) ).
    LOOP AT dbfeatures ASSIGNING FIELD-SYMBOL(<dbfeature>).
      IF line_exists( obsolete[ table_line = <dbfeature>-name ] ).
        DELETE dbfeatures.
        CONTINUE.
      ENDIF.
      ASSIGN cl_abap_dbfeatures=>(<dbfeature>-name)
             TO FIELD-SYMBOL(<value>).
      IF <value> < 0.
        DELETE dbfeatures.
        CONTINUE.
      ENDIF.
      <dbfeature>-value = <value>.
    ENDLOOP.
    SORT dbfeatures BY name.
    DATA(in) = cl_demo_input=>new( )->add_text(
      `Select the DB features to be checked` ).
    LOOP AT dbfeatures ASSIGNING <dbfeature>.
      in->add_field(
        EXPORTING text        = CONV #( <dbfeature>-name )
                  as_checkbox = 'X'
        CHANGING  field       = <dbfeature>-flag ).
    ENDLOOP.
    in->request( ).
    IF REDUCE string( INIT flag = ``
                      FOR <wa> IN dbfeatures
                      NEXT flag = flag && <wa>-flag ) IS INITIAL.
      RETURN.
    ENDIF.
    DATA(out) = cl_demo_output=>new( ).
    out = COND #(
            LET txt = `selected features are supported by the current `
                      && sy-dbsys && ` version` IN
            WHEN cl_abap_dbfeatures=>use_features(
              EXPORTING requested_features =
                VALUE #( FOR <wa> IN dbfeatures WHERE ( flag = 'X' )
                         ( <wa>-value ) ) )
              THEN out->write( `All ` && txt )
              ELSE out->write( `Not all ` && txt ) ).
    LOOP AT dbfeatures ASSIGNING <dbfeature> WHERE flag = 'X'.
      IF cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( <dbfeature>-value ) ) ).
        supported =
          VALUE #( BASE supported ( CONV #( <dbfeature>-name ) ) ).
      ELSE.
        unsupported =
          VALUE #( BASE unsupported ( CONV #( <dbfeature>-name ) ) ).
      ENDIF.
    ENDLOOP.
    out->line( )->write( supported )->display( unsupported ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
