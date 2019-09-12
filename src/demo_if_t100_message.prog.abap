REPORT demo_if_t100_message.

CLASS msg DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_t100_message.
    ALIASES: get_text FOR if_message~get_text,
             get_longtext FOR if_message~get_longtext.
    METHODS constructor IMPORTING id TYPE symsgid
                                  no TYPE symsgno
                                  v1 TYPE string OPTIONAL
                                  v2 TYPE string OPTIONAL
                                  v3 TYPE string OPTIONAL
                                  v4 TYPE string OPTIONAL.
    DATA: attr1 TYPE c LENGTH 50,
          attr2 TYPE c LENGTH 50,
          attr3 TYPE c LENGTH 50,
          attr4 TYPE c LENGTH 50.
ENDCLASS.

CLASS msg IMPLEMENTATION.
  METHOD constructor.
    if_t100_message~t100key-msgid = id.
    if_t100_message~t100key-msgno = no.
    if_t100_message~t100key-attr1 = 'ATTR1'.
    if_t100_message~t100key-attr2 = 'ATTR2'.
    if_t100_message~t100key-attr3 = 'ATTR3'.
    if_t100_message~t100key-attr4 = 'ATTR4'.
    attr1 = v1.
    attr2 = v2.
    attr3 = v3.
    attr4 = v4.
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
    DATA(v1) = `Hello,`.
    DATA(v2) = `I am`.
    DATA(v3) = `a`.
    DATA(v4) = `Message!`.
    cl_demo_input=>new(
      )->add_field( CHANGING field = id
      )->add_field( CHANGING field = no
      )->add_field( CHANGING field = v1
      )->add_field( CHANGING field = v2
      )->add_field( CHANGING field = v3
      )->add_field( CHANGING field = v4
      )->request( ).

    DATA(mref) = NEW msg( id = CONV #( id )
                          no = CONV #( no )
                          v1 = v1
                          v2 = v2
                          v3 = v3
                          v4 = v4 ).

    cl_demo_output=>display( mref->get_text( ) ).

    MESSAGE mref TYPE 'I'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  msg_demo=>main( ).
