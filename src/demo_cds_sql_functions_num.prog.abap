 REPORT demo_cds_sql_functions_num.

 CLASS demo DEFINITION.
   PUBLIC SECTION.
     CLASS-METHODS: main,
       class_constructor.
 ENDCLASS.

 CLASS demo IMPLEMENTATION.
   METHOD main.
     SELECT SINGLE *
            FROM demo_cds_sql_functions_num
            INTO @DATA(result).
       cl_demo_output=>display( result ).
     ENDMETHOD.
     METHOD class_constructor.
       DELETE FROM demo_expressions.
       INSERT demo_expressions FROM @( VALUE #(
         id      = 'X'
         num1    = -333
         num2    = 222
         dec1    = 333
         dec2    = '444.4444444444'
         dec3    = '555.555'
         fltp1   = '666.666'
         fltp2   = '777.777'
         decf1   = '888.888'
         decf2   = '999.999' ) ).
     ENDMETHOD.
 ENDCLASS.

 START-OF-SELECTION.
   demo=>main( ).
