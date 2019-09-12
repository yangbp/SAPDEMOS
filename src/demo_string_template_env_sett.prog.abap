REPORT demo_string_template_env_sett.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: num    TYPE p DECIMALS 2,
          date   TYPE d,
          time   TYPE t,
          tstamp TYPE timestampl,
          BEGIN OF country,
            key  TYPE t005x-land,
            name TYPE t005t-landx,
          END OF country,
          country_tab LIKE TABLE OF country.

    DATA: BEGIN OF result,
            name      TYPE string,
            key       TYPE string,
            number    TYPE string,
            date      TYPE string,
            time      TYPE string,
            timestamp TYPE string,
          END OF result,
          results LIKE TABLE OF result.

    SELECT land AS key
           FROM t005x
           ORDER BY PRIMARY KEY
           INTO CORRESPONDING FIELDS OF TABLE @country_tab
           ##TOO_MANY_ITAB_FIELDS.

    LOOP AT country_tab INTO country.
      SELECT SINGLE landx AS name
             FROM t005t
             WHERE  land1 = @country-key AND
                    spras = @sy-langu
             INTO CORRESPONDING FIELDS OF @country.
      MODIFY country_tab FROM country INDEX sy-tabix.
    ENDLOOP.

    SORT country_tab BY name AS TEXT.
    INSERT VALUE #( key =  space name = 'User Master Record' )
           INTO country_tab INDEX 1.

    num  = sy-datum / 100.
    date = sy-datum.
    time = sy-uzeit.
    GET TIME STAMP FIELD tstamp.

    LOOP AT country_tab INTO country.
      DATA(tabix) = sy-tabix.
      SET COUNTRY country-key.
      results = VALUE #( BASE results
      ( name      = country-name
        key       = country-key
        number    = |{ num    NUMBER    = ENVIRONMENT }|
        date      = |{ date   DATE      = ENVIRONMENT }|
        time      = |{ time   TIME      = ENVIRONMENT }|
        timestamp = |{ tstamp TIMESTAMP = ENVIRONMENT }| ) ).
      IF tabix = 1.
        results = VALUE #( BASE results ( ) ).
      ENDIF.
    ENDLOOP.

    cl_demo_output=>display( results ).

  ENDMETHOD.                    "main
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
