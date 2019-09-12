*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations


CLASS cx_name DEFINITION INHERITING FROM cx_static_check FINAL.
ENDCLASS.

*******************************************************************************

* Trying to get the name by calling SLIN-methods,

*CLASS code_scan DEFINITION FINAL.
*
*  PUBLIC SECTION.
*
*    CLASS-METHODS get_par_name
*      IMPORTING stack_frame TYPE LINE OF abap_callstack
*                lines       TYPE STANDARD TABLE
*      RETURNING VALUE(ret)  TYPE string
*      RAISING   cx_name.
*
*
*  PRIVATE SECTION.
*
*    CLASS-DATA: prog     TYPE REF TO cl_slin_prog,
*                scan     TYPE REF TO cl_slin_scan,
*                call_set TYPE REF TO cl_slin_call_set_mng.
*
*    CLASS-DATA: stack_frame TYPE abap_callstack_line,
*                lines       TYPE STANDARD TABLE OF abap_callstack_line-line,
*                calls       TYPE STANDARD TABLE OF REF TO cl_slin_call_method.
*
*ENDCLASS.
*
*CLASS code_scan IMPLEMENTATION.
*
*  METHOD get_par_name.
*
*
*    DATA source_pos TYPE cl_slin_util=>src_pos.
*    DATA stmnt_idx TYPE sstmnt_idx.
*
*    DATA: call_item TYPE cl_slin_call_set_mng=>call_pos_item,
*          meth_call TYPE REF TO cl_slin_call_method,
*          argument  TYPE if_slin_proc_sig=>argument.
*
*
*    IF prog       IS NOT BOUND OR
*       prog->name NE stack_frame-mainprogram.
*      prog     = cl_slin_prog=>get_instance( stack_frame-mainprogram ).
*      scan     = prog->get_scan( ).
*      call_set = prog->get_call_mng( ).
*
*      CLEAR code_scan=>stack_frame.
*    ENDIF.
*
*    IF stack_frame NE code_scan=>stack_frame OR
*       lines       NE code_scan=>lines.
*      code_scan=>stack_frame = stack_frame.
*      code_scan=>lines       = lines.
*
*      source_pos-incl = stack_frame-include.
*      source_pos-row  = stack_frame-line.
*      stmnt_idx = scan->pos_to_idx( source_pos ).
*      CLEAR calls.
*      LOOP AT call_set->calls INTO call_item
*                              WHERE idx = stmnt_idx.
*        TRY.
*            meth_call ?= call_item-call.
*          CATCH cx_sy_move_cast_error.
*            RAISE EXCEPTION TYPE cx_name.
*        ENDTRY.
*        CHECK ( matches( val = meth_call->sig-call_name regex = `(?:\w+(?:-|=)>)?write\w*`   case = abap_false ) OR
*                matches( val = meth_call->sig-call_name regex = `(?:\w+(?:-|=)>)?display\w*` case = abap_false )
*               ) AND
*              lines( meth_call->sig-args ) > 0.
*        INSERT meth_call INTO calls INDEX 1.
*      ENDLOOP.
*      "SORT calls BY table_line->chain_index. "Private Attribute in some releases
*    ENDIF.
*
*    READ TABLE calls INTO meth_call INDEX 1.
*    IF sy-subrc <> 0.
*      RAISE EXCEPTION TYPE cx_name.
*    ENDIF.
*
*    READ TABLE meth_call->sig-args INTO  argument
*                                   INDEX 1.
*    IF sy-subrc <> 0.
*      RAISE EXCEPTION TYPE cx_name.
*    ENDIF.
*    DELETE calls INDEX 1.
*
*    IF argument-a_id_tag = if_slin_proc_sig=>argument_tag-id.
*      ret = argument-a_id.
*    ENDIF.
*    IF ret CS ` ` OR
*       matches( val = ret regex = `\d+` ).
*      CLEAR ret.
*    ENDIF.
*
*  ENDMETHOD.
*
*ENDCLASS.


*******************************************************************************

* Trying to get the name by analyzing LOAD tables

*CLASS introspection DEFINITION FINAL.
*
*  PUBLIC SECTION.
*
*    CLASS-METHODS get_par_name
*      IMPORTING stack_frame TYPE LINE OF abap_callstack
*      RETURNING VALUE(ret)  TYPE string
*      RAISING   cx_name.
*
*  PRIVATE SECTION.
*    CLASS-DATA counter TYPE i.
*    CLASS-DATA stack_frame TYPE LINE OF abap_callstack.
*ENDCLASS.
*
*
*CLASS introspection  IMPLEMENTATION.
*
*  METHOD get_par_name.
*
*    CONSTANTS: cboffset TYPE x LENGTH 2 VALUE 'C000'.
*
*    DATA: program TYPE progname,
*          line    TYPE n LENGTH 5,
*          cbindex TYPE c LENGTH 6,
*          envkind TYPE rsymbdata-envkind.
*    DATA trigid TYPE i.
*    DATA idx TYPE sy-tabix.
*    DATA clcl_cnt TYPE i.
*    DATA clcm_cnt TYPE i.
*    DATA clom_cnt TYPE i.
*    DATA meth_cnt TYPE i.
*
*    DATA: cont        TYPE STANDARD TABLE OF rcont,
*          wa_cont     TYPE rcont,
*          tb_cont     TYPE TABLE OF rcont,
*          trig        TYPE STANDARD TABLE OF rtrig,
*          wa_trig     TYPE rtrig,
*          symbdata    TYPE STANDARD TABLE OF rsymbdata,
*          wa_symbdata TYPE rsymbdata,
*          par         TYPE string VALUE `PAR1`.
*
*    IF stack_frame <> introspection=>stack_frame.
*      introspection=>stack_frame = stack_frame.
*      counter = 0.
*    ENDIF.
*
*    line = |{ stack_frame-line  WIDTH = 5  ALIGN = RIGHT  PAD = '0' }|.
*    program = stack_frame-mainprogram.
*
*    LOAD REPORT program PART 'CONT' INTO cont.
*    LOOP AT cont INTO wa_cont WHERE line   = line AND
*                                    source = stack_frame-include AND
*                                    ( opcode = 'clcm' OR opcode = 'clom' OR opcode = 'clcl' OR opcode = 'METH' ).
*      IF wa_cont-opcode = 'clcm'.
*        clcm_cnt = clcm_cnt + 1.
*      ELSEIF wa_cont-opcode = 'clom' ##NO_TEXT.
*        clom_cnt = clom_cnt + 1.
*        par = `PAR2`.
*      ELSEIF wa_cont-opcode = 'clcl' ##NO_TEXT.
*        clcl_cnt = clcl_cnt + 1.
*      ELSEIF wa_cont-opcode = 'METH'.
*        meth_cnt = meth_cnt + 1.
*      ENDIF.
*    ENDLOOP.
*    IF clcm_cnt + clom_cnt + meth_cnt + clcl_cnt = 1.
*      "One method call per line
*      READ TABLE cont INTO wa_cont WITH KEY line   = line
*                                            source = stack_frame-include
*                                            opcode = 'PAR1'
*                                            flag   = '00'.
*    ELSE.
*      "Several method calls or chained statement in line
*      IF clcm_cnt + clcl_cnt <= 1.
*        LOOP AT cont INTO wa_cont WHERE line   = line AND
*                                        source = stack_frame-include AND
*                                        ( opcode = 'clcm' OR opcode = 'clom' OR opcode = 'METH' ).
*          idx = sy-tabix.
*          "Trick, the methods needed have an additional optional input parameter
*          READ TABLE cont INTO wa_cont INDEX idx + 3.
*          IF wa_cont-opcode = par.
*            READ TABLE cont INTO wa_cont INDEX idx + 1.
*            APPEND wa_cont TO tb_cont.
*          ENDIF.
*        ENDLOOP.
*        counter = counter + 1.
*        READ TABLE tb_cont INTO wa_cont INDEX counter.
*      ELSE.
*        "Can't handle several calls of static methods in one line
*        CLEAR ret.
*        RETURN.
*      ENDIF.
*    ENDIF.
*
*    IF sy-subrc <> 0.
*      CLEAR ret.
*      RETURN.
*    ENDIF.
*
*    CASE stack_frame-blocktype.
*      WHEN 'EVENT'.
*        envkind = 'NONE'.
*        cbindex = | { wa_cont-par0  WIDTH = 5  ALIGN = RIGHT  PAD = '0' }|.
*        trigid  = -1.
*      WHEN 'METHOD'.
*        envkind = 'TRIG'.
*        LOAD REPORT program PART 'TRIG' INTO trig.
*        READ TABLE trig INTO wa_trig WITH KEY exto = stack_frame-blockname "#EC WARNOK
*                                              name = 'METH'.
*        IF sy-subrc <> 0.
*          RAISE EXCEPTION TYPE cx_name.
*        ENDIF.
*        trigid = sy-tabix - 1.
*        cbindex = |L{ ( wa_cont-par0 - cboffset ) WIDTH = 5  ALIGN = RIGHT  PAD = '0' }|.
*    ENDCASE.
*
*    LOAD REPORT program PART 'SYMBDATA' INTO symbdata.
*    READ TABLE symbdata INTO wa_symbdata WITH KEY envkind  = envkind
*                                                  trigid   = trigid
*                                                  dcbindex = cbindex.
*
*    IF sy-subrc = 0.
*      IF strlen( wa_symbdata-name ) >= 1 AND wa_symbdata-name(1) <> '%'.
*        ret = wa_symbdata-name.
*      ENDIF.
*    ELSE.
*      "Attributes of classes, not in SYMBDATA!
*      CLEAR ret.
*    ENDIF.
*
*  ENDMETHOD.
*
*ENDCLASS.

*******************************************************************************

* Trying to get the name by analyzing caller (do-it-yourself, WYCIWYG)

CLASS code_analysis DEFINITION FINAL.

  PUBLIC SECTION.

    CLASS-METHODS get_par_name
      IMPORTING stack_frame TYPE LINE OF abap_callstack
                lines       TYPE STANDARD TABLE
      RETURNING VALUE(ret)  TYPE string
      RAISING   cx_name.

  PRIVATE SECTION.
    CLASS-DATA counter TYPE i.
    CLASS-DATA stack_frame TYPE LINE OF abap_callstack.
    CLASS-DATA lines       TYPE STANDARD TABLE OF abap_callstack_line-line.

ENDCLASS.


CLASS code_analysis  IMPLEMENTATION.

  METHOD get_par_name.

    DATA:
      progtab  TYPE TABLE OF string,
      progline TYPE string,
      idx      TYPE sy-tabix,
      moff     TYPE i.

    FIELD-SYMBOLS <progline> TYPE string.

    "Count identic calls from one line
    IF stack_frame <> code_analysis=>stack_frame OR
       lines       <> code_analysis=>lines.
      code_analysis=>stack_frame = stack_frame.
      code_analysis=>lines       = lines.
      counter = 0.
    ELSE.
      counter = counter + 1.
    ENDIF.

    READ REPORT stack_frame-include INTO progtab.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_name.
    ENDIF.
    DELETE progtab TO stack_frame-line - 1.
    "Remove comments
    LOOP AT progtab ASSIGNING <progline>.
      IF strlen( <progline> ) > 0 AND <progline>(1) = '*'.
        DELETE progtab.
        CONTINUE.
      ENDIF.
      REPLACE REGEX `\A\s*".*` IN <progline> WITH `` ##no_text.
      IF sy-subrc <> 0.
        REPLACE REGEX `(.*)(")([^'|{``]+\z)` IN <progline> WITH `$1`.
      ENDIF.
      IF <progline> IS INITIAL.
        DELETE progtab.
      ENDIF.
    ENDLOOP.
    "Get all statements that are in or begin in the line
    LOOP AT progtab ASSIGNING <progline>.
      CONDENSE <progline>.
      idx = sy-tabix.
      REPLACE ALL OCCURRENCES OF REGEX `'[^']*\.[^']*'` IN <progline> WITH `'dummy'` ##no_text.
      REPLACE ALL OCCURRENCES OF REGEX '`[^`]*\.[^`]*`' IN <progline> WITH '`dummy`' ##no_text.
      REPLACE ALL OCCURRENCES OF REGEX '\|[^|]*\.[^|]*\|' IN <progline> WITH '`dummy`' ##no_text.
      IF idx = 1.
        progline = progline && ` ` && <progline>.
        IF substring( val = progline off = strlen( progline ) - 1 len = 1 ) = `.`.
          EXIT.
        ENDIF.
      ELSE.
        FIND `.` IN <progline> MATCH OFFSET moff.
        IF sy-subrc = 0.
          progline = progline && ` ` && substring( val = <progline> len = moff + 1 ).
          EXIT.
        ELSE.
          progline = progline && ` ` && <progline>.
        ENDIF.
      ENDIF.
    ENDLOOP.
    "Separate the calls of one line
    CONDENSE progline.
    REPLACE ALL OCCURRENCES OF REGEX `\s?CALL METHOD\s([^.]+)\(\s(?:EXPORTING\s)?(?:value|data)\s=\s([^.]+)\s\)\s?\.` ##NO_TEXT
           IN progline WITH `$1( $2 ).` IGNORING CASE.
    CONDENSE progline.
    REPLACE ALL OCCURRENCES OF REGEX `\s?CALL METHOD\s([^.]+)\sEXPORTING\s(?:value|data)\s=\s([^.]+)\s?\.` ##NO_TEXT
            IN progline WITH `$1( $2 ).` IGNORING CASE.
    CONDENSE progline.
    "Exactly the following methods call get_name( )
    REPLACE ALL OCCURRENCES OF `->write(` IN progline WITH `###(` IGNORING CASE.
    REPLACE ALL OCCURRENCES OF `=>write(` IN progline WITH `###(` IGNORING CASE.
    REPLACE ALL OCCURRENCES OF `->display(` IN progline WITH `###(` IGNORING CASE.
    REPLACE ALL OCCURRENCES OF `=>display(` IN progline WITH `###(` IGNORING CASE.
    REPLACE ALL OCCURRENCES OF `->write_data(` IN progline WITH `###(` IGNORING CASE.
    REPLACE ALL OCCURRENCES OF `=>write_data(` IN progline WITH `###(` IGNORING CASE.
    REPLACE ALL OCCURRENCES OF `=>display_data(` IN progline WITH `###(` IGNORING CASE.
    REPLACE ALL OCCURRENCES OF `->get(` IN progline WITH `###(` IGNORING CASE.
    REPLACE ALL OCCURRENCES OF `=>get(` IN progline WITH `###(` IGNORING CASE.
    SPLIT progline AT `###(` INTO TABLE progtab.
    IF lines( progtab ) <= 1.
      RAISE EXCEPTION TYPE cx_name.
    ENDIF.
    DELETE progtab INDEX 1.
    LOOP AT progtab ASSIGNING <progline>.
      REPLACE REGEX `([^)]+)(\).*)` IN <progline> WITH `$1`.
      CONDENSE <progline>.
      REPLACE REGEX `(?:EXPORTING )?(?:value|data) = ` IN <progline> WITH `` IGNORING CASE ##NO_TEXT.
      IF <progline> CS ` `  OR
         matches( val = <progline> regex = `-?\d+` ) OR           "no numeric literals
         <progline> CS `'`                           OR           "no text field literals
         <progline> CS '`'                           OR           "no string literals
         <progline> CS `[` OR <progline> CS `]`      OR           "expressions (parenthesis)
         <progline> CS `(` OR <progline> CS `)`.                  "expressions (parenthesis)
        CLEAR <progline>.
      ENDIF.
    ENDLOOP.
    IF counter = 0.
      counter = 1.
    ENDIF.
    "Reset for calls in loops
    IF counter > lines( progtab ).
      counter = 1.
    ENDIF.
    READ TABLE progtab INTO ret INDEX counter.
    ret = to_upper( ret ).

  ENDMETHOD.

ENDCLASS.
