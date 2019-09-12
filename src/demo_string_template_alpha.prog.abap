REPORT demo_string_template_alpha.

PARAMETERS: text    TYPE c LENGTH 20
                           LOWER CASE
                           DEFAULT '     0000012345',
            length  TYPE i DEFAULT 20,
            width   TYPE i DEFAULT 0.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS output IMPORTING title TYPE csequence
                                   text  TYPE csequence.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: textstring       TYPE string,
          resultstring_in  TYPE string,
          resultfield_in   TYPE REF TO data,
          resultstring_out TYPE string,
          resultfield_out  TYPE REF TO data.
    FIELD-SYMBOLS: <resultfield_in>  TYPE data,
                   <resultfield_out> TYPE data.
    CONCATENATE text `` INTO textstring RESPECTING BLANKS.
    CREATE DATA resultfield_in  TYPE c LENGTH length.
    CREATE DATA resultfield_out TYPE c LENGTH length.
    ASSIGN resultfield_in->* TO <resultfield_in>.
    ASSIGN resultfield_out->* TO <resultfield_out>.
    IF width = 0.
      resultstring_in   = |{ textstring ALPHA = IN  }|.
      output( title = `String, IN` text = resultstring_in ).
      <resultfield_in>  = |{ textstring ALPHA = IN  }|.
      output( title = `Field,  IN` text = <resultfield_in> ).
      resultstring_out  = |{ textstring ALPHA = OUT }|.
      output( title = `String, OUT` text = resultstring_out ).
      <resultfield_out> = |{ textstring ALPHA = OUT }|.
      output( title = `Field,  OUT` text = <resultfield_out> ).
    ELSE.
      resultstring_in   = |{ textstring ALPHA = IN  WIDTH = width }|.
      output( title = `String, IN` text = resultstring_in ).
      <resultfield_in>  = |{ textstring ALPHA = IN  WIDTH = width }|.
      output( title = `Field,  IN` text = <resultfield_in> ).
      resultstring_out  = |{ textstring ALPHA = OUT WIDTH = width }|.
      output( title = `String, OUT` text = resultstring_out ).
      <resultfield_out> = |{ textstring ALPHA = OUT WIDTH = width }|.
      output( title = `Field,  OUT` text = <resultfield_out> ).
    ENDIF.
  ENDMETHOD.
  METHOD output.
    DATA fill TYPE c LENGTH 40.
    WRITE: /(12) title COLOR COL_HEADING NO-GAP,
            (3)  fill COLOR COL_POSITIVE NO-GAP,
                 text COLOR COL_NORMAL   NO-GAP,
                 fill COLOR COL_POSITIVE NO-GAP,
            40   fill.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).

AT SELECTION-SCREEN.
  IF length < 1 OR length > 20.
    MESSAGE 'Length between 1 and 20 only' TYPE 'E'.
  ENDIF.
  IF width < 0 OR width > 20.
    MESSAGE 'Width between 0 and 20 only' TYPE 'E'.
  ENDIF.
