interface IF_DEMO_INPUT
  public .


  methods ADD_FIELD
    importing
      !TEXT type STRING optional
      !AS_CHECKBOX type ABAP_BOOL optional
    changing
      !FIELD type SIMPLE
    returning
      value(INPUT) type ref to IF_DEMO_INPUT .
  methods REQUEST
    importing
      !TEXT type STRING optional
      !AS_CHECKBOX type ABAP_BOOL optional
    changing
      !FIELD type SIMPLE optional .
  methods ADD_LINE
    returning
      value(INPUT) type ref to IF_DEMO_INPUT .
  methods ADD_TEXT
    importing
      !TEXT type STRING optional
    returning
      value(INPUT) type ref to IF_DEMO_INPUT .
endinterface.
