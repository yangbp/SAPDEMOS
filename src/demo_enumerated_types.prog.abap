REPORT demo_enumerated_types.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA html TYPE string.
    CLASS-METHODS:
      class_constructor,
      main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: size   TYPE  cl_demo_wrap_browser=>size
                 VALUE cl_demo_wrap_browser=>sz-l,
          format TYPE  cl_demo_wrap_browser=>format
                 VALUE cl_demo_wrap_browser=>fmt-l.

    cl_demo_input=>add_field( EXPORTING text = `Size (S, M, L, XL)`
                              CHANGING  field = size ).
    cl_demo_input=>request(   EXPORTING text  = `Format (L, P)`
                              CHANGING  field = format ).

    cl_demo_wrap_browser=>show( html   = html
                                size   = size
                                format = format ).
  ENDMETHOD.
  METHOD class_constructor.
    cl_abap_docu_external=>get_abap_docu_for_adt(
       EXPORTING
        language = COND #( WHEN sy-langu = 'D' THEN 'DE' ELSE 'EN' )
      IMPORTING
        html     = html  ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
