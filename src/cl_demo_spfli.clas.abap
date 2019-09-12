class CL_DEMO_SPFLI definition
  public
  final
  create public .

public section.

  class-data SPFLI_TAB type SPFLI_TAB .

  class-methods CLASS_CONSTRUCTOR .
  class-methods GET_SPFLI
    importing
      !CARRID type SPFLI-CARRID optional
    returning
      value(SPFLI) type SPFLI_TAB .
protected section.
private section.
ENDCLASS.



CLASS CL_DEMO_SPFLI IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
    SELECT * FROM spfli INTO TABLE @spfli_tab ORDER BY carrid, connid.
  endmethod.


  METHOD get_spfli.
    spfli =  spfli_tab.
    IF carrid IS NOT SUPPLIED.
      RETURN.
    ELSE.
      DELETE spfli WHERE carrid <> carrid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
