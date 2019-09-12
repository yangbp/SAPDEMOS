class CL_DEMO_CREATE_HTML definition
  public
  final
  create public .

public section.

  class-methods CLASS_CONSTRUCTOR .
  class-methods GET
    returning
      value(HTML) type STRING .
  PROTECTED SECTION.
private section.

  class-data:
    scarr_tab TYPE TABLE OF scarr .
ENDCLASS.



CLASS CL_DEMO_CREATE_HTML IMPLEMENTATION.


  METHOD CLASS_CONSTRUCTOR.
    SELECT * FROM scarr INTO TABLE scarr_tab.
  ENDMETHOD.


  METHOD get.
    CONSTANTS spc TYPE string VALUE `&nbsp;&nbsp;`.
    html = |<html><body><table border=1>|                      &&
           |<tr bgcolor="#D3D3D3">|                            &&
           |<td><b>{ spc }ID</b></td>|                         &&
           |<td><b>{ spc }Name</b></td>|                       &&
           |<td><b>{ spc }URL</b></td>|                        &&
           |</tr>|                                             &&
           REDUCE string(
             INIT h TYPE string
             FOR <scarr> IN scarr_tab
             NEXT h = h &&
               |<tr bgcolor="#F8F8FF">| &
               |<td width={ 10 * strlen( <scarr>-carrid )
                 } >{ spc }{ <scarr>-carrid }</td>| &
               |<td width={ 10 * strlen( <scarr>-carrname )
                 } >{ spc }{ <scarr>-carrname }</td>| &
               |<td width={ 10 * strlen( <scarr>-url )
                 } >{ spc }<a href="{ <scarr>-url
                 }">{ <scarr>-url }</a></td>| &
               |</tr>| )                                       &&
           |{ html }</table></body><html>|.
  ENDMETHOD.
ENDCLASS.
