class CL_DEMO_TEXT definition
  public
  final
  create private .

*"* public components of class CL_DEMO_TEXT
*"* do not include other source files here!!!
public section.

  types T_LINE type CHAR80 .
  types:
    t_text TYPE STANDARD TABLE OF t_line WITH EMPTY KEY .

  class-methods NEW
    returning
      value(TEXT) type ref to CL_DEMO_TEXT .
  methods ADD_TABLE
    importing
      !TEXT_TABLE type T_TEXT .
  methods ADD_LINE
    importing
      !TEXT_LINE type T_LINE .
  methods DISPLAY .
  methods DELETE .
  class-methods DISPLAY_STRING
    importing
      !TEXT_STRING type STRING .
  class-methods EDIT_STRING
    importing
      !TITLE type STRING default 'Text'
    changing
      !TEXT_STRING type STRING
    exceptions
      CANCELED .
  methods GET
    returning
      value(TEXT) type T_TEXT .
  methods GET_AS_STRING
    returning
      value(TEXT_STRING) type STRING .
  methods EDIT .
  PROTECTED SECTION.
*"* protected components of class CL_DEMO_TEXT
*"* do not include other source files here!!!
  PRIVATE SECTION.
*"* private components of class CL_DEMO_TEXT
*"* do not include other source files here!!!

    DATA text TYPE t_text .
ENDCLASS.



CLASS CL_DEMO_TEXT IMPLEMENTATION.


  METHOD add_line.
    APPEND text_line TO me->text.
  ENDMETHOD.


  METHOD add_table.
    APPEND LINES OF text_table TO me->text.
  ENDMETHOD.


  METHOD delete.
    CLEAR me->text.
  ENDMETHOD.


  METHOD display.
    DATA(lbr) = |\n|.
    CONCATENATE LINES OF me->text INTO DATA(text_string) SEPARATED BY lbr.
    display_string( text_string ).
  ENDMETHOD.


  METHOD display_string.
    CALL FUNCTION 'DEMO_SHOW_TEXT' EXPORTING text_string = text_string.
  ENDMETHOD.


  METHOD edit.
    DATA(lbr) = |\n|.
    CONCATENATE LINES OF me->text INTO DATA(text_string) SEPARATED BY lbr.
    edit_string( EXPORTING title = CONV #( TEXT-ttl )
                 CHANGING  text_string = text_string
                 EXCEPTIONS canceled = 4 ).
    IF sy-subrc = 4.
      RETURN.
    ENDIF.
    SPLIT text_string AT lbr INTO TABLE me->text.
  ENDMETHOD.


  METHOD edit_string.
    CALL FUNCTION 'DEMO_INPUT_TEXT'
      EXPORTING
        title       = title
      CHANGING
        text_string = text_string
      EXCEPTIONS
        canceled    = 4.
    IF sy-subrc = 4.
      RAISE canceled.
    ENDIF.
  ENDMETHOD.


  METHOD get.
    text = me->text.
  ENDMETHOD.


  METHOD get_as_string.
    DATA(br) = |\n|.
    CONCATENATE LINES OF text INTO text_string SEPARATED BY br.
  ENDMETHOD.


  METHOD new.
    CREATE OBJECT text.
  ENDMETHOD.
ENDCLASS.
