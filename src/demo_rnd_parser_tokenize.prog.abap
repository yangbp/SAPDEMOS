*** This report demonstrates how the class CL_RND_PARSER can be used
***   to tokenize an input source. By that, it is possible to write
***   a pretty-printer.
*** You also find out whether the input matches the expected grammar.
***
*** The input language is a boolean expression.
*** You can use constants "TRUE" and "FALSE" and
***   operators "AND" "OR" and "NOT".
*** It is also possible to use parentheses.
*** A term can be stored in a variable and used later on.
*** Spaces are ignored.

*** Examples:
***   true or false                            (simple example)
***   TO_BE = FALSE; TO_BE OR NOT TO_BE        (store a value in variable 'TO_BE')
***   NOT (NOT FALSE AND NOT NOT FALSE)        (usage of parentheses)
***   OR = TRUE; AND = FALSE; OR AND AND OR OR (example for keyword/id conflict)
***   NOT = FALSE; NOT NOT OR NOT NOT NOT      (suspicious)

REPORT demo_rnd_parser_tokenize.

TABLES sscrfields.

CONSTANTS gc_cmd_help TYPE sscrfields-ucomm VALUE 'HELP'.

SELECTION-SCREEN PUSHBUTTON 20(10) TEXT-001 USER-COMMAND help.

" The input string to parse
PARAMETERS input TYPE string DEFAULT `TO_BE = FALSE; TO_BE OR NOT TO_BE`.


"! The lcl_parser class encapsulates and enhances CL_RND_PARSER
CLASS lcl_parser DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS constructor.

    "! Parse the input string and store the tokens in attribute mt_token
    METHODS parse IMPORTING iv_input TYPE string.

    "! Convert all keywords to uppercase, all identifiers to lower case
    METHODS pretty_print.

    "! Print the tokens
    METHODS print.

    "! Show help to the user
    CLASS-METHODS help.

  PRIVATE SECTION.
    "! The input source string
    DATA mv_source TYPE string.
    "! The input string as a list of tokens
    DATA mt_token TYPE cl_rnd_parser=>tt_token.
    DATA mo_parser TYPE REF TO cl_rnd_parser.
    "! Name of the include program containing the compiled grammar
    CONSTANTS mc_grammar_program TYPE program VALUE 'DEMO_RND_PARSER_LOGIC_PAD'.
    "! Return a readable text for a token category
    CLASS-METHODS get_category_text
      IMPORTING iv_category    TYPE cl_rnd_parser=>tv_token_category
      RETURNING VALUE(rv_text) TYPE string.
ENDCLASS.

CLASS lcl_parser IMPLEMENTATION.

  METHOD constructor.
    DATA(lo_grammar) = cl_rnd_grammar=>create_by_program_name( mc_grammar_program ).

    mo_parser = NEW cl_rnd_parser(
            io_grammar = lo_grammar
            iv_scanner_code = cl_rnd_parser=>mc_scanner_code-cds
          ).
  ENDMETHOD.

  METHOD parse.
    CONSTANTS lc_message_type_error VALUE 'E'.
    DATA lv_message TYPE string.

    mv_source = iv_input.

    " Parse the input string, store the tokens in mt_token
    mo_parser->parse(
      EXPORTING
        iv_input   = mv_source
      IMPORTING
        et_tokens  = mt_token
        et_message = data(lt_message)
    ).

    " Bring up error messages
    LOOP AT lt_message INTO DATA(ls_message).
      DATA(ls_error_token) = mt_token[ index = ls_message-token ].
      lv_message = 'Error at "&1", column &2: &3'(002).
      REPLACE '&1' IN  lv_message WITH ls_error_token-lexem.
      REPLACE '&2' IN  lv_message WITH |{ ls_error_token-column }|.
      REPLACE '&3' IN  lv_message WITH ls_message-text.
      MESSAGE lv_message TYPE lc_message_type_error.
    ENDLOOP.

  ENDMETHOD.

  METHOD print.
    " Print out input string
    FORMAT COLOR COL_HEADING.
    WRITE mv_source.
    FORMAT COLOR OFF.

    DATA lv_category_text   TYPE string.
    DATA lv_text            TYPE string.
    DATA lv_column          TYPE i.
    DATA lv_token_count     TYPE i.
    DATA lv_token_index     TYPE i.

    lv_token_count = lines( mt_token ).

    DO lv_token_count TIMES.
      lv_token_index = lv_token_count - sy-index + 1.
      DATA(ls_token) = mt_token[ lv_token_index ].

      NEW-LINE.
      lv_column = ls_token-column.
      " Print vertical lines
      LOOP AT mt_token
           FROM 1
           TO lv_token_index - 1
           INTO DATA(ls_token_for_line).
        WRITE AT ls_token_for_line-column '|'.
      ENDLOOP.

      lv_category_text = get_category_text( ls_token-category ).
      lv_text = |{ lv_category_text }: "{ ls_token-lexem }"|.

      IF ls_token-error = cl_rnd_parser=>mc_interpretation_quality-suspicous.
        lv_text = lv_text && space && '(suspicious token - looks quite like a keyword)'(003).
      ENDIF.

      lv_column = ls_token-column.
      WRITE AT lv_column line_bottom_left_corner AS LINE.
      ADD 1 TO lv_column.
      ULINE AT lv_column(2).

      WRITE lv_text.

    ENDDO.
  ENDMETHOD.

  METHOD get_category_text.
    CASE iv_category.
      WHEN cl_rnd_parser=>mc_token_category-identifier.
        rv_text = 'Variable'(010).
      WHEN cl_rnd_parser=>mc_token_category-keyword OR
           cl_rnd_parser=>mc_token_category-strict_keyword.
        rv_text = 'Keyword'(011).
      WHEN cl_rnd_parser=>mc_token_category-operator.
        rv_text = 'Operator'(012).
      WHEN cl_rnd_parser=>mc_token_category-literal.
        rv_text = 'Literal'(013).
      WHEN cl_rnd_parser=>mc_token_category-whitespace.
        rv_text = 'Whitespace'(014).
    ENDCASE.
  ENDMETHOD.

  METHOD pretty_print.
    DATA lv_from TYPE i.
    DATA lv_len  TYPE i.

    LOOP AT mt_token INTO DATA(ls_token).
      CHECK ls_token-category = cl_rnd_parser=>mc_token_category-identifier
         OR ls_token-category = cl_rnd_parser=>mc_token_category-keyword
         OR ls_token-category = cl_rnd_parser=>mc_token_category-strict_keyword.

      lv_from = ls_token-column - 1.
      lv_len  = strlen( ls_token-lexem ).
      IF ls_token-category = cl_rnd_parser=>mc_token_category-identifier.
        REPLACE ls_token-lexem IN SECTION OFFSET lv_from LENGTH lv_len OF mv_source WITH to_lower( ls_token-lexem ).
      ELSE.
        REPLACE ls_token-lexem IN SECTION OFFSET lv_from LENGTH lv_len OF mv_source WITH to_upper( ls_token-lexem ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD help.
    DATA lt_source TYPE TABLE OF string.
    READ REPORT sy-repid INTO lt_source.
    LOOP AT lt_source INTO DATA(lv_line).
      CHECK strlen( lv_line ) >= 3.
      CHECK lv_line(3) = '***'.
      lv_line = lv_line+3.
      WRITE / lv_line.
    ENDLOOP.
    SET PF-STATUS space ##STAT_PROG.
    LEAVE TO LIST-PROCESSING.
  ENDMETHOD.
ENDCLASS.

AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN gc_cmd_help.
      lcl_parser=>help( ).
  ENDCASE.

START-OF-SELECTION.

  DATA parser TYPE REF TO lcl_parser.
  CREATE OBJECT parser.

  TRANSLATE input TO UPPER CASE.
  parser->parse( input ).

  parser->pretty_print( ).

  parser->print( ).
