REPORT demo_st_noerror_option.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      call_transformation
        CHANGING writer TYPE REF TO cl_sxml_string_writer.
    CLASS-DATA:
      num      TYPE n LENGTH 8,
      pack     TYPE p LENGTH 8,
      boolean  TYPE xsdboolean,
      date     TYPE xsddate_d,
      time     TYPE xsdtime_t,
      langu    TYPE xsdlanguage,
      currcode TYPE xsdcurrcode,
      unitcode TYPE xsdunitcode.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    FIELD-SYMBOLS <hex> TYPE x.

    num = CONV d( `  1234  ` ).
    pack = -1234.
    ASSIGN pack TO <hex> CASTING.
    REPLACE SECTION OFFSET 7 LENGTH 1 OF <hex> WITH
            CONV xstring( '40' ) IN BYTE MODE.
    boolean = '1'.
    date = 'XXXXXXXX'.
    time = 'XXXXXX'.
    langu = '§'.
    currcode = '§§§§§'.
    unitcode = '§§§§§'.

    TRY.
        CALL TRANSFORMATION demo_st_noerror_option
          SOURCE n           = num
                 p           = pack
                 boolean     = boolean
                 xsddate_d   = date
                 xsdtime_t   = time
                 xsdlanguage = langu
                 xsdcurrcode = currcode
                 xsdunitcode = unitcode
          RESULT XML DATA(xml).
      CATCH cx_transformation_error INTO DATA(exc).
        cl_demo_output=>display( exc->get_text( ) ).
        RETURN.
    ENDTRY.

    cl_demo_output=>display_xml( xml ).
  ENDMETHOD.
  METHOD call_transformation.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
