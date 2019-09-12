REPORT demo_conv_enum.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      BEGIN OF ENUM planet,
        mercury,
        venus,
        earth,
        mars,
        jupiter,
        saturn,
        uranus,
        neptune,
      END OF ENUM planet.

    DATA number TYPE i.
    cl_demo_input=>request( CHANGING field = number ).

    TRY.
        DATA(planet) = CONV planet( CONV i( earth ) + number ).
        cl_demo_output=>display( planet ).
      CATCH cx_sy_conversion_no_enum_value.
        cl_demo_output=>display( 'Enter a number between -2 and 5' ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
