REPORT demo_st_table.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: BEGIN OF carrier_wa,
            carrid   TYPE scarr-carrid,
            carrname TYPE scarr-carrname,
            url      TYPE scarr-url,
          END OF carrier_wa,
          carrier_tab LIKE TABLE OF carrier_wa,
          xml  type xstring,
          html type string.

    SELECT *
           FROM scarr
           INTO CORRESPONDING FIELDS OF TABLE @carrier_tab.

    CALL TRANSFORMATION demo_st_table
                        SOURCE carriers = carrier_tab
                        RESULT XML xml.
    cl_demo_output=>write_xml( xml ).

    CALL TRANSFORMATION demo_st_table
                        SOURCE carriers = carrier_tab
                        RESULT XML html
                        OPTIONS xml_header = 'NO'.
    cl_demo_output=>write_html( html ).

    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
