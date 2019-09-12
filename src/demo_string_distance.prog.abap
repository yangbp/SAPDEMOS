REPORT demo_string_distance.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: word    TYPE c LENGTH 30 VALUE 'CALL METHOD',
          percent TYPE i VALUE 50.
    cl_demo_input=>add_field( CHANGING field = word ).
    cl_demo_input=>request(   CHANGING field = percent ).
    IF word IS INITIAL.
      cl_demo_output=>display(
        'Enter a word' ).
      RETURN.
    ENDIF.
    IF percent NOT BETWEEN 0 AND 100.
      cl_demo_output=>display(
         'Enter a percentage between 0 and 100' ).
      RETURN.
    ENDIF.

    TYPES: BEGIN OF distance,
             text TYPE string,
             dist TYPE i,
           END OF distance.
    DATA: index_tab TYPE REF TO cl_abap_docu=>abap_index_tab,
          distances TYPE SORTED TABLE OF distance
                    WITH NON-UNIQUE KEY dist.

    index_tab = cl_abap_docu=>get_abap_index(
      COND #( WHEN sy-langu <> 'D'
                      THEN 'E'
                      ELSE 'D' ) ).
    LOOP AT index_tab->* ASSIGNING FIELD-SYMBOL(<index>).
      DATA(str1) = to_upper( val = <index>-key1 ).
      DATA(str2) = to_upper( val = word ).
      DATA(max) = COND i( WHEN strlen( str1 ) > strlen( str2 )
                            THEN strlen( str1 )
                            ELSE strlen( str2 ) ).
      max = ( 100 - percent  ) * max / 100 + 1.
      DATA(dist) = distance( val1 = str1 val2 = str2 max = max ).
      IF dist < max.
        distances = VALUE #( BASE distances
                            ( text = str1 dist = dist ) ).
      ENDIF.
    ENDLOOP.

    cl_demo_output=>display( distances ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
