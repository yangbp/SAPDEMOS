PARSER_OPTIONS
   PARSER_NAME = "DEMO_RND_PARSER_LOGIC"
   PARSER_CLASS = "rndrt::SimpleParser"
   SCANNER_MODE = ABAP
   SCANNER_CLASS = "rndrt::SimpleScanner"
   WARNING_LEVEL = 1
   AST_MODE = GENERIC
.

// First, we define the used tokens
TOK_DEF(_C("#ANYKW#"), NUM_ANYKW)
TOK_DEF(_C("#NOTINUSE#"), NUM_ANYLIT)
TOK_DEF(_C("#EOF#"), NUM_EOF)
TOK_DEF(_C("#NL#"), NUM_NL)
TOK_DEF(_C("#COMMENT1#"), NUM_COMMENT1)
TOK_DEF(_C("#COMMENT2#"), NUM_COMMENT2)

TOK_DEF(_C("("), LPAREN)
TOK_DEF(_C(")"), RPAREN)
TOK_DEF(_C("+"), PLUS)
TOK_DEF(_C("*"), ASTERISK)
TOK_DEF(_C("="), EQUAL)
TOK_DEF(_C(";"), SEMICOLON)

// the literals (by now beyond identifers)
TOK_DEF(_C("#STR_CONST#"), CLITERAL)
TOK_DEF(_C("#INT_CONST#"), ILITERAL)

// The special tokens #ERROR# and #ID#
TOK_DEF(_C("#ERROR#"), ERROR)
TOK_DEF(_C("#ID#"), ID)

// To a variable, a value can be assigned
RULE VARIABLE ^Variable.
  PROD #ID#.

// We define the elementary constants
RULE CONSTANT ^Constant.
  PROD
      "TRUE"
    |
      "FALSE"
  .

// An assignment assigns the value on the RHS (right-hand-side)
// to the variable on the LHS (left-hand-side)
RULE ASSIGNMENT ^Assignment.
  PROD
      LHS "=" RHS
  .

// Left hand side of an assignment
RULE LHS ^LHS.
  PROD VARIABLE.

// Right hand side of an assignment
RULE RHS ^RHS.
  PROD DISJUNCTION.

// If any of the parts is true, the result is true
RULE DISJUNCTION ^Disjunction.
  PROD
      CONJUNCTION
      *( "OR" CONJUNCTION )
  .

// If any of the parts is false, the result is false
RULE CONJUNCTION ^Conjunction.
  PROD
      FACTOR
      *( "AND" FACTOR )
  .

// Negate a value
RULE NEGATION ^Negation.
  PROD
    "NOT" FACTOR.

RULE FACTOR. // ^Factor.
  PROD
      NEGATION
    |
      CONSTANT
    |
      VARIABLE
    |
      ( "(" RHS ")" )
  .

// The main rule is called "START"
RULE START .
  PROD
      *( ASSIGNMENT ";" )
      RHS
  .
