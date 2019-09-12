REPORT demo_read_table_using_key.

CLASS measure DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: m   TYPE i,
                itab TYPE STANDARD TABLE
                     OF i
                     WITH NON-UNIQUE    KEY primary_key
                       COMPONENTS table_line
                     WITH UNIQUE SORTED KEY sorted_key
                       COMPONENTS table_line
                     WITH UNIQUE HASHED KEY hashed_key
                       COMPONENTS table_line
                     ##tabkey[hashed_key][sorted_key],
                out TYPE REF TO if_demo_output.
    CLASS-METHODS: measure_static  IMPORTING key TYPE string,
                   measure_dynamic IMPORTING key TYPE string.
ENDCLASS.

CLASS measure IMPLEMENTATION.
  METHOD main.
    DATA: n TYPE i,
          j TYPE i.
    DATA max TYPE i VALUE 1000.
    cl_demo_input=>request( EXPORTING text  = 'Maximum line number'
                            CHANGING  field = max ).
    out = cl_demo_output=>new(
      )->begin_section( 'Accessing Internal Tables by Keys' ).
    n = 10.
    WHILE n <= max / 10.
      IF n = 10.
        m = 0.
        j = 10.
      ELSE.
        m = n.
        j = 9.
      ENDIF.
      DO j TIMES.
        m = m + n.
        itab = VALUE #( BASE itab FOR k = 1 UNTIL k > m ( k ) ).
        out->line( ).
        out->begin_section( 'Static:' ).
        measure_static( key = `primary_key` ).
        measure_static( key = `sorted_key`  ).
        measure_static( key = `hashed_key`  ).
        out->next_section( 'Dynamic:' ).
        measure_dynamic( key = `primary_key` ).
        measure_dynamic( key = `sorted_key`  ).
        measure_dynamic( key = `hashed_key`  ).
        out->end_section( ).
        CLEAR itab.
      ENDDO.
      n = n * 10.
    ENDWHILE.
    out->display( ).
  ENDMETHOD.
  METHOD measure_static.
    DATA: t1  TYPE i,
          t2  TYPE i,
          t   TYPE p DECIMALS 2,
          idx TYPE i.
    CLEAR t.
    IF key = `primary_key`.
      DO m TIMES.
        idx = sy-index.
        GET RUN TIME FIELD t1.
        READ TABLE itab
                   WITH TABLE KEY primary_key
                     COMPONENTS table_line = idx
                   TRANSPORTING NO FIELDS.
        GET RUN TIME FIELD t2.
        t = t + t2 - t1.
      ENDDO.
    ELSEIF key = `sorted_key`.
      DO m TIMES.
        idx = sy-index.
        GET RUN TIME FIELD t1.
        READ TABLE itab
                   WITH TABLE KEY sorted_key
                     COMPONENTS table_line = idx
                   TRANSPORTING NO FIELDS.
        GET RUN TIME FIELD t2.
        t = t + t2 - t1.
      ENDDO.
    ELSEIF key = `hashed_key`.
      DO m TIMES.
        idx = sy-index.
        GET RUN TIME FIELD t1.
        READ TABLE itab
                   WITH TABLE KEY hashed_key
                     COMPONENTS table_line = idx
                   TRANSPORTING NO FIELDS.
        GET RUN TIME FIELD t2.
        t = t + t2 - t1.
      ENDDO.
    ENDIF.
    t = t / m.
    out->write( |{ m }   { t }| ).
  ENDMETHOD.
  METHOD measure_dynamic.
    DATA: t1  TYPE i,
          t2  TYPE i,
          t   TYPE p DECIMALS 2,
          idx TYPE i.
    CLEAR t.
    DO m TIMES.
      idx = sy-index.
      GET RUN TIME FIELD t1.
      READ TABLE itab
                 WITH TABLE KEY (key)
                   COMPONENTS table_line = idx
                 TRANSPORTING NO FIELDS.
      GET RUN TIME FIELD t2.
      t = t + t2 - t1.
    ENDDO.
    t = t / m.
    out->write( |{ m }   { t }| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  measure=>main( ).
