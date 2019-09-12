 REPORT demo_cds_sql_functions_string.

 CLASS demo DEFINITION.
   PUBLIC SECTION.
     CLASS-METHODS: main,
       class_constructor.
 ENDCLASS.

 CLASS demo IMPLEMENTATION.
   METHOD main.
     SELECT SINGLE *
            FROM demo_cds_sql_functions_string
            INTO @DATA(result).
       cl_demo_output=>display( result ).
     ENDMETHOD.
     METHOD class_constructor.
       DELETE FROM demo_expressions.
       INSERT demo_expressions FROM @( VALUE #(
         id      = 'X'
         char1   = 'ABCDE'
         char2   = 'fghij'
         string1 = 'KLMNO'
         string2 = 'PQRSZ' ) ).
     ENDMETHOD.
 ENDCLASS.

 START-OF-SELECTION.
   demo=>main( ).
