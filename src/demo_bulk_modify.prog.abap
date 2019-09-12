REPORT demo_bulk_modify.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_bulk_modify. "has an unique secondary index k1, v1
    INSERT demo_bulk_modify FROM @( VALUE #( k1 = 1 k2 = 1 v1 = 1 ) ).

    DATA itab TYPE STANDARD TABLE OF demo_bulk_modify WITH EMPTY KEY.
    itab = VALUE #( ( k1 = 1 k2 = 2 v1 = 1 )
                    ( k1 = 1 k2 = 1 v1 = 2 ) ).

    MODIFY demo_bulk_modify FROM TABLE itab. "platform dependent!

    SELECT *
           FROM demo_bulk_modify
           INTO TABLE @DATA(result).
    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
