*** This report demonstrates how the class CL_RND_PARSER can be used
*** to create an AST (abstract syntax tree) from an input source.
*** It is easy to interpret the input by traversing that AST.
***
*** The AST is stored in a mesh. See also DEMO_MESH* for more
*** demos regarding meshes.
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

REPORT demo_rnd_parser_ast.

TABLES sscrfields.

CONSTANTS gc_cmd_help TYPE sscrfields-ucomm VALUE 'HELP'.

SELECTION-SCREEN PUSHBUTTON 20(10) TEXT-001 USER-COMMAND help.

" The input string to parse
PARAMETERS input TYPE string DEFAULT `TO_BE = FALSE; TO_BE OR NOT TO_BE`.


"! The lcl_parser class encapsulates and enhances CL_RND_PARSER
CLASS lcl_parser DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS constructor.

    "! Parse the input string and store the created AST
    METHODS parse IMPORTING iv_input TYPE string.

    "! Print the AST
    METHODS print_ast.

    "! Show help to the user
    CLASS-METHODS help.

    DATA mm_ast TYPE cl_rnd_parser=>tm_ast.

    "! Concatenate all tokens of an AST node
    METHODS get_token_string
      IMPORTING is_token      LIKE LINE OF mm_ast-nodes
      RETURNING VALUE(rv_str) TYPE string.

  PRIVATE SECTION.
    "! Called recursivly, to print a node with its children
    METHODS print_node
      IMPORTING
        is_node  TYPE cl_rnd_parser=>ts_ast_node
        iv_level TYPE i.
    "! The input source string
    DATA mv_source TYPE string.
    "! The list of tokens in the input string
    DATA mo_parser TYPE REF TO cl_rnd_parser.
    "! The compiled grammar is stored in this program
    CONSTANTS mc_grammar_program TYPE program VALUE 'DEMO_RND_PARSER_LOGIC_PAD'.
ENDCLASS.

"! This class interpretes the AST and executes it
CLASS lcl_interpreter DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS constructor IMPORTING io_parser TYPE REF TO lcl_parser.
    "! Interpret the AST and execute it
    METHODS execute.
  PRIVATE SECTION.
    METHODS calculate_node
      IMPORTING is_node          TYPE cl_rnd_parser=>ts_ast_node
      RETURNING VALUE(rv_result) TYPE abap_bool.
    TYPES:
      "! We can store a logical value in a variable
      BEGIN OF ty_memory,
        variable TYPE string,
        value    TYPE abap_bool,
      END OF ty_memory.
    "! Table of variables
    TYPES tt_memory TYPE SORTED TABLE OF ty_memory WITH UNIQUE KEY variable.
    DATA mt_memory TYPE tt_memory.
    "! Type index of AST node type "LHS"
    DATA mc_node_type_lhs TYPE cl_rnd_parser=>tv_index.
    "! Type index of AST node type "RHS"
    DATA mc_node_type_rhs TYPE cl_rnd_parser=>tv_index.
    "! The parser instance, which manages the AST
    DATA mo_parser TYPE REF TO lcl_parser.
    CLASS-METHODS bool2str
      IMPORTING iv_value      TYPE abap_bool
      RETURNING VALUE(rv_str) TYPE string.
ENDCLASS.

CLASS lcl_parser IMPLEMENTATION.

  METHOD constructor.
    " Create the grammar object - the pad file is stored in an include program
    DATA(lo_grammar) = cl_rnd_grammar=>create_by_program_name( mc_grammar_program ).

    " Create the parser object, using this grammar and the CDS parser
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
    mo_parser->parse_and_create_ast(
      EXPORTING
        iv_input = mv_source
      IMPORTING
        em_ast = mm_ast
    ).

    " Bring up error messages
    LOOP AT mm_ast-messages INTO DATA(ls_message).
      DATA(ls_error_token) = mm_ast-messages\token[ ls_message ].
      lv_message = 'Error at "&1", column &2: &3'(002).
      REPLACE '&1' IN  lv_message WITH ls_error_token-lexem.
      REPLACE '&2' IN  lv_message WITH |{ ls_error_token-column }|.
      REPLACE '&3' IN  lv_message WITH ls_message-text.
      MESSAGE lv_message TYPE lc_message_type_error.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_token_string.
    DATA lv_from TYPE i.
    DATA lv_to   TYPE i.

    lv_from = is_token-first_token.
    lv_to = is_token-last_token.

    DATA index TYPE i.
    index = lv_from.
    WHILE index <= lv_to.
      IF index > lv_from.
        rv_str = rv_str && ` `.
      ENDIF.
      rv_str = rv_str && mm_ast-tokens[ index = index ]-lexem.
      ADD 1 TO index.
    ENDWHILE.
  ENDMETHOD.
  METHOD print_ast.
    LOOP AT mm_ast-nodes\children[ VALUE #( ) ] INTO DATA(ls_root_node).
      print_node( is_node = ls_root_node iv_level = 1 ).
    ENDLOOP.
  ENDMETHOD.
  METHOD print_node.
    DATA line TYPE string.

    DO iv_level TIMES.
      line = line && `  `.
    ENDDO.

    DATA(lv_name) = mm_ast-nodes\type[ is_node ]-name.
    DATA(lv_token_sequence) = get_token_string( is_node ).
    line = line && lv_name && `: ` && lv_token_sequence.
    WRITE / line.

    LOOP AT mm_ast-nodes\children[ is_node ] INTO DATA(ls_child_node).
      print_node( is_node = ls_child_node iv_level = iv_level + 1 ).
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

CLASS lcl_interpreter IMPLEMENTATION.
  METHOD constructor.
    mo_parser = io_parser.
    mc_node_type_lhs = mo_parser->mm_ast-node_types->*[ KEY by_name name = 'LHS' ]-index.
    mc_node_type_rhs = mo_parser->mm_ast-node_types->*[ KEY by_name name = 'RHS' ]-index.
  ENDMETHOD.
  METHOD calculate_node.
    DATA lv_lexem TYPE string.
    DATA ls_child TYPE cl_rnd_parser=>ts_ast_node.
    DATA ls_memory TYPE ty_memory.
    DATA lv_message TYPE string.

    DATA(ls_type) = mo_parser->mm_ast-nodes\type[ is_node ].
    CASE ls_type-name.
      WHEN 'Assignment' ##NO_TEXT.
        "ls_memory-variable = mo_parser->mm_ast-nodes\children[ is_node type = mc_node_type_lhs ]\first_token[ ]-lexem.
        "ls_memory-value = calculate_node( mo_parser->mm_ast-nodes\children[ is_node type = mc_node_type_rhs ] ).
        LOOP AT mo_parser->mm_ast-nodes\children[ is_node ] INTO ls_child.
          CASE ls_child-type.
            WHEN mc_node_type_lhs.
              ls_memory-variable = mo_parser->mm_ast-nodes\first_token[ ls_child ]-lexem.
            WHEN mc_node_type_rhs.
              ls_memory-value    = calculate_node( ls_child ).
          ENDCASE.
        ENDLOOP.
        APPEND ls_memory TO mt_memory.
        lv_message = 'Store variable &1 with value &2'(003).
        REPLACE '&1' IN  lv_message WITH ls_memory-variable.
        REPLACE '&2' IN  lv_message WITH bool2str( ls_memory-value ).
        WRITE:/ lv_message.
        RETURN.
      WHEN 'Variable' ##NO_TEXT.
        lv_lexem = mo_parser->mm_ast-nodes\first_token[ is_node ]-lexem.
        rv_result = mt_memory[ variable = lv_lexem ]-value.
      WHEN 'Constant' ##NO_TEXT.
        lv_lexem = mo_parser->mm_ast-nodes\first_token[ is_node ]-lexem.
        CASE lv_lexem.
          WHEN 'TRUE'.
            rv_result = abap_true.
          WHEN 'FALSE'.
            rv_result = abap_false.
          WHEN OTHERS.
            ASSERT 1 = 0.
        ENDCASE.
      WHEN 'Disjunction' ##NO_TEXT.
        rv_result = abap_false.
        LOOP AT mo_parser->mm_ast-nodes\children[ is_node ] INTO ls_child.
          IF abap_true = calculate_node( ls_child ).
            rv_result = abap_true.
            EXIT.
          ENDIF.
        ENDLOOP.
      WHEN 'Conjunction' ##NO_TEXT.
        rv_result = abap_true.
        LOOP AT mo_parser->mm_ast-nodes\children[ is_node ] INTO ls_child.
          IF abap_false = calculate_node( ls_child ).
            rv_result = abap_false.
            EXIT.
          ENDIF.
        ENDLOOP.
      WHEN 'Negation' ##NO_TEXT.
        IF abap_false = calculate_node( VALUE #( mo_parser->mm_ast-nodes\children[ is_node ] ) ).
          rv_result = abap_true.
        ENDIF.
      WHEN 'LHS' OR 'RHS'." or 'Factor'.
*        assert 1 = lines( mo_parser->mm_ast-nodes\children[ is_node ] ).
        rv_result = calculate_node( VALUE #( mo_parser->mm_ast-nodes\children[ is_node ] ) ).
        RETURN.
      WHEN OTHERS.
        MESSAGE |Unknown node type "{ ls_type-name }"| TYPE 'E'.
    ENDCASE.

    DATA(tokens) = mo_parser->get_token_string( is_node ).
    WRITE: / tokens, '(', ls_type-name, ')', '->', bool2str( rv_result ).
  ENDMETHOD.
  METHOD execute.
    CONSTANTS no_parent TYPE cl_rnd_parser=>ts_ast_node VALUE IS INITIAL.
    LOOP AT mo_parser->mm_ast-nodes\children[ no_parent ] INTO DATA(ls_root_node).
      DATA(lv_result) = calculate_node( ls_root_node ).
    ENDLOOP.
    WRITE: / 'Result'(004), ' = ', bool2str( lv_result ).
  ENDMETHOD.
  METHOD bool2str.
    IF iv_value = abap_true.
      rv_str = 'true' ##NO_TEXT.
    ELSEIF iv_value = abap_false.
      rv_str = 'false' ##NO_TEXT.
    ELSE.
      rv_str = '???'.
    ENDIF.
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

  FORMAT COLOR COL_HEADING INTENSIFIED ON.
  WRITE / 'Input source'(005).
  FORMAT RESET.
  WRITE / input.


  SKIP.
  FORMAT COLOR COL_HEADING INTENSIFIED ON.
  WRITE / 'Abstract Syntax Tree (AST)'(006).
  FORMAT RESET.
  parser->parse( input ).

  parser->print_ast( ).


  SKIP.
  FORMAT COLOR COL_HEADING INTENSIFIED ON.
  WRITE / 'Execution'(007).
  FORMAT RESET.

  DATA interpreter TYPE REF TO lcl_interpreter.
  CREATE OBJECT interpreter EXPORTING io_parser = parser.
  interpreter->execute( ).
