REPORT demo_find_and_match.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: text TYPE c LENGTH 120
               VALUE `Cathy's cat with the hat sat on Matt's mat.`,
          regx TYPE c LENGTH 120
               VALUE `\<.at\>`.
    DATA: result TYPE i,
          substr TYPE string.
    data out TYPE c LENGTH 120.
    cl_demo_input=>add_field( CHANGING field = text ).
    cl_demo_input=>request(   CHANGING field = regx ).
    cl_demo_output=>write( text ).
    result = count( val   = text
                    regex = regx ).
    DO result TIMES.
      result = find( val   = text
                     regex = regx
                     occ   = sy-index ).
      substr = match( val   = text
                      regex = regx
                      occ   = sy-index ).
      data(len) = strlen( substr ).
      out+result(len) = substr.
    ENDDO.
    cl_demo_output=>display( out ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
