class CA_SPFLI_PERSISTENT definition
  public
  inheriting from CB_SPFLI_PERSISTENT
  create private .

*"* public components of class CA_SPFLI_PERSISTENT
*"* do not include other source files here!!!
public section.

  class-data AGENT type ref to CA_SPFLI_PERSISTENT read-only .

  class-methods CLASS_CONSTRUCTOR .
protected section.
*"* protected components of class CA_SPFLI_PERSISTENT
*"* do not include other source files here!!!
private section.
*"* private components of class CA_SPFLI_PERSISTENT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CA_SPFLI_PERSISTENT IMPLEMENTATION.


method CLASS_CONSTRUCTOR .
***BUILD 010101
************************************************************************
* Purpose        : Initialize the 'class'.
*
* Version        : 2.0
*
* Precondition   : --
*
* Postcondition  : Singleton is created.
*
* OO Exceptions  : - None
*
* Implementation : --
*
************************************************************************
* Changelog:
* - 1999-09-20   : (OS) Initial Version
* - 2000-03-06   : (BGR) 2.0 modified REGISTER_CLASS_AGENT
************************************************************************
* GENERATED: Do not modify
************************************************************************

  create object AGENT.

  call method AGENT->REGISTER_CLASS_AGENT
    exporting
      I_CLASS_NAME          = 'CL_SPFLI_PERSISTENT'
      I_CLASS_AGENT_NAME    = 'CA_SPFLI_PERSISTENT'
      I_CLASS_GUID          = '5DA130651FE8D411918000A0C9C67802'
      I_CLASS_AGENT_GUID    = '63A130651FE8D411918000A0C9C67802'
      I_AGENT               = AGENT
      I_STORAGE_LOCATION    = 'SPFLI'
      I_CLASS_AGENT_VERSION = '2.0'.

* (Get Class GUID from VSEOCLASS)

           "CLASS_CONSTRUCTOR
endmethod.
ENDCLASS.
