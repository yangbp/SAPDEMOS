class CL_DEMO_MESSAGE_TEXTS definition
  public
  final
  create public .

public section.

  interfaces IF_MESSAGE .
  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  aliases T100_KEY
    for IF_T100_MESSAGE~T100KEY .
  aliases GET_LONGTEXT_RAW
    for IF_MESSAGE~GET_LONGTEXT .
  aliases GET_TEXT
    for IF_MESSAGE~GET_TEXT .

  methods CONSTRUCTOR
    importing
      !MSGID type SYMSGID
      !MSGNO type SYMSGNO
      !MSGV1 type STRING optional
      !MSGV2 type STRING optional
      !MSGV3 type STRING optional
      !MSGV4 type STRING optional .
  methods GET_LONGTEXT_HTML
    returning
      value(RESULT) type STRING .
ENDCLASS.



CLASS CL_DEMO_MESSAGE_TEXTS IMPLEMENTATION.


  METHOD constructor.
    SELECT SINGLE @abap_true
           FROM t100
           WHERE sprsl = @sy-langu AND
                 arbgb = @msgid AND
                 msgnr = @msgno
           INTO @DATA(result).
    IF sy-subrc <> 0.
      me->t100_key-msgid = 'SABAPDEMOS'.
      me->t100_key-msgno  = '000'.
    ELSE.
      me->t100_key-msgid = msgid.
      me->t100_key-msgno = msgno.
      me->if_t100_message~t100key-attr1 = 'IF_T100_DYN_MSG~MSGV1'.
      me->if_t100_message~t100key-attr2 = 'IF_T100_DYN_MSG~MSGV2'.
      me->if_t100_message~t100key-attr3 = 'IF_T100_DYN_MSG~MSGV3'.
      me->if_t100_message~t100key-attr4 = 'IF_T100_DYN_MSG~MSGV4'.
      me->if_t100_dyn_msg~msgv1 = msgv1.
      me->if_t100_dyn_msg~msgv2 = msgv2.
      me->if_t100_dyn_msg~msgv3 = msgv3.
      me->if_t100_dyn_msg~msgv4 = msgv4.
    ENDIF.
  ENDMETHOD.


  METHOD get_longtext_html.
    TRY.
        result = condense(
          concat_lines_of(
            cl_sat_sap_script_html_cnvrtr=>read_and_convert_t100_document(
              i_message = VALUE symsg(
                msgid = me->t100_key-msgid
                msgno = me->t100_key-msgno
                msgv1 = me->if_t100_dyn_msg~msgv1
                msgv2 = me->if_t100_dyn_msg~msgv2
                msgv3 = me->if_t100_dyn_msg~msgv3
                msgv4 = me->if_t100_dyn_msg~msgv4 ) ) ) ).
      CATCH cx_sat_not_found cx_sat_static_check.
        RETURN.
    ENDTRY.
  ENDMETHOD.


  METHOD if_message~get_longtext.
    result = cl_message_helper=>get_longtext_for_message( text = me
                                                          t100_prepend_short = ' ' ).
  ENDMETHOD.


  METHOD if_message~get_text.
    result = cl_message_helper=>get_text_for_message( me ).
  ENDMETHOD.
ENDCLASS.
