PROGRAM demo_cfw_1.

* Classes *****************************************************

CLASS screen_init DEFINITION CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-METHODS init_screen.
    METHODS constructor.
  PRIVATE SECTION.
    DATA: container1 TYPE REF TO cl_gui_custom_container,
          container2 TYPE REF TO cl_gui_custom_container,
          container3 TYPE REF TO cl_gui_custom_container,
          picture TYPE REF TO cl_gui_picture,
          tree TYPE REF TO cl_gui_simple_tree.
    METHODS: fill_tree,
             fill_picture.
ENDCLASS.                    "SCREEN_INIT DEFINITION

*
CLASS screen_handler DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING container
               TYPE REF TO cl_gui_custom_container,
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
ENDCLASS.                    "SCREEN_HANDLER DEFINITION

*

CLASS screen_init IMPLEMENTATION.

  METHOD init_screen.
    DATA screen TYPE REF TO screen_init.
    CREATE OBJECT screen.
  ENDMETHOD.                    "INIT_SCREEN

  METHOD constructor.
    DATA: events TYPE cntl_simple_events,
          event LIKE LINE OF events,
          event_handler TYPE REF TO screen_handler.

    CREATE OBJECT: container1 EXPORTING container_name = 'CUSTOM_1',
                   picture EXPORTING parent = container1.

    CREATE OBJECT: container2 EXPORTING container_name = 'CUSTOM_2',
                   tree EXPORTING parent = container2
                     node_selection_mode =
                            cl_gui_simple_tree=>node_sel_mode_single.

    CREATE OBJECT: container3 EXPORTING container_name = 'CUSTOM_3',
                   event_handler EXPORTING container = container3.

    event-eventid = cl_gui_simple_tree=>eventid_node_double_click.
    event-appl_event = ' '.   "system event, does not trigger PAI
    APPEND event TO events.
    CALL METHOD tree->set_registered_events
      EXPORTING
        events = events.
    SET HANDLER event_handler->handle_node_double_click FOR tree.

    CALL METHOD: me->fill_picture,
                 me->fill_tree.
  ENDMETHOD.                    "CONSTRUCTOR

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

    length = xstrlen( pict_wa ).
    WHILE length >= 1022.
      APPEND pict_wa(1022) TO pict_tab.
      SHIFT pict_wa BY 1022 PLACES LEFT IN BYTE MODE.
      length = xstrlen( pict_wa ).
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
  ENDMETHOD.                    "FILL_PICTURE

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

    node-hidden = ' '.              " All nodes are visible,
    node-disabled = ' '.            " selectable,
    node-isfolder = 'X'.            " a folder,
    node-expander = ' '.            " have no '+' sign for expansion.
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
  ENDMETHOD.                    "FILL_TREE

ENDCLASS.                    "SCREEN_INIT IMPLEMENTATION

*

CLASS screen_handler IMPLEMENTATION.

  METHOD constructor.
    CREATE OBJECT: html_viewer EXPORTING parent = container,
                   list_viewer EXPORTING i_parent = container.
  ENDMETHOD.                    "CONSTRUCTOR

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
  ENDMETHOD.                    "HANDLE_NODE_DOUBLE_CLICK

  METHOD fill_html.
    DATA url TYPE scarr-url.

    SELECT SINGLE url
    FROM   scarr
    WHERE  carrid = @carrid
    INTO   @url.

    CALL METHOD html_viewer->show_url
      EXPORTING
        url = url.
  ENDMETHOD.                    "FILL_HTML

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
  ENDMETHOD.                    "FILL_LIST

ENDCLASS.                    "SCREEN_HANDLER IMPLEMENTATION


* Program execution ************************************************

START-OF-SELECTION.
  CALL SCREEN 100.

* Dialog Modules PBO

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
  SET TITLEBAR 'TIT_100'.
  CALL METHOD screen_init=>init_screen.
ENDMODULE.                    "STATUS_0100 OUTPUT

* Dialog Modules PAI

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.                    "CANCEL INPUT
