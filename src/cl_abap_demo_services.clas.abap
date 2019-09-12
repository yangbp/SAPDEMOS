class CL_ABAP_DEMO_SERVICES definition
  public
  final
  create public .

public section.

*"* public components of class CL_ABAP_DEMO_SERVICES
*"* do not include other source files here!!!
*"* protected components of class CL_ABAP_DEMO_SERVICES
*"* do not include other source files here!!!
*"* protected components of class CL_ABAP_DEMO_SERVICES
*"* do not include other source files here!!!
  class-methods LIST_TABLE
    importing
      !TABLE type ANY TABLE .
  class-methods LIST_TABLE_WITH_OFFSET
    importing
      !TABLE type ANY TABLE
      !OFFSET type I
      !LINE type I default 3 .
  class-methods LIST_TABLE_COMPONENTS
    importing
      !TABLE type ANY TABLE
      !COMPONENTS type STRING .
  class-methods IS_PRODUCTION_SYSTEM
    returning
      value(FLAG) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ABAP_DEMO_SERVICES
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ABAP_DEMO_SERVICES
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ABAP_DEMO_SERVICES IMPLEMENTATION.


METHOD is_production_system.
  SELECT SINGLE @abap_true
         FROM t000
         INTO (@flag)
         WHERE cccategory = 'P' ##WARN_OK.
  IF sy-subrc <> 0.
    flag = abap_false.
  ENDIF.
ENDMETHOD.


METHOD list_table.
  DATA subrc TYPE sy-subrc.
  FIELD-SYMBOLS: <line> TYPE ANY,
                 <comp> TYPE ANY.
  LOOP AT table ASSIGNING <line>.
    subrc = 0.
    WHILE subrc = 0.
      ASSIGN COMPONENT sy-index OF STRUCTURE <line> TO <comp>.
      subrc = sy-subrc.
      IF subrc = 0.
        IF sy-index = 1.
          WRITE / <comp>.
        ELSE.
          WRITE <comp>.
        ENDIF.
      ENDIF.
    ENDWHILE.
  ENDLOOP.
  SKIP.
ENDMETHOD.


METHOD list_table_components.
  DATA: subrc TYPE sy-subrc,
        comp_tab TYPE TABLE OF string,
        comp TYPE string.
  FIELD-SYMBOLS: <line> TYPE ANY,
                 <comp> TYPE ANY.
  SPLIT components AT `,` INTO TABLE comp_tab.
  LOOP AT table ASSIGNING <line>.
    subrc = 0.
    LOOP AT comp_tab INTO comp.
      CONDENSE comp.
      TRANSLATE comp TO UPPER CASE.
      ASSIGN COMPONENT comp OF STRUCTURE <line> TO <comp>.
      subrc = sy-subrc.
      IF subrc = 0.
        IF sy-tabix = 1.
          WRITE / <comp>.
        ELSE.
          WRITE <comp>.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDLOOP.
  SKIP.
ENDMETHOD.


METHOD list_table_with_offset.
  DATA subrc TYPE sy-subrc.
  FIELD-SYMBOLS: <line> TYPE ANY,
                 <comp> TYPE ANY.
  SKIP TO LINE line.
  LOOP AT table ASSIGNING <line>.
    subrc = 0.
    WHILE subrc = 0.
      ASSIGN COMPONENT sy-index OF STRUCTURE <line> TO <comp>.
      subrc = sy-subrc.
      IF subrc = 0.
        IF sy-index = 1.
          WRITE AT /offset <comp>.
        ELSE.
          WRITE <comp>.
        ENDIF.
      ENDIF.
    ENDWHILE.
  ENDLOOP.
ENDMETHOD.
ENDCLASS.
