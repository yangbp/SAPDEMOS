REPORT demo_update.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    CONSTANTS id TYPE demo_update-id VALUE 'X'.

    DELETE FROM demo_update WHERE id = @id.
    INSERT demo_update FROM @( VALUE demo_update( id = id
                                  col1 = 100
                                  col2 = 100
                                  col3 = 100
                                  col4 = 100 ) ).

    DATA(num)   = 200.
    DATA(diff)  = 10.
    DATA(token) = `col4 = col4 - demo_update~col1`.
    UPDATE demo_update
           SET col1 = @num,
               col2 = col2 + @diff,
               col3 = col3 - @diff,
              (token)
           WHERE ID = @id.

    SELECT SINGLE *
           FROM demo_update
           INTO @DATA(wa).
    cl_demo_output=>display( wa ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
