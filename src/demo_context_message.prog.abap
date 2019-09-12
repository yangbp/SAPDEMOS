REPORT  demo_context_message.

DATA: c_from TYPE spfli-cityfrom,
      c_to   TYPE spfli-cityto.

CONTEXTS docu_test1.

DATA: context_inst TYPE context_docu_test1.

DATA: itab TYPE TABLE OF symsg,
      line LIKE LINE OF itab.

SUPPLY carrid = 'XX'
       connid = '400'
       TO CONTEXT context_inst.


DEMAND cityfrom = c_from
       cityto   = c_to
       FROM CONTEXT context_inst MESSAGES INTO itab.

IF sy-subrc NE 0.
  line = itab[ 1 ].
  MESSAGE ID line-msgid TYPE 'I' NUMBER line-msgno
          WITH line-msgv1 line-msgv2 DISPLAY LIKE line-msgty.
ENDIF.

DEMAND cityfrom = c_from
       cityto   = c_to
       FROM CONTEXT context_inst.
