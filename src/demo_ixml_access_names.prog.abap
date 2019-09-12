REPORT demo_ixml_access_names.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
  METHOD main.

    DATA source_tab TYPE TABLE OF i.
    source_tab = VALUE #( FOR j = 1 UNTIL j > 10
                        ( ipow( base = 2 exp = j ) ) ).
    DATA(ixml) = cl_ixml=>create( ).
    DATA(document) = ixml->create_document( ).
    CALL TRANSFORMATION id SOURCE text = `Powers of 2`
                                  numbers = source_tab
                           RESULT XML document.

    DATA(element)  = document->find_from_name_ns( name = 'TEXT' ).
    IF element IS NOT INITIAL.
      cl_demo_output=>write_data( element->get_value( ) ).
    ENDIF.

    DATA(elements) =
      document->get_elements_by_tag_name( name = 'item' ).
    DATA target_tab LIKE source_tab.
    DO elements->get_length( ) TIMES.
      DATA(node) = elements->get_item( sy-index - 1 ).
      APPEND node->get_value( ) TO target_tab.
    ENDDO.

    cl_demo_output=>display( target_tab ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
