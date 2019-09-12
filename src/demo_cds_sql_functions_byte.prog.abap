 REPORT demo_cds_sql_functions_byte.

 CLASS demo DEFINITION.
   PUBLIC SECTION.
     CLASS-METHODS: main,
       class_constructor.
 ENDCLASS.

 CLASS demo IMPLEMENTATION.
   METHOD main.
     SELECT SINGLE *
            FROM demo_cds_sql_functions_byte
            INTO @DATA(result).
       cl_demo_output=>display( result ).
     ENDMETHOD.
     METHOD class_constructor.
       DELETE FROM demo_expressions.
       INSERT demo_expressions FROM @( VALUE #(
         id      = 'X'
         char1   = 'ABCDE'
         raw1    = '0123456789ABCDEF' ) ).
     ENDMETHOD.
 ENDCLASS.

 START-OF-SELECTION.
   demo=>main( ).
