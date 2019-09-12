REPORT demo_ixml_name_list_iterator.

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

    DATA(elements) =
      document->get_elements_by_tag_name( name = 'item' ).
    DATA(iterator) = elements->create_iterator( ).

    DATA target_tab LIKE source_tab.
    DO.
      DATA(node) = iterator->get_next( ).
      IF node IS INITIAL.
        EXIT.
      ENDIF.
      APPEND node->get_value( ) TO target_tab.
    ENDDO.

    cl_demo_output=>display( target_tab ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
