REPORT.


CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA input TYPE c LENGTH 3 VALUE 'XL'.
    cl_demo_input=>request( CHANGING field = input ).
    input = to_upper( input ).

    TYPES:
      BEGIN OF ENUM size,
        s, m, l, xl, xxl,
      END OF ENUM size.

    DATA(xml) =
      cl_abap_codepage=>convert_to(
        `<asx:abap version="1.0"` &&
        ` xmlns:asx="http://www.sap.com/abapxml">` &&
        `  <asx:values>` &&
        `  <ENUM>` && input && `</ENUM>` &&
        `  </asx:values>` &&
        `</asx:abap>` ) ##no_text.

    DATA size TYPE size.
    TRY.
        CALL TRANSFORMATION id
                            SOURCE XML xml
                            RESULT enum = size.
      CATCH cx_transformation_error INTO DATA(exc).
        cl_demo_output=>display( exc->previous->get_text( ) ).
        RETURN.
    ENDTRY.

    cl_demo_output=>display( |Name:  { size
                           }\nValue: { CONV i( size ) }| ).

    FIELD-SYMBOLS <fs> TYPE size.
    ASSIGN (input) TO <fs>.
    IF sy-subrc <> 0.
      cl_demo_output=>display( `Wrong name` ).
      RETURN.
    ENDIF.
    ASSERT size = <fs>.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
