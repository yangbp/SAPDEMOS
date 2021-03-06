*&---------------------------------------------------------------------*
*& Report  demo_cfw                                                    *
*&---------------------------------------------------------------------*

REPORT demo_cfw.

*&---------------------------------------------------------------------*
*& Global Declarations                                                 *
*&---------------------------------------------------------------------*

* Class Definitions

CLASS screen_handler DEFINITION CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-DATA screen TYPE REF TO screen_handler.
    CLASS-METHODS create_screen.
    METHODS constructor.
  PRIVATE SECTION.
    DATA: container_html  TYPE REF TO cl_gui_custom_container,
          container_box   TYPE REF TO cl_gui_dialogbox_container,
          picture         TYPE REF TO cl_gui_picture,
          tree            TYPE REF TO cl_gui_simple_tree,
          html_viewer     TYPE REF TO cl_gui_html_viewer,
          list_viewer     TYPE REF TO cl_gui_alv_grid.
    METHODS: fill_tree,
             fill_picture,
             handle_node_double_click
               FOR EVENT node_double_click OF cl_gui_simple_tree
               IMPORTING node_key,
             close_box
               FOR EVENT close OF cl_gui_dialogbox_container,
             fill_html IMPORTING i_carrid TYPE spfli-carrid,
             fill_list IMPORTING i_carrid TYPE spfli-carrid
                                 i_connid TYPE spfli-connid.
ENDCLASS.                    "screen_handler DEFINITION

* Class Implementations

CLASS screen_handler IMPLEMENTATION.

  METHOD create_screen.
    IF screen IS INITIAL.
      CREATE OBJECT screen.
    ENDIF.
  ENDMETHOD.                    "create_screen

  METHOD constructor.
    DATA: l_event_tab        TYPE cntl_simple_events,
          l_event            LIKE LINE OF l_event_tab,
          l_docking          TYPE REF TO cl_gui_docking_container,
          l_splitter         TYPE REF TO cl_gui_splitter_container,
          l_container_screen TYPE REF TO cl_gui_custom_container,
          l_container_top    TYPE REF TO cl_gui_container,
          l_container_bottom TYPE REF TO cl_gui_container.

    CREATE OBJECT container_html
           EXPORTING container_name = 'CUSTOM_CONTROL'.

    CREATE OBJECT l_docking
           EXPORTING side = cl_gui_docking_container=>dock_at_left
                     extension = 135.

    CREATE OBJECT l_splitter
           EXPORTING parent = l_docking
                     rows = 2
                     columns = 1.

    l_splitter->set_border(
         EXPORTING border = cl_gui_cfw=>false ).

    l_splitter->set_row_mode(
         EXPORTING mode = l_splitter->mode_absolute ).

    l_splitter->set_row_height(
         EXPORTING id = 1
                   height = 180 ).

    l_container_top    =
      l_splitter->get_container( row = 1 column = 1 ).
    l_container_bottom =
      l_splitter->get_container( row = 2 column = 1 ).

    CREATE OBJECT picture
           EXPORTING parent = l_container_top.

    CREATE OBJECT tree
           EXPORTING parent = l_container_bottom
                     node_selection_mode =
                       cl_gui_simple_tree=>node_sel_mode_single.

    l_event-eventid = cl_gui_simple_tree=>eventid_node_double_click.
    l_event-appl_event = ' '.   "system event, does not trigger PAI
    APPEND l_event TO l_event_tab.
    tree->set_registered_events(
         EXPORTING events = l_event_tab ).
    SET HANDLER me->handle_node_double_click FOR tree.

    me->fill_picture( ).
    me->fill_tree( ).
  ENDMETHOD.                    "constructor

  METHOD fill_picture.
    TYPES pict_line TYPE x LENGTH 1022.
    DATA l_mime_api   TYPE REF TO if_mr_api.
    DATA l_pict_wa    TYPE xstring.
    DATA l_pict_tab   TYPE TABLE OF pict_line.
    DATA l_url        TYPE c LENGTH 255.

    l_mime_api = cl_mime_repository_api=>get_api( ).

    l_mime_api->get(
      EXPORTING i_url = '/SAP/PUBLIC/BC/ABAP/Sources/PLANE.GIF'
      IMPORTING e_content = l_pict_wa
      EXCEPTIONS OTHERS = 4 ).

    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    l_pict_tab =
      VALUE #( LET l1 = xstrlen( l_pict_wa ) l2 = l1 - 1022 IN
               FOR j = 0 THEN j + 1022  UNTIL j >= l1
                 ( COND #( WHEN j <= l2 THEN
                                l_pict_wa+j(1022)
                           ELSE l_pict_wa+j ) ) ).

    CALL FUNCTION 'DP_CREATE_URL'
      EXPORTING
        type    = 'IMAGE'
        subtype = 'GIF'
      TABLES
        data    = l_pict_tab
      CHANGING
        url     = l_url.

    picture->load_picture_from_url(
         EXPORTING url = l_url ).
    picture->set_display_mode(
         EXPORTING display_mode = picture->display_mode_stretch ).
  ENDMETHOD.                    "fill_picture

  METHOD fill_tree.
    DATA: l_node_table TYPE TABLE OF abdemonode,
          l_node TYPE abdemonode,
          BEGIN OF l_spfli,
            carrid TYPE spfli-carrid,
            connid TYPE spfli-connid,
          END OF l_spfli,
          l_spfli_tab LIKE SORTED TABLE OF l_spfli
                      WITH UNIQUE KEY carrid connid.

    SELECT carrid, connid
      FROM spfli
      INTO CORRESPONDING FIELDS OF TABLE @l_spfli_tab.

    l_node-hidden = ' '.               " All nodes are visible,
    l_node-disabled = ' '.             " selectable,
    l_node-isfolder = 'X'.             " a folder,
    l_node-expander = ' '.             " have no '+' sign for expansion.

    LOOP AT l_spfli_tab INTO l_spfli.
      AT NEW carrid.
        l_node-node_key = l_spfli-carrid.
        CLEAR l_node-relatkey.
        CLEAR l_node-relatship.
        l_node-text = l_spfli-carrid.
        l_node-n_image =   ' '.
        l_node-exp_image = ' '.
        APPEND l_node TO l_node_table.
      ENDAT.
      AT NEW connid.
        l_node-node_key = l_spfli-carrid && l_spfli-connid.
        l_node-relatkey = l_spfli-carrid.
        l_node-relatship = cl_gui_simple_tree=>relat_last_child.
        l_node-text = l_spfli-connid.
        l_node-n_image =   '@AV@'.     "AV is the internal code
        l_node-exp_image = '@AV@'.     "for an airplane icon
      ENDAT.
      APPEND l_node TO l_node_table.
    ENDLOOP.

    tree->add_nodes(
         EXPORTING table_structure_name = 'ABDEMONODE'
                   node_table = l_node_table ).
  ENDMETHOD.                    "fill_tree

  METHOD handle_node_double_click.
    DATA: l_carrid TYPE spfli-carrid,
          l_connid TYPE spfli-connid.

    l_carrid = node_key(2).
    l_connid = node_key+2(4).
    IF l_connid IS INITIAL.
      fill_html( EXPORTING i_carrid = l_carrid ).
    ELSE.
      fill_list( EXPORTING i_carrid = l_carrid
                           i_connid = l_connid ).
    ENDIF.
  ENDMETHOD.                    "handle_node_double_click

  METHOD fill_html.
    DATA l_url TYPE scarr-url.

    IF html_viewer IS INITIAL.
      CREATE OBJECT html_viewer
             EXPORTING parent = container_html.
    ENDIF.

    SELECT SINGLE url
           FROM   scarr
           WHERE  carrid = @i_carrid
           INTO   @l_url.

    html_viewer->show_url(
         EXPORTING url = l_url ).
  ENDMETHOD.                    "fill_html

  METHOD fill_list.
    DATA: l_flight_tab TYPE TABLE OF demofli,
          BEGIN OF l_flight_title,
            carrname TYPE scarr-carrname,
            cityfrom TYPE spfli-cityfrom,
            cityto   TYPE spfli-cityto,
          END OF l_flight_title,
          l_list_layout TYPE lvc_s_layo.

    IF container_box IS INITIAL.
      CREATE OBJECT container_box
             EXPORTING width  = 250
                       height = 200
                       top    = 100
                       left   = 400
                       caption = 'Flight List'.
      SET HANDLER close_box FOR container_box.
      CREATE OBJECT list_viewer
             EXPORTING i_parent = container_box.
    ENDIF.

    SELECT SINGLE c~carrname, p~cityfrom, p~cityto
           FROM   ( scarr AS c
                      INNER JOIN spfli AS p ON c~carrid = p~carrid )
           WHERE  p~carrid = @i_carrid AND
                  p~connid = @i_connid
           INTO   CORRESPONDING FIELDS OF @l_flight_title.

    SELECT   fldate, seatsmax, seatsocc
             FROM     sflight
             WHERE    carrid = @i_carrid AND connid = @i_connid
             ORDER BY fldate
             INTO     CORRESPONDING FIELDS OF TABLE @l_flight_tab.

    l_list_layout-grid_title = l_flight_title-carrname && ` ` &&
                               i_connid                && ` ` &&
                               l_flight_title-cityfrom && ` ` &&
                               l_flight_title-cityto.

    l_list_layout-smalltitle = 'X'.    "The list title has small fonts,
    l_list_layout-cwidth_opt = 'X'.    "the column width is adjusted,
    l_list_layout-no_toolbar = 'X'.    "the toolbar is suppressed.

    list_viewer->set_table_for_first_display(
         EXPORTING i_structure_name = 'DEMOFLI'
                   is_layout        = l_list_layout
         CHANGING  it_outtab        = l_flight_tab ).
  ENDMETHOD.                    "fill_list

  METHOD close_box.
    list_viewer->free( ).
    container_box->free( ).
    CLEAR: list_viewer,
           container_box.
  ENDMETHOD.                    "close_box

ENDCLASS.                    "screen_handler IMPLEMENTATION

*&---------------------------------------------------------------------*
*& Processing Blocks called by the Runtime Environment                 *
*&---------------------------------------------------------------------*

* Event Block START-OF-SELECTION

START-OF-SELECTION.
  CALL SCREEN 100.

* Dialog Module PBO

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
  SET TITLEBAR 'TIT_100'.
  screen_handler=>create_screen( ).
ENDMODULE.                    "status_0100 OUTPUT

* Dialog Module PAI

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.                    "cancel INPUT
