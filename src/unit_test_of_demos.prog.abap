REPORT unit_test_of_demos.
**----------------------------------------------------------------------*
** Excecution of examples from Package SABAPDEMOS                       *
** Those are small Dialog Programs that should not be tested one by one *
** This test ensures that the selected programs run without short dump  *
**----------------------------------------------------------------------*
*
*CLASS test_demos DEFINITION FOR TESTING DURATION MEDIUM
*                 RISK LEVEL HARMLESS FINAL.
*  PRIVATE SECTION.
*    METHODS abap_demo_test FOR TESTING.
*ENDCLASS.
*
*CLASS test_demos IMPLEMENTATION.
*  METHOD abap_demo_test.
*
*    DATA itf_tab TYPE TABLE OF tline.
*    DATA itf TYPE tline.
*
*    DATA p_header TYPE thead.                               "#EC NEEDED
*
*    DATA mess(80) TYPE c.
*
*    "DATA sum TYPE i.
*
*    DATA: object TYPE dokil-object,
*          exa_tab  LIKE TABLE OF object.
*
*    DATA mline TYPE  i.
*    DATA mlen  TYPE  i.
*    DATA moff  TYPE  i.
*    DATA tran_flag(1) TYPE c.
*
*    DATA repname TYPE sy-repid.
*    DATA tcode   TYPE sy-tcode.
*    DATA cinfo   TYPE tstc-cinfo.
*    DATA trinfo  TYPE tstcp-param.
*    DATA cls     TYPE seoclsname.
*    DATA meth    TYPE seocpdname.
*
*    DATA reptab TYPE TABLE OF string.
*
*    DATA sum TYPE i.
*
*    CONSTANTS c_langu TYPE sy-langu VALUE 'D'.
*
*    SELECT object
*           FROM dokil
*           INTO TABLE exa_tab
*           WHERE  id = 'SD'  AND
*                  typ = 'E'  AND
*                  langu = c_langu AND
*                  object LIKE 'ABEN%EXA'.
*
*
*    LOOP AT exa_tab INTO object.
*      CLEAR: cls, meth.
*
*      CALL FUNCTION 'DOCU_GET'
*        EXPORTING
*          id                = 'SD'
*          langu             = c_langu
*          object            = object
*          typ               = 'E'
*        IMPORTING
*          head              = p_header
*        TABLES
*          line              = itf_tab
*        EXCEPTIONS
*          no_docu_on_screen = 1
*          no_docu_self_def  = 2
*          no_docu_temp      = 3
*          ret_code          = 4
*          OTHERS            = 5.
*      IF sy-subrc = 0.
*
*        FIND '<DS:REPO.' IN TABLE itf_tab
*             MATCH LINE mline.
*        IF sy-subrc = 0.
*          tran_flag = ' '.
*        ELSEIF sy-subrc <> 0.
*          FIND '<DS:TRAN.' IN TABLE itf_tab
*             MATCH LINE mline.
*          IF sy-subrc = 0.
*            tran_flag = 'X'.
*            CONTINUE.
*          ENDIF.
*        ENDIF.
*
*        READ TABLE itf_tab INTO itf INDEX mline.
*
*        IF tran_flag = ' '.
*          FIND REGEX 'REPO\.\w+' IN itf-tdline
*               MATCH OFFSET moff
*               MATCH LENGTH mlen.
*          moff = moff + 5.
*          mlen = mlen - 5.
*          repname = itf-tdline+moff(mlen).
*        ELSE.
*          FIND REGEX 'TRAN\.\w+' IN itf-tdline
*               MATCH OFFSET moff
*               MATCH LENGTH mlen.
*          moff = moff + 5.
*          mlen = mlen - 5.
*          tcode = itf-tdline+moff(mlen).
*          SELECT SINGLE pgmna cinfo
*                 FROM tstc
*                 INTO (repname,cinfo)
*                 WHERE tcode = tcode.
*          IF sy-subrc <> 0.
*            CONCATENATE object `: No program for transaction!` INTO mess."#EC NOTEXT
*            cl_aunit_assert=>fail(
*              msg   = mess
*             level = cl_aunit_assert=>critical ).
*          ENDIF.
*          IF repname IS INITIAL AND cinfo = '08'.   "OO transaction linked to global class
*            SELECT SINGLE param
*                   FROM tstcp
*                   INTO trinfo
*                   WHERE tcode = tcode.
*            IF sy-subrc = 0.
*              FIND REGEX '\\CLASS=(.+)\\METHOD=(.+)' IN trinfo SUBMATCHES cls meth.
*              IF sy-subrc = 0.
*                SYSTEM-CALL QUERY CLASS cls.
*                IF sy-subrc = 0.
*                  SYSTEM-CALL QUERY METHOD meth
*                                OF CLASS cls
*                                INCLUDE INTO repname NO DBLOCK.
*                ENDIF.
*              ENDIF.
*            ENDIF.
*          ENDIF.
*        ENDIF.
*
*        READ REPORT repname INTO reptab.
*
*
*        FIND 'call screen' IN TABLE reptab IGNORING CASE.
*        IF sy-subrc = 0.
*          CONTINUE.
*        ENDIF.
*        FIND 'call selection-screen' IN TABLE reptab IGNORING CASE.
*        IF sy-subrc = 0.
*          CONTINUE.
*        ENDIF.
*        FIND 'cl_abap_browser' IN TABLE reptab IGNORING CASE.
*        IF sy-subrc = 0.
*          CONTINUE.
*        ENDIF.
*        FIND 'call dialog' IN TABLE reptab IGNORING CASE.
*        IF sy-subrc = 0.
*          CONTINUE.
*        ENDIF.
*        FIND 'call transaction' IN TABLE reptab IGNORING CASE.
*        IF sy-subrc = 0.
*          CONTINUE.
*        ENDIF.
*        FIND 'break-point' IN TABLE reptab IGNORING CASE.
*        IF sy-subrc = 0.
*          CONTINUE.
*        ENDIF.
*        FIND 'cl_demo_text' IN TABLE reptab IGNORING CASE.
*        IF sy-subrc = 0.
*          CONTINUE.
*        ENDIF.
*
**        FIND 'message' IN TABLE reptab IGNORING CASE.
**        IF sy-subrc = 0.
**          BREAK-POINT.
**        ENDIF.
*
*        CASE repname.
*          WHEN 'DEMO_CONTEXT_MESSAGE' OR
*               'DEMO_ROUND' OR
*               'DEMO_FREE_SELECTIONS' OR
*               'DEMO_AT_SELECTION_ON_BLOCK' OR
*               'DEMO_ADBC_DDL_DML_BINDING' OR          " the following send messages
*               'DEMO_ADBC_DDL_DML' OR
*               'DEMO_ADBC_STORED_PROCEDURE' OR
*               'DEMO_CMAX_CMIN' OR
*               'DEMO_CONVERSION_COSTS' OR
*               'DEMO_DESCRIBE_FIELD' OR
*               'DEMO_METHOD_CHAINING' OR
*               'DEMO_MODIFY_TABLE_USING_KEY' OR
*               'DEMO_NMAX_NMIN' OR
*               'DEMO_EXEC_SQL' OR
*               'DEMO_QUERY_SERVICE' OR
*               'DEMO_TRANSACTION_SERVICE' OR
*               'DEMO_RTTI_DATA_TYPES' OR
*               'DEMO_RTTI_OBJECT_TYPES' OR
*               'DEMO_CREATE_DATA_VIA_HANDLE' OR
*               'DEMO_TRY' OR
*               'DEMO_ASXML_QNAME' OR
*               'DEMO_MOVE_EXACT' OR
*               'DEMO_XML_TO_SHARED_OBJECTS' OR
*               'DEMO_CREATE_SHARED_OBJECT' OR
*               'DEMO_MOD_TECH_FB_READ_SPFLI' OR
*               'DEMO_CREATE_SHARED_DATA_OBJECT'.
*            CONTINUE.
*        ENDCASE.
*
*        IF tran_flag = ' '.
*          SUBMIT (repname) EXPORTING LIST TO MEMORY
*                           AND RETURN.
*          sum = sum + 1.
*        ENDIF.
*
*      ENDIF.
*
*    ENDLOOP.
*
*  ENDMETHOD.
*ENDCLASS.
