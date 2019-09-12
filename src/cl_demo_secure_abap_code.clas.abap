class CL_DEMO_SECURE_ABAP_CODE definition
  public
  final
  create public .

public section.

  types:
    STRING_TABLE type STANDARD TABLE OF string with DEFAULT KEY .

  class-methods CHECK
    importing
      !SOURCE_CODE type STANDARD TABLE
      !DECLARATIONS type STANDARD TABLE optional
      !BLACK_LIST type STRING_TABLE
      !WHITE_LIST type STRING_TABLE
    returning
      value(RC) type I .

protected section.

private section.

  class-methods PREPARE_CODE
    importing
      !SOURCE_CODE type STANDARD TABLE
    returning
      value(CODE) type STRING_TABLE .
ENDCLASS.



CLASS CL_DEMO_SECURE_ABAP_CODE IMPLEMENTATION.


METHOD check.
  DATA decl_code  TYPE string_table.
  DATA first_word TYPE string.
  DATA operand    TYPE string.
  DATA key_tab    TYPE sana_keyword_tab.

  DATA(code) = prepare_code( source_code ).

  "Blacklist
  rc = 0.
  LOOP AT black_list INTO DATA(black).
    LOOP AT code ASSIGNING FIELD-SYMBOL(<code>).
      FIND black IN <code> IGNORING CASE MATCH OFFSET DATA(moff).
      IF sy-subrc = 0 AND <code>(moff) <> 'CL_DEMO_OUTPUT'.
        rc = 4.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

  "Keywords for check of =
  CALL FUNCTION 'RS_GET_ABAP_PATTERN'
    IMPORTING
      keywords = key_tab.

  LOOP AT code ASSIGNING <code>.
    first_word = match( val = <code> regex = '\<\S+\>' ).
    rc = 4.
    "No direct write access to system fields
    IF ( strlen( first_word ) >= 3 AND first_word(3) = 'SY-' ) OR
       ( strlen( first_word ) >= 5 AND first_word(5) = 'SYST-' ) OR
       first_word = 'SY' OR first_word = 'SYST'.
      EXIT.
    ENDIF.
    IF first_word = 'CLEAR' OR first_word = 'FREE'.
      FIND REGEX `\bSYST\b` IN <code>.
      IF sy-subrc = 0.
        EXIT.
      ENDIF.
      FIND REGEX `\bSY\b` IN <code>.
      IF sy-subrc = 0.
        EXIT.
      ENDIF.
    ENDIF.
    " = identifies and allows assignments if first word is not a keyword, method calls can be excluded by blacklist
    IF <code> CS ` = `.
      READ TABLE key_tab WITH KEY word = first_word TRANSPORTING NO FIELDS. "#EC WARNOK
      IF sy-subrc <> 0.
        rc = 0.
        CONTINUE.
      ENDIF.
    ENDIF.
    IF strlen( first_word ) > 16 AND first_word(16) = 'CL_DEMO_OUTPUT=>'.
      rc = 0.
      CONTINUE.
    ENDIF.
    "Check white list
    READ TABLE white_list WITH KEY table_line = first_word TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      IF first_word <> 'INSERT' AND
         first_word <> 'MODIFY' AND
         first_word <> 'DELETE'.
        rc = 0.
        CONTINUE.
      ENDIF.
    ELSE.
      rc = 4.
      EXIT.
    ENDIF.
    "These internal table statements need to be identified by searching the internal table in local declarations
    decl_code = declarations.
    APPEND LINES OF source_code TO decl_code.
    decl_code = prepare_code( decl_code ).
    IF first_word = 'INSERT'.
      REPLACE 'INTO TABLE' IN <code> WITH 'INTO'.
      FIND REGEX 'INSERT.+INTO\s(\S+).*' IN <code> SUBMATCHES operand.
    ELSEIF first_word = 'MODIFY'.
      REPLACE 'MODIFY TABLE' IN <code> WITH 'MODIFY'.
      FIND REGEX 'MODIFY\s(\S+).*' IN <code> SUBMATCHES operand.
    ELSEIF first_word = 'DELETE'.
      REPLACE 'DELETE TABLE' IN <code> WITH 'DELETE'.
      FIND REGEX 'DELETE\s(\S+).*' IN <code> SUBMATCHES operand.
    ENDIF.
    IF sy-subrc <> 0.
      rc = 4.
      EXIT.
    ENDIF.
    FIND REGEX
      'DATA\s' && operand && '\s(?:TYPE)|(?:LIKE)'
      IN TABLE decl_code.
    IF sy-subrc = 0.
      rc = 0.
      CONTINUE.
    ELSE.
      rc = 4.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD prepare_code.
  DATA code_string TYPE string.
  DATA subcode     TYPE TABLE OF string.
  DATA idx         TYPE sy-tabix.
  DATA begin       TYPE string.
  FIELD-SYMBOLS <code> TYPE string.
  FIELD-SYMBOLS <subcode> TYPE string.

  code = source_code.
  REPLACE ALL OCCURRENCES OF `''` IN TABLE code WITH `lit`.
  REPLACE ALL OCCURRENCES OF '``' IN TABLE code WITH `lit`.
  REPLACE ALL OCCURRENCES OF REGEX `'[^']+'` IN TABLE code WITH `literal` ##no_text.
  REPLACE ALL OCCURRENCES OF REGEX '`[^`]+`' IN TABLE code WITH `literal` ##no_text.
  REPLACE ALL OCCURRENCES OF REGEX '".*' IN TABLE code WITH ``.
  REPLACE ALL OCCURRENCES OF REGEX '\A\*.*' IN TABLE code WITH ``.

  CONCATENATE LINES OF code INTO code_string SEPARATED BY ` `.
  TRANSLATE code_string TO UPPER CASE.
  CONDENSE code_string.

  CLEAR code.
  SPLIT code_string AT '.' INTO TABLE code.
  LOOP AT code ASSIGNING <code>.
    CONDENSE <code>.
  ENDLOOP.
  CLEAR subcode.
  LOOP AT code ASSIGNING <code> WHERE table_line CS ':'.
    idx = sy-tabix.
    begin = substring_before( val = <code> sub = ':' ).
    SHIFT <code> LEFT UP TO ':'.
    SHIFT <code> LEFT.
    SPLIT <code> AT ',' INTO TABLE subcode.
    LOOP AT subcode ASSIGNING <subcode>.
      <subcode> = begin && ` ` && <subcode>.
      CONDENSE <subcode>.
    ENDLOOP.
    DELETE code INDEX idx.
    INSERT LINES OF subcode INTO code INDEX idx.
  ENDLOOP.
  DELETE code WHERE table_line IS INITIAL.
ENDMETHOD.
ENDCLASS.
