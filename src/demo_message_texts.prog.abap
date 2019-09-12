REPORT demo_message_texts.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      msgid TYPE sy-msgid VALUE 'SABAPDEMOS',
      msgno TYPE sy-msgno VALUE '111',
      msgv1 TYPE string   VALUE `xxx`,
      msgv2 TYPE string   VALUE `yyy`,
      msgv3 TYPE string   VALUE `zzz`,
      msgv4 TYPE string.

    cl_demo_input=>new(
      )->add_field( CHANGING field = msgid
      )->add_field( CHANGING field = msgno
      )->add_field( CHANGING field = msgv1
      )->add_field( CHANGING field = msgv2
      )->add_field( CHANGING field = msgv3
      )->add_field( CHANGING field = msgv4
      )->request( ).

    DATA(msg) = NEW cl_demo_message_texts( msgid = to_upper( msgid )
                                           msgno = msgno
                                           msgv1 = msgv1
                                           msgv2 = msgv2
                                           msgv3 = msgv3
                                           msgv4 = msgv4 ).
    cl_demo_output=>new(
      )->next_section( 'Short Text'
      )->write_text( msg->get_text( )
      )->next_section( 'Long Text, raw'
      )->write_text( msg->get_longtext_raw( )
      )->next_section( 'Long Text, formatted'
      )->write_html( msg->get_longtext_html( )
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
