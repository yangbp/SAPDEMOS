REPORT demo_apc_ping_pong.

PARAMETERS:
  field   RADIOBUTTON GROUP r,
  player1 RADIOBUTTON GROUP r,
  player2 RADIOBUTTON GROUP r.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    CLASS-DATA:
      browser TYPE string,
      address TYPE string.
    CONSTANTS
      path TYPE string VALUE `/sap/bc/apc_test/ping_pong`.
    CLASS-METHODS:
      call_browser IMPORTING url TYPE csequence.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    CASE 'X'.
      WHEN field.
        call_browser( address && path && `/game`  ).
      WHEN player1.
        call_browser( address && path && `/player` ).
      WHEN player2.
        SUBMIT ('RS_APC_PING_PONG') VIA SELECTION-SCREEN AND RETURN.
    ENDCASE.
  ENDMETHOD.
  METHOD call_browser.
    IF browser IS NOT INITIAL.
      cl_gui_frontend_services=>execute(
                EXPORTING
                   application = browser
                   parameter = `-new-window ` &&  url
                EXCEPTIONS
                  OTHERS   = 4 ).
    ELSE.
      cl_gui_frontend_services=>execute(
               EXPORTING
                 document  = url
                 operation = ' ' ).
    ENDIF.
  ENDMETHOD.
  METHOD class_constructor.
    "Try to get a browser that supports WebSocket
    cl_gui_frontend_services=>registry_get_value(
       EXPORTING
         root                 = cl_gui_frontend_services=>hkey_local_machine
         key                  = 'Software\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome'
         value                = 'InstallLocation'
       IMPORTING
         reg_value            = DATA(chrome)
       EXCEPTIONS
          OTHERS               = 4 ) ##no_text.

    cl_gui_frontend_services=>registry_get_value(
        EXPORTING
          root                 = cl_gui_frontend_services=>hkey_local_machine
          key                  = 'SOFTWARE\Mozilla\Mozilla Firefox' ##no_text
          value                = 'CURRENTVERSION'
        IMPORTING
          reg_value            = DATA(firefox)
        EXCEPTIONS
           OTHERS               = 4 ) ##no_text.
    cl_gui_frontend_services=>registry_get_value(
        EXPORTING
          root                 = cl_gui_frontend_services=>hkey_local_machine
          key                  = 'SOFTWARE\Mozilla\Mozilla Firefox\' && firefox && '\Main'
          value                = 'PathToExe'
        IMPORTING
          reg_value            = firefox
        EXCEPTIONS
           OTHERS               = 4 ) ##no_text.

    browser = COND string( WHEN chrome IS NOT INITIAL THEN chrome && '\chrome.exe'
                           WHEN firefox IS NOT INITIAL THEN firefox
                           ELSE `` ).
    "Get address
    address =
      cl_http_server=>get_location( application = path ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
