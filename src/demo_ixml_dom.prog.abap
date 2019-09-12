REPORT demo_ixml_dom.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( `XML-Data` ).
    DATA(xml) =
     `<?xml version="1.0"?>` &&
     `<order number="4711"` &&
     ` xmlns:demo="http://www.sap.com/abapdemos">` &&
     `<!-- Head and body of order -->` &&
     ` <demo:head>` &&
     ` <demo:status>confirmed</demo:status>` &&
     ` <demo:date format="mm-dd-yyyy">07-19-2012</demo:date>` &&
     ` </demo:head>` &&
     ` <demo:body>`  &&
     ` <demo:item units="2" price="17.00">Part No. 0110</demo:item>` &&
     ` <demo:item units="1" price="10.50">Part No. 1609</demo:item>` &&
     ` <demo:item units="5" price="12.30">Part No. 1710</demo:item>` &&
     ` </demo:body>` &&
     `</order>`.
    out->write_xml( xml ).

    out->next_section( `XML-Document in DOM-Format` ).
    TYPES: BEGIN OF t_node,
            gid     TYPE i,
            type    TYPE i,
            prefix  TYPE string,
            name    TYPE string,
            value   TYPE string,
          END OF t_node.
    DATA node_tab TYPE STANDARD TABLE OF t_node.
    DATA(ixml)          = cl_ixml=>create( ).
    DATA(document)      = ixml->create_document( ).
    TRY.
        CALL TRANSFORMATION id SOURCE XML xml
                               RESULT XML document.
      CATCH cx_transformation_error.
        RETURN.
    ENDTRY.
    DATA(iterator) = document->create_iterator( ).
    DO.
      DATA(node) = iterator->get_next( ).
      IF node IS INITIAL.
        EXIT.
      ENDIF.
      APPEND VALUE #(
        gid     = node->get_gid( )
        type    = node->get_type( )
        prefix  = node->get_namespace_prefix( )
        name    = node->get_name( )
        value   = node->get_value( ) ) TO node_tab.
    ENDDO.
    out->write_data( node_tab ).

    TYPES: BEGIN OF t_attribute,
             name  TYPE string,
             value TYPE string,
           END OF t_attribute.
    DATA attribute_tab TYPE STANDARD TABLE OF t_attribute.
    iterator->reset( ).
    DO.
      node = iterator->get_next( ).
      IF node IS INITIAL.
        EXIT.
      ENDIF.
      DATA(attributes) = node->get_attributes( ).
      IF attributes IS INITIAL OR attributes->get_length( ) = 0.
        CONTINUE.
      ENDIF.
      CLEAR attribute_tab.
      DO.
        DATA(attribute) = attributes->get_item( sy-index - 1 ).
        IF attribute IS INITIAL.
          EXIT.
        ENDIF.
        APPEND VALUE #(
          name  = attribute->get_name( )
          value = attribute->get_value( ) ) TO attribute_tab.
      ENDDO.
      out->begin_section( |Attributes of GID { node->get_gid( ) }|
        )->write_data( attribute_tab
        )->end_section( ).
    ENDDO.

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
