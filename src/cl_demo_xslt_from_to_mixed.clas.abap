class CL_DEMO_XSLT_FROM_TO_MIXED definition
  public
  final
  create public .

public section.

  class-methods TO_CAMEL_CASE
    importing
      !IN type STRING
    returning
      value(OUT) type STRING .
  class-methods FROM_CAMEL_CASE
    importing
      !IN type STRING
    returning
      value(OUT) type STRING .
protected section.
private section.
ENDCLASS.



CLASS CL_DEMO_XSLT_FROM_TO_MIXED IMPLEMENTATION.


  method FROM_CAMEL_CASE.
    out = from_mixed( in ).
  endmethod.


  METHOD TO_CAMEL_CASE.
    out = to_mixed( in ).
  ENDMETHOD.
ENDCLASS.
