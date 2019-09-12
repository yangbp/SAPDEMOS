REPORT demo_characters_in_abap_names NO STANDARD PAGE HEADING.

PARAMETERS: ptype RADIOBUTTON GROUP gr,
            pdata RADIOBUTTON GROUP gr,
            pproc RADIOBUTTON GROUP gr,
            ppara RADIOBUTTON GROUP gr.
SELECTION-SCREEN uline.
PARAMETERS uccheck as CHECKBOX DEFAULT 'X'.

AT SELECTION-SCREEN.
  if CL_ABAP_CHAR_UTILITIES=>charsize = 2 and uccheck = ' '.
    MESSAGE text-ucc TYPE 'E'.
  endif.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA source TYPE TABLE OF string.
    CLASS-DATA dir TYPE trdir.
    CLASS-DATA char TYPE string.
    CLASS-METHODS edit_and_check
      IMPORTING tmpl LIKE source token TYPE string.
    CLASS-METHODS check.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: code     TYPE x LENGTH 2,
          tmpl1    LIKE source,
          tmpl2    LIKE source.

    SET PF-STATUS 'LIST'.
    FORMAT FRAMES OFF INTENSIFIED OFF.

    SELECT SINGLE *
           FROM trdir
           WHERE name = @sy-repid
           INTO @dir.

    tmpl1 = VALUE #(
       ( `REPORT.` )
       ( `DATA name TYPE i.` ) ).

    tmpl2 = VALUE #(
        ( `REPORT.`  )
        ( `CLASS class DEFINITION.`  )
        ( `PUBLIC SECTION.`  )
        ( `DATA name TYPE i.`  )
        ( `ENDCLASS.`  ) ).

    IF ptype =  'X'.
      REPLACE `DATA name` IN TABLE tmpl1 WITH `TYPES name`.
      REPLACE `DATA name` IN TABLE tmpl2 WITH `TYPES name`.
    ELSEIF pproc =  'X'.
      REPLACE `DATA name TYPE i.` IN TABLE tmpl1
              WITH `FORM name USING p TYPE i. ENDFORM.`.
      REPLACE `DATA name TYPE i.` IN TABLE tmpl2
              WITH `METHODS name IMPORTING p TYPE i.`.
      APPEND `CLASS class IMPLEMENTATION.` TO tmpl2.
      APPEND `METHOD name. ENDMETHOD.` TO tmpl2.
      APPEND `ENDCLASS.` TO tmpl2.
    ELSEIF ppara =  'X'.
      REPLACE `DATA name TYPE i.` IN TABLE tmpl1
              WITH `FORM subr USING name TYPE i. ENDFORM.`.
      REPLACE `DATA name TYPE i.` IN TABLE tmpl2
              WITH `METHODS meth IMPORTING name TYPE i.`.
      APPEND `CLASS class IMPLEMENTATION.` TO tmpl2.
      APPEND `METHOD meth. ENDMETHOD.` TO tmpl2.
      APPEND `ENDCLASS.` TO tmpl2.
    ENDIF.

    WRITE: /(10) 'Code', (10) 'char', (10) 'Achar', (10) 'AcharB',
            (10) 'charB', (10) 'char_B', (10) 'Achar OO',
            (10) 'AcharB OO',  (10) 'charB OO', (10) 'char_B OO'.


    DO 96 TIMES.

      code = sy-index + 32.
      char = |{ cl_abap_conv_in_ce=>uccp( code ) WIDTH = 1 }|.

      WRITE: /(10) code COLOR COL_NORMAL, (10) char COLOR COL_HEADING.

      "Outside class
      edit_and_check( tmpl = tmpl1 token = `A`  && char ).
      edit_and_check( tmpl = tmpl1 token = `A`  && char && `B` ).
      edit_and_check( tmpl = tmpl1 token = char && `B` ).
      edit_and_check( tmpl = tmpl1 token = char && `_B` ).

      "Inside class
      edit_and_check( tmpl = tmpl2 token = `A`  && char ).
      edit_and_check( tmpl = tmpl2 token = `A`  && char && `B` ).
      edit_and_check( tmpl = tmpl2 token = char && `B` ).
      edit_and_check( tmpl = tmpl2 token = char && `_B` ).

    ENDDO.
  ENDMETHOD.
  METHOD edit_and_check.
    source = tmpl.
    REPLACE ALL OCCURRENCES OF `name` IN TABLE source WITH token.
    check( ).
  ENDMETHOD.
  METHOD check.
    DATA mess TYPE string.
    DATA lin TYPE i ##NEEDED.
    DATA wrd TYPE string ##NEEDED.
    DATA warnings TYPE  STANDARD TABLE OF rslinlmsg.
    CLEAR mess.
    CLEAR warnings.
    dir-uccheck = uccheck.
    IF char = ':' OR char = '!' OR char = '+'.
      mess = 'Error'.
    ELSE.
      SYNTAX-CHECK FOR source MESSAGE mess LINE lin
                              WORD wrd DIRECTORY ENTRY dir
                              ID 'MSG' TABLE warnings.
    ENDIF.
    IF mess IS NOT INITIAL.
      WRITE (10) 'Error' COLOR COL_NEGATIVE.
    ELSEIF warnings IS NOT INITIAL.
      WRITE (10) 'Warning' COLOR COL_TOTAL.
    ELSE.
      WRITE (10) 'OK' COLOR COL_POSITIVE.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).

AT USER-COMMAND.
  IF sy-ucomm = 'ONLINE_HELP'.
    DATA lt_links TYPE TABLE OF tline ##DECL_EVENT.
    CALL FUNCTION 'HELP_OBJECT_SHOW'
      EXPORTING
        dokclass         = 'RE'
        doklangu         = sy-langu
        dokname          = sy-repid
        short_text       = abap_false
      TABLES
        links            = lt_links
      EXCEPTIONS
        object_not_found = 1
        sapscript_error  = 2
        OTHERS           = 3.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.
