REPORT demo_picture_control.

* Declarations *****************************************************

CLASS c_reaction DEFINITION.
  PUBLIC SECTION.
    METHODS h1 FOR EVENT picture_click OF cl_gui_picture.
ENDCLASS.                    "c_reaction DEFINITION

*---------------------------------------------------------------------*
*       CLASS c_service DEFINITION
*---------------------------------------------------------------------*
*
*---------------------------------------------------------------------*
CLASS c_service DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS  get_pic_tab IMPORTING mime_url TYPE csequence
                               EXPORTING pic_tab TYPE STANDARD TABLE.
ENDCLASS.                    "c_service DEFINITION


DATA: container1 TYPE REF TO cl_gui_custom_container,
      container2 LIKE container1,
      pict1 TYPE REF TO cl_gui_picture,
      pict2 LIKE pict1,
      react TYPE REF TO c_reaction,
      evt_tab TYPE cntl_simple_events,
      evt_tab_line LIKE LINE OF evt_tab,
      url(256) TYPE c.

TYPES pic_line(1022) TYPE x.
DATA  pic_tab TYPE TABLE OF pic_line.

DATA l_alignment TYPE i.

* Reporting events ***************************************************

START-OF-SELECTION.

  c_service=>get_pic_tab(
    EXPORTING mime_url = '/SAP/BC/fp/graphics/FPsamples/Tatze.bmp'
    IMPORTING pic_tab  = pic_tab ).

  CALL FUNCTION 'DP_CREATE_URL'
    EXPORTING
      type    = 'IMAGE'
      subtype = 'GIF'
    TABLES
      data    = pic_tab
    CHANGING
      url     = url.

  CALL SCREEN 100.

* Dialog Modules Output

MODULE status_0100 OUTPUT.

  CREATE OBJECT: container1 EXPORTING container_name = 'PICTURE1',
                 container2 EXPORTING container_name = 'PICTURE2',
                 pict1 EXPORTING parent = container1,
                 pict2 EXPORTING parent = container2,
                 react.

  l_alignment = cl_gui_control=>align_at_left   +
                cl_gui_control=>align_at_right  +
                cl_gui_control=>align_at_top    +
                cl_gui_control=>align_at_bottom.

  CALL METHOD pict1->set_alignment
    EXPORTING
      alignment = l_alignment.

  CALL METHOD pict1->set_3d_border
    EXPORTING
      border = 1.

  evt_tab_line-eventid = cl_gui_picture=>eventid_picture_click.
  evt_tab_line-appl_event = ' '.       " System Event!
  APPEND evt_tab_line TO evt_tab.

  CALL METHOD pict1->set_registered_events
    EXPORTING
      events = evt_tab.

  SET HANDLER react->h1 FOR pict1.
  CALL METHOD pict1->load_picture_from_url
    EXPORTING
      url    = url
    EXCEPTIONS
      OTHERS = 4.

  SET PF-STATUS 'SCREEN_100'.

ENDMODULE.                    "status_0100 OUTPUT

* Dialog Modules Output

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.                    "cancel INPUT

* CLass Implementations **********************************************

CLASS c_reaction IMPLEMENTATION.
  METHOD h1.

    c_service=>get_pic_tab(
      EXPORTING mime_url = '/SAP/BC/fp/graphics/FPsamples/eumel.bmp'
      IMPORTING pic_tab  = pic_tab ).

    CALL FUNCTION 'DP_CREATE_URL'
      EXPORTING
        type    = 'IMAGE'
        subtype = 'GIF'
      TABLES
        data    = pic_tab
      CHANGING
        url     = url.
    CALL METHOD pict2->load_picture_from_url
      EXPORTING
        url = url.
  ENDMETHOD.                    "h1
ENDCLASS.                    "c_reaction IMPLEMENTATION

*

CLASS c_service IMPLEMENTATION.
  METHOD get_pic_tab.
    DATA pic_wa TYPE xstring.
    DATA length TYPE i.
    DATA mime_api TYPE REF TO if_mr_api.

    mime_api = cl_mime_repository_api=>get_api( ).


    mime_api->get( EXPORTING i_url = mime_url
                   IMPORTING e_content = pic_wa
                   EXCEPTIONS OTHERS = 4 ).

    IF sy-subrc = 4.
      RETURN.
    ENDIF.

    CLEAR pic_tab.

    length = XSTRLEN( pic_wa ).

    WHILE length >= 1022.
      APPEND pic_wa(1022) TO pic_tab.
      SHIFT pic_wa BY 1022 PLACES LEFT IN BYTE MODE.
      length = XSTRLEN( pic_wa ).
    ENDWHILE.

    IF length > 0.
      APPEND pic_wa TO pic_tab.
    ENDIF.

  ENDMETHOD.                    "get_pic_tab
ENDCLASS.                    "c_service IMPLEMENTATION
