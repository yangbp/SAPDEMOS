interface IF_DEMO_OUTPUT
  public .


  methods WRITE
    importing
      !DATA type ANY
      !NAME type STRING optional
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  methods WRITE_DATA
    importing
      !VALUE type DATA
      !NAME type STRING optional
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  methods WRITE_TEXT
    importing
      !TEXT type CLIKE
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  methods DISPLAY
    importing
      !DATA type ANY optional
      !NAME type STRING optional PREFERRED PARAMETER data
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  methods WRITE_XML
    importing
      !XML type SIMPLE
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  methods WRITE_JSON
    importing
      !JSON type SIMPLE
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  methods WRITE_HTML
    importing
      !HTML type CSEQUENCE
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  methods BEGIN_SECTION
    importing
      !TITLE type CLIKE optional
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  methods END_SECTION
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  methods LINE
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  methods NEXT_SECTION
    importing
      !TITLE type CLIKE
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  methods GET
    importing
      !DATA type ANY optional
      !NAME type STRING optional PREFERRED PARAMETER data
    returning
      value(OUTPUT) type STRING .
endinterface.
