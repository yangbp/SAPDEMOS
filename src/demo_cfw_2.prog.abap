PROGRAM demo_cfw_2.

* Classes

CLASS screen_init DEFINITION CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-METHODS init_screen.
    METHODS constructor.
  PRIVATE SECTION.
    DATA: splitter_h TYPE REF TO cl_gui_splitter_container,
          splitter_v TYPE REF TO cl_gui_splitter_container,
          picture TYPE REF TO cl_gui_picture,
          tree TYPE REF TO cl_gui_simple_tree.
    METHODS: fill_tree,
             fill_picture.
ENDCLASS.

*

CLASS screen_handler DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING container
               TYPE REF TO cl_gui_container,
             handle_node_double_click
               FOR EVENT node_double_click
               OF cl_gui_simple_tree
               IMPORTING node_key.
  PRIVATE SECTION.
    DATA: html_viewer TYPE REF TO cl_gui_html_viewer,
          list_viewer TYPE REF TO cl_gui_alv_grid.
    METHODS: fill_html IMPORTING carrid TYPE spfli-carrid,
             fill_list IMPORTING carrid TYPE spfli-carrid
                                 connid TYPE spfli-connid.
ENDCLASS.

*

CLASS screen_init IMPLEMENTATION.

  METHOD init_screen.
    DATA screen TYPE REF TO screen_init.
    CREATE OBJECT screen.
  ENDMETHOD.

  METHOD constructor.
    DATA: events TYPE cntl_simple_events,
          event LIKE LINE OF events,
          event_handler TYPE REF TO screen_handler,
          container_left TYPE REF TO cl_gui_container,
          container_right TYPE REF TO cl_gui_container,
          container_top TYPE REF TO cl_gui_container,
          container_bottom TYPE REF TO cl_gui_container.

    CREATE OBJECT splitter_h
           EXPORTING
           parent = cl_gui_container=>screen0
           rows = 1
           columns = 2.

    CALL METHOD splitter_h->set_border
      EXPORTING
        border = cl_gui_cfw=>false.

    CALL METHOD splitter_h->set_column_mode
      EXPORTING
        mode = splitter_h->mode_absolute.

    CALL METHOD splitter_h->set_column_width
      EXPORTING
        id    = 1
        width = 107.

    container_left  = splitter_h->get_container( row = 1 column = 1 ).
    container_right = splitter_h->get_container( row = 1 column = 2 ).

    CREATE OBJECT splitter_v
           EXPORTING
           parent = container_left
           rows = 2
           columns = 1.

    CALL METHOD splitter_v->set_border
      EXPORTING
        border = cl_gui_cfw=>false.

    CALL METHOD splitter_v->set_row_mode
      EXPORTING
        mode = splitter_v->mode_absolute.

    CALL METHOD splitter_v->set_row_height
      EXPORTING
        id     = 1
        height = 160.

    container_top    = splitter_v->get_container( row = 1 column = 1 ).
    container_bottom = splitter_v->get_container( row = 2 column = 1 ).

    CREATE OBJECT picture
           EXPORTING parent = container_top.

    CREATE OBJECT tree
           EXPORTING parent = container_bottom
                     node_selection_mode =
                            cl_gui_simple_tree=>node_sel_mode_single.
    CREATE OBJECT  event_handler
           EXPORTING container = container_right.

    event-eventid = cl_gui_simple_tree=>eventid_node_double_click.
    event-appl_event = ' '.   "system event, does not trigger PAI
    APPEND event TO events.
    CALL METHOD tree->set_registered_events
      EXPORTING
        events = events.
    SET HANDLER event_handler->handle_node_double_click FOR tree.

    CALL METHOD: me->fill_picture,
                 me->fill_tree.
  ENDMETHOD.

  METHOD fill_picture.
    TYPES pict_line TYPE x LENGTH 1022.
    DATA mime_api   TYPE REF TO if_mr_api.
    DATA pict_wa    TYPE xstring.
    DATA pict_tab   TYPE TABLE OF pict_line.
    DATA length     TYPE i.
    DATA url        TYPE c LENGTH 255.

    mime_api = cl_mime_repository_api=>get_api( ).

    mime_api->get(
      EXPORTING i_url = '/SAP/PUBLIC/BC/ABAP/Sources/PLANE.GIF'
      IMPORTING e_content = pict_wa
      EXCEPTIONS OTHERS = 4 ).

    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    length = XSTRLEN( pict_wa ).
    WHILE length >= 1022.
      APPEND pict_wa(1022) TO pict_tab.
      SHIFT pict_wa BY 1022 PLACES LEFT IN BYTE MODE.
      length = XSTRLEN( pict_wa ).
    ENDWHILE.
    IF length > 0.
      APPEND pict_wa TO pict_tab.
    ENDIF.

    CALL FUNCTION 'DP_CREATE_URL'
      EXPORTING
        type    = 'IMAGE'
        subtype = 'GIF'
      TABLES
        data    = pict_tab
      CHANGING
        url     = url.

    CALL METHOD picture->load_picture_from_url
      EXPORTING
        url = url.
    CALL METHOD picture->set_display_mode
      EXPORTING
        display_mode = picture->display_mode_fit_center.
  ENDMETHOD.

  METHOD fill_tree.
    DATA: node_table TYPE TABLE OF abdemonode,
          node TYPE abdemonode,
          BEGIN OF spfli_wa,
            carrid TYPE spfli-carrid,
            connid TYPE spfli-connid,
          END OF spfli_wa,
          spfli_tab LIKE SORTED TABLE OF spfli_wa
                    WITH UNIQUE KEY carrid connid.

    SELECT carrid, connid
      FROM spfli
      INTO CORRESPONDING FIELDS OF TABLE @spfli_tab.

    node-hidden = ' '.               " All nodes are visible,
    node-disabled = ' '.             " selectable,
    node-isfolder = 'X'.             " a folder,
    node-expander = ' '.             " have no '+' sign for expansion.
    LOOP AT spfli_tab INTO spfli_wa.
      AT NEW carrid.
        node-node_key = spfli_wa-carrid.
        CLEAR node-relatkey.
        CLEAR node-relatship.
        node-text = spfli_wa-carrid.
        node-n_image =   ' '.
        node-exp_image = ' '.
        APPEND node TO node_table.
      ENDAT.
      AT NEW connid.
        node-node_key = spfli_wa-carrid && spfli_wa-connid.
        node-relatkey = spfli_wa-carrid.
        node-relatship = cl_gui_simple_tree=>relat_last_child.
        node-text = spfli_wa-connid.
        node-n_image =   '@AV@'.       "AV is the internal code
        node-exp_image = '@AV@'.       "for an airplane icon
      ENDAT.
      APPEND node TO node_table.
    ENDLOOP.

    CALL METHOD tree->add_nodes
      EXPORTING
        table_structure_name = 'ABDEMONODE'
        node_table           = node_table.
  ENDMETHOD.

ENDCLASS.

*

CLASS screen_handler IMPLEMENTATION.

  METHOD constructor.
    CREATE OBJECT: html_viewer EXPORTING parent = container,
                   list_viewer EXPORTING i_parent = container.
  ENDMETHOD.

  METHOD handle_node_double_click.
    DATA: carrid TYPE spfli-carrid,
          connid TYPE spfli-connid.

    carrid = node_key(2).
    connid = node_key+2(4).
    IF connid IS INITIAL.
      CALL METHOD: fill_html EXPORTING carrid = carrid,
                   html_viewer->set_visible EXPORTING visible = 'X',
                   list_viewer->set_visible EXPORTING visible = ' '.
    ELSE.
      CALL METHOD: fill_list EXPORTING carrid = carrid
                                       connid = connid,
                   list_viewer->set_visible EXPORTING visible = 'X',
                   html_viewer->set_visible EXPORTING visible = ' '.
    ENDIF.

    CALL METHOD cl_gui_cfw=>flush.
  ENDMETHOD.

  METHOD fill_html.
    DATA url TYPE scarr-url.

    SELECT SINGLE url
    FROM   scarr
    WHERE  carrid = @carrid
    INTO   @url.

    CALL METHOD html_viewer->show_url
      EXPORTING
        url = url.
  ENDMETHOD.

  METHOD fill_list.
    DATA: flight_tab TYPE TABLE OF demofli,
          BEGIN OF flight_title,
            carrname TYPE scarr-carrname,
            cityfrom TYPE spfli-cityfrom,
            cityto   TYPE spfli-cityto,
          END OF flight_title,
          list_layout TYPE lvc_s_layo.

    SELECT   SINGLE c~carrname, p~cityfrom, p~cityto
    FROM     ( scarr AS c
               INNER JOIN spfli   AS p ON c~carrid = p~carrid )
    WHERE    p~carrid = @carrid AND
             p~connid = @connid
    INTO     CORRESPONDING FIELDS OF @flight_title.

    SELECT   fldate, seatsmax, seatsocc
    FROM     sflight
    WHERE    carrid = @carrid AND connid = @connid
    ORDER BY fldate
    INTO     CORRESPONDING FIELDS OF TABLE @flight_tab.

    list_layout-grid_title = flight_title-carrname && ` ` &&
                             connid                && ` ` &&
                             flight_title-cityfrom && ` ` &&
                             flight_title-cityto.

    list_layout-smalltitle = 'X'.      "The list title has small fonts,
    list_layout-cwidth_opt = 'X'.      "the column width is adjusted,
    list_layout-no_toolbar = 'X'.      "the toolbar is suppressed.

    CALL METHOD list_viewer->set_table_for_first_display
      EXPORTING
        i_structure_name = 'DEMOFLI'
        is_layout        = list_layout
      CHANGING
        it_outtab        = flight_tab.
  ENDMETHOD.

ENDCLASS.

*

CLASS demo_screen DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

*

CLASS demo_screen IMPLEMENTATION.
  METHOD main.
    CALL SCREEN 100.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo_screen=>main( ).

* Dialog Modules PBO

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
  SET TITLEBAR 'TIT_100'.
  CALL METHOD screen_init=>init_screen.
ENDMODULE.

* Dialog Modules PAI

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.
