 REPORT demo_cds_fltp_to_dec.

 CLASS demo DEFINITION.
   PUBLIC SECTION.
     CLASS-METHODS: main,
       class_constructor.
 ENDCLASS.

 CLASS demo IMPLEMENTATION.
   METHOD main.
     SELECT SINGLE dec1_10_0, dec1_10_3, dec2_10_0, dec2_10_3
            FROM demo_cds_fltp_to_dec
            INTO @DATA(result).
       cl_demo_output=>display( result ).
     ENDMETHOD.
     METHOD class_constructor.
       DELETE FROM demo_expressions.
       INSERT demo_expressions FROM @( VALUE #(
         id      = 'X'
         fltp1   = '1E6' / 3
         fltp2   = '2E6' / 3 ) ).
     ENDMETHOD.
 ENDCLASS.

 START-OF-SELECTION.
   demo=>main( ).
