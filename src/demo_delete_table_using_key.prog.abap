REPORT demo_delete_table_using_key.

CLASS measure DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: BEGIN OF tline,
                  col1 TYPE i,
                  col2 TYPE i,
                END OF tline,
                itab LIKE HASHED TABLE
           OF tline
           WITH UNIQUE KEY primary_key
             COMPONENTS col1
           WITH NON-UNIQUE SORTED KEY secondary_key
             COMPONENTS col2,
                jtab LIKE SORTED TABLE
           OF tline
           WITH NON-UNIQUE KEY primary_key
             COMPONENTS col2.
    CLASS-METHODS refresh_itab.
ENDCLASS.

CLASS measure IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).
    DATA: t1 TYPE i,
          t2 TYPE i,
          t  TYPE i.
    refresh_itab( ).
    CLEAR t.
    GET RUN TIME FIELD t1.
    DELETE itab WHERE col2 = 10 ##primkey[secondary_key].
    GET RUN TIME FIELD t2.
    t = t + t2 - t1.
    out->write_text(
      |Delete without using secondary sorted key: { t }| ).
    refresh_itab( ).
    CLEAR t.
    GET RUN TIME FIELD t1.
    DELETE itab USING KEY secondary_key
                      WHERE col2 = 10.
    GET RUN TIME FIELD t2.
    t = t + t2 - t1.
    out->write_text(
      |Delete without using secondary sorted key: { t }| ).
    refresh_itab( ).
    jtab = itab.
    CLEAR t.
    GET RUN TIME FIELD t1.
    cl_abap_itab_utilities=>flush_itab_key(
      EXPORTING keyname = 'SECONDARY_KEY'
      CHANGING  itab    = itab ).
    GET RUN TIME FIELD t2.
    t = t + t2 - t1.
    out->write_text( |Create secondary index: { t }| ).
    CLEAR t.
    GET RUN TIME FIELD t1.
    DELETE itab USING KEY secondary_key
                      WHERE col2 = 10.
    GET RUN TIME FIELD t2.
    t = t + t2 - t1.
    out->write_text(
      |Delete via secondary sorted key with existing index: { t }| ).
    CLEAR t.
    GET RUN TIME FIELD t1.
    DELETE jtab WHERE col2 = 10.
    GET RUN TIME FIELD t2.
    t = t + t2 - t1.
    out->write_text(
      |Delete via primary sorted key: { t }|
      )->display( ).
  ENDMETHOD.
  METHOD refresh_itab.
    DATA prng TYPE REF TO cl_abap_random_int.
    prng = cl_abap_random_int=>create( seed = + sy-uzeit
                                       min  = 1
                                       max  = 10 ).
    itab = VALUE #(
      FOR j = 1 UNTIL j > 100000 ( col1 = j
                                   col2 = prng->get_next( ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  measure=>main( ).
