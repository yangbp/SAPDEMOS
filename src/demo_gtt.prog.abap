REPORT demo_gtt.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(o) = cl_demo_output=>new( ).

    DATA delete TYPE abap_bool.
    cl_demo_input=>request(
      EXPORTING text         = `Delete lines before implicit commit`
                as_checkbox = abap_true
      CHANGING  field       = delete ).

    "Fill GTT with Open SQL
    INSERT demo_gtt FROM @( VALUE #( id = 'X' col = 111 ) ).
    SELECT SINGLE * FROM demo_gtt INTO @DATA(wa).
    o->write( COND #( WHEN sy-subrc = 0
                      THEN `Line found after open insert`
                      ELSE `No line found after open insert` ) ).
    IF delete = abap_true.
      DELETE FROM demo_gtt.
    ENDIF.
    WAIT UP TO 1 SECONDS.
    SELECT SINGLE * FROM demo_gtt INTO @wa.
    o->write( COND #( WHEN sy-subrc = 0
                      THEN `Line found after implicit commit`
                      ELSE `No line found after implicit commit` ) ).

    "Fill GTT with Native SQL (for demonstration only!)
    wa = VALUE demo_gtt( id = 'X' col = 111 ).
    EXEC SQL.
      INSERT INTO DEMO_GTT VALUES ( :wa-id, :wa-col )
    ENDEXEC.
    SELECT SINGLE * FROM demo_gtt INTO @wa.
    o->write( COND #( WHEN sy-subrc = 0
                      THEN `Line found after native insert`
                      ELSE `No line found after native insert` ) ).
    WAIT UP TO 1 SECONDS.
    SELECT SINGLE * FROM demo_gtt INTO @wa.
    o->write( COND #( WHEN sy-subrc = 0
                      THEN `Line found after implicit commit`
                      ELSE `No line found after implicit commit` ) ).

    o->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
