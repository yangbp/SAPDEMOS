REPORT demo_transaction_enqueue MESSAGE-ID sabapdemos.

TABLES  demo_conn.

DATA sflight_tab TYPE TABLE OF sflight.

DATA  text TYPE c LENGTH 8.

DATA  ok_code TYPE sy-ucomm.

CALL SCREEN 100.

MODULE init OUTPUT.
  SET PF-STATUS 'BASIC'.
  demo_conn-carrid = 'LH'. demo_conn-connid = '400'.
ENDMODULE.

MODULE exit INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE enqueue INPUT.
  CASE ok_code.
    WHEN 'ENQUEUE'.
      CALL FUNCTION 'ENQUEUE_EDEMOFLHT'
        EXPORTING
          mode_sflight   = 'X'
          carrid         = demo_conn-carrid
          connid         = demo_conn-connid
          fldate         = demo_conn-fldate
        EXCEPTIONS
          foreign_lock   = 1
          system_failure = 2
          OTHERS         = 3.

      CASE sy-subrc.
        WHEN 0.
          MESSAGE i888 WITH 'Enqueue successful'(001).
        WHEN 1.
          text = sy-msgv1.
          MESSAGE e888 WITH 'Record already'(002) 'locked by'(003)
                                                   text.
          TRY.
              CALL TRANSACTION 'SM12' WITH AUTHORITY-CHECK.
            CATCH cx_sy_authorization_error ##NO_HANDLER.
          ENDTRY.
        WHEN 2 OR 3.
          MESSAGE e888 WITH 'Error in enqueue!'(004)
                            'SY-SUBRC:' sy-subrc.
      ENDCASE.
    WHEN 'DEQUEUE'.
      CALL FUNCTION 'DEQUEUE_EDEMOFLHT'
        EXPORTING
          mode_sflight = 'X'
          carrid       = demo_conn-carrid
          connid       = demo_conn-connid
          fldate       = demo_conn-fldate
        EXCEPTIONS
          OTHERS       = 1.
      CASE sy-subrc.
        WHEN 0.
          MESSAGE i888 WITH 'Dequeue successful'(005).
        WHEN 1.
          MESSAGE e888 WITH 'Error in dequeue!'(006).
      ENDCASE.
    WHEN 'SM12'.
      TRY.
          CALL TRANSACTION 'SM12' WITH AUTHORITY-CHECK.
        CATCH cx_sy_authorization_error ##NO_HANDLER.
      ENDTRY.
  ENDCASE.

ENDMODULE.

MODULE select INPUT.
  CASE ok_code.
    WHEN 'SELECT'.
      SELECT *
             FROM sflight
             WHERE carrid = @demo_conn-carrid
               AND connid = @demo_conn-connid
               AND fldate = @demo_conn-fldate
             INTO TABLE @sflight_tab.
      MESSAGE i888 WITH 'SY-SUBRC:' sy-subrc.
  ENDCASE.
ENDMODULE.
