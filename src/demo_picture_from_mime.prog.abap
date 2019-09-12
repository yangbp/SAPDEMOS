REPORT demo_picture_from_mime.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
    CLASS-METHODS class_constructor.
  PRIVATE SECTION.
    CLASS-DATA icf_node TYPE string.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    IF icf_node IS INITIAL.
      RETURN.
    ENDIF.

    cl_demo_output=>display_html(
      `<html><body><basefont face="arial">`                &&
      `Picture from MIME Repository<br><br>`               &&
       `<img src="` && icf_node
                    && `/ABAP_Docu_Logo.gif?sap-client=`
                    && sy-mandt
                    && `">`                                &&
       `</body></html>`  ).

  ENDMETHOD.
  METHOD class_constructor.
    CONSTANTS path TYPE string VALUE `/sap/public/bc/abap/mime_demo`.
    DATA(location) =
      cl_http_server=>get_location( application = path ).
    IF location IS NOT INITIAL.
      icf_node = location && path.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
