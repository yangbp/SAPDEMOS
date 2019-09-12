REPORT demo_string_comparison.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA length1 TYPE n LENGTH 1 VALUE '4'.
    cl_demo_input=>add_field( CHANGING field = length1 ).
    DATA length2 TYPE n LENGTH 1 VALUE '6'.
    cl_demo_input=>request( CHANGING field = length2 ).

    DATA(len1) = CONV i( length1 ).
    DATA(len2) = CONV i( length2 ).
    IF len1 = 0 OR len2 = 0.
      cl_demo_output=>display( 'Try again!' ).
      RETURN.
    ENDIF.

    DATA(text1) = REDUCE string( INIT str = ``
                                 FOR i = 0 UNTIL i >= len1
                                 NEXT str = str && `X`  ).
    DATA(text2) = REDUCE string( INIT str = ``
                                 FOR i = 0 UNTIL i >= len2
                                 NEXT str = str && `X`  ).

    cl_demo_output=>display(
      COND #( WHEN text1 < text2 THEN |{ text1 } < { text2 }|
              WHEN text1 > text2 THEN |{ text1 } > { text2 }|
                                 ELSE |{ text1 } = { text2 }| ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
