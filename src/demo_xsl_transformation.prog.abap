REPORT demo_xsl_transformation.

CLASS c1 DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_serializable_object.
  PROTECTED SECTION.
    DATA carriers TYPE TABLE OF scarr.
ENDCLASS.

CLASS c2 DEFINITION INHERITING FROM c1.
  PUBLIC SECTION.
    METHODS constructor.
  PRIVATE SECTION.
    DATA lines TYPE i.
    METHODS: serialize_helper
      EXPORTING count TYPE i,
      deserialize_helper
        IMPORTING count TYPE i.
ENDCLASS.

CLASS c2 IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    SELECT * UP TO 2 ROWS
           FROM  scarr
           INTO  TABLE @carriers.
  ENDMETHOD.
  METHOD serialize_helper.
    count = lines( carriers ).
  ENDMETHOD.
  METHOD deserialize_helper.
    lines = count.
  ENDMETHOD.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    TYPES oref  TYPE REF TO object.
    DATA: dref1 TYPE REF TO oref,
          date  TYPE d,
          time  TYPE t,
          dref2 LIKE dref1.

    dref1    = NEW #( ).
    dref1->* = NEW c2( ).

    CALL TRANSFORMATION id
                        SOURCE xmldat = sy-datum
                               xmltim = sy-uzeit
                               ref  = dref1
                        RESULT XML DATA(xmlstr).
    EXPORT obj = xmlstr TO DATABASE demo_indx_blob(xm)
                        ID 'OBJECT'.

    cl_demo_output=>display_xml( xmlstr ).

    IMPORT obj = xmlstr FROM DATABASE demo_indx_blob(xm) ID 'OBJECT'.
    CALL TRANSFORMATION id
                        SOURCE XML xmlstr
                        RESULT xmldat = date
                               xmltim = time
                               ref = dref2.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
