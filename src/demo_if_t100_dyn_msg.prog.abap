REPORT demo_if_t100_dyn_msg.

CLASS msg DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_t100_dyn_msg.
    ALIASES: msgty FOR if_t100_dyn_msg~msgty,
             get_text FOR if_message~get_text,
             get_longtext FOR if_message~get_longtext.
    METHODS constructor IMPORTING id TYPE symsgid
                                  no TYPE symsgno
                                  ty TYPE symsgty
                                  v1 TYPE string OPTIONAL
                                  v2 TYPE string OPTIONAL
                                  v3 TYPE string OPTIONAL
                                  v4 TYPE string OPTIONAL.
ENDCLASS.

CLASS msg IMPLEMENTATION.
  METHOD constructor.
    if_t100_message~t100key-msgid = id.
    if_t100_message~t100key-msgno = no.
    if_t100_dyn_msg~msgty = ty.
    if_t100_message~t100key-attr1 = 'IF_T100_DYN_MSG~MSGV1'.
    if_t100_message~t100key-attr2 = 'IF_T100_DYN_MSG~MSGV2'.
    if_t100_message~t100key-attr3 = 'IF_T100_DYN_MSG~MSGV3'.
    if_t100_message~t100key-attr4 = 'IF_T100_DYN_MSG~MSGV4'.
    if_t100_dyn_msg~msgv1 = v1.
    if_t100_dyn_msg~msgv2 = v2.
    if_t100_dyn_msg~msgv3 = v3.
    if_t100_dyn_msg~msgv4 = v4.
  ENDMETHOD.
  METHOD if_message~get_text.
    result = cl_message_helper=>get_text_for_message( me ).
  ENDMETHOD.
  METHOD if_message~get_longtext.
    result = cl_message_helper=>get_longtext_for_message( me ).
  ENDMETHOD.
ENDCLASS.

CLASS msg_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS msg_demo IMPLEMENTATION.
  METHOD main.
    DATA(id) = `SABAPDEMOS`.
    DATA(no) = `888`.
    DATA(ty) = `I`.
    DATA(v1) = `Hello,`.
    DATA(v2) = `I am`.
    DATA(v3) = `a`.
    DATA(v4) = `Message!`.
    cl_demo_input=>new(
      )->add_field( CHANGING field = id
      )->add_field( CHANGING field = no
      )->add_field( CHANGING field = ty
      )->add_field( CHANGING field = v1
      )->add_field( CHANGING field = v2
      )->add_field( CHANGING field = v3
      )->add_field( CHANGING field = v4
      )->request( ).
    IF strlen( ty ) > 1 OR 'AEISX' NS ty.
      cl_demo_output=>display(
        |Invalid message type: { ty }|  ).
      RETURN.
    ENDIF.

    DATA(mref) = NEW msg( id = CONV #( id )
                          no = CONV #( no )
                          ty = CONV #( ty )
                          v1 = v1
                          v2 = v2
                          v3 = v3
                          v4 = v4 ).

    cl_demo_output=>display(
      |{ mref->get_text( ) }, Type: { mref->msgty }| ).

    MESSAGE mref TYPE 'I' DISPLAY LIKE mref->msgty.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  msg_demo=>main( ).
