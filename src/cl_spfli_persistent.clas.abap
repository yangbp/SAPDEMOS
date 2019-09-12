class CL_SPFLI_PERSISTENT definition
  public
  final
  create private

  global friends CB_SPFLI_PERSISTENT .

*"* public components of class CL_SPFLI_PERSISTENT
*"* do not include other source files here!!!
public section.

  interfaces IF_OS_STATE .

  methods GET_PERIOD
    returning
      value(RESULT) type S_PERIOD
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_AIRPFROM
    importing
      !I_AIRPFROM type S_FROMAIRP
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_AIRPTO
    importing
      !I_AIRPTO type S_TOAIRP
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_ARRTIME
    importing
      !I_ARRTIME type S_ARR_TIME
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_CITYFROM
    importing
      !I_CITYFROM type S_FROM_CIT
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_CITYTO
    importing
      !I_CITYTO type S_TO_CITY
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_COUNTRYFR
    importing
      !I_COUNTRYFR type LAND1
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_COUNTRYTO
    importing
      !I_COUNTRYTO type LAND1
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_DEPTIME
    importing
      !I_DEPTIME type S_DEP_TIME
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_DISTANCE
    importing
      !I_DISTANCE type S_DISTANCE
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_DISTID
    importing
      !I_DISTID type S_DISTID
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_FLTIME
    importing
      !I_FLTIME type S_FLTIME
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_FLTYPE
    importing
      !I_FLTYPE type S_FLTYPE
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods SET_PERIOD
    importing
      !I_PERIOD type S_PERIOD
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_AIRPFROM
    returning
      value(RESULT) type S_FROMAIRP
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_AIRPTO
    returning
      value(RESULT) type S_TOAIRP
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_ARRTIME
    returning
      value(RESULT) type S_ARR_TIME
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_CARRID
    returning
      value(RESULT) type S_CARR_ID
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_CITYFROM
    returning
      value(RESULT) type S_FROM_CIT
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_CITYTO
    returning
      value(RESULT) type S_TO_CITY
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_CONNID
    returning
      value(RESULT) type S_CONN_ID
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_COUNTRYFR
    returning
      value(RESULT) type LAND1
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_COUNTRYTO
    returning
      value(RESULT) type LAND1
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_DEPTIME
    returning
      value(RESULT) type S_DEP_TIME
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_DISTANCE
    returning
      value(RESULT) type S_DISTANCE
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_DISTID
    returning
      value(RESULT) type S_DISTID
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_FLTIME
    returning
      value(RESULT) type S_FLTIME
    raising
      CX_OS_OBJECT_NOT_FOUND .
  methods GET_FLTYPE
    returning
      value(RESULT) type S_FLTYPE
    raising
      CX_OS_OBJECT_NOT_FOUND .
  class CL_OS_SYSTEM definition load .
protected section.
*"* protected components of class CL_SPFLI_PERSISTENT
*"* do not include other source files here!!!

  data PERIOD type S_PERIOD .
  data FLTYPE type S_FLTYPE .
  data FLTIME type S_FLTIME .
  data DISTID type S_DISTID .
  data DISTANCE type S_DISTANCE .
  data DEPTIME type S_DEP_TIME .
  data COUNTRYTO type LAND1 .
  data COUNTRYFR type LAND1 .
  data CONNID type S_CONN_ID .
  data CITYTO type S_TO_CITY .
  data CITYFROM type S_FROM_CIT .
  data CARRID type S_CARR_ID .
  data ARRTIME type S_ARR_TIME .
  data AIRPTO type S_TOAIRP .
  data AIRPFROM type S_FROMAIRP .
private section.
*"* private components of class CL_SPFLI_PERSISTENT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_SPFLI_PERSISTENT IMPLEMENTATION.


method GET_AIRPFROM.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute AIRPFROM
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = AIRPFROM.

           " GET_AIRPFROM
endmethod.


method GET_AIRPTO.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute AIRPTO
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = AIRPTO.

           " GET_AIRPTO
endmethod.


method GET_ARRTIME.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute ARRTIME
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = ARRTIME.

           " GET_ARRTIME
endmethod.


method GET_CARRID.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute CARRID
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = CARRID.

           " GET_CARRID
endmethod.


method GET_CITYFROM.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute CITYFROM
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = CITYFROM.

           " GET_CITYFROM
endmethod.


method GET_CITYTO.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute CITYTO
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = CITYTO.

           " GET_CITYTO
endmethod.


method GET_CONNID.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute CONNID
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = CONNID.

           " GET_CONNID
endmethod.


method GET_COUNTRYFR.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute COUNTRYFR
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = COUNTRYFR.

           " GET_COUNTRYFR
endmethod.


method GET_COUNTRYTO.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute COUNTRYTO
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = COUNTRYTO.

           " GET_COUNTRYTO
endmethod.


method GET_DEPTIME.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute DEPTIME
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = DEPTIME.

           " GET_DEPTIME
endmethod.


method GET_DISTANCE.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute DISTANCE
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = DISTANCE.

           " GET_DISTANCE
endmethod.


method GET_DISTID.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute DISTID
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = DISTID.

           " GET_DISTID
endmethod.


method GET_FLTIME.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute FLTIME
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = FLTIME.

           " GET_FLTIME
endmethod.


method GET_FLTYPE.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute FLTYPE
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = FLTYPE.

           " GET_FLTYPE
endmethod.


method GET_PERIOD.
***BUILD 020501
     " returning RESULT
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Get Attribute PERIOD
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, result is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

* * Inform class agent and handle exceptions
  state_read_access.

  result = PERIOD.

           " GET_PERIOD
endmethod.


method IF_OS_STATE~GET .
***BUILD 010501
     " returning result type ref to object
************************************************************************
* Purpose        : Get state.
*
* Version        : 2.0
*
* Precondition   : --
*
* Postcondition  : --
*
* OO Exceptions  : --
*
* Implementation : --
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* GENERATED: Do not modify
************************************************************************

  data: STATE_OBJECT type ref to CL_OS_STATE.

  create object STATE_OBJECT.
  call method STATE_OBJECT->SET_STATE_FROM_OBJECT( ME ).
  result = STATE_OBJECT.

endmethod.


method IF_OS_STATE~HANDLE_EXCEPTION .
***BUILD 010501
     " importing I_EXCEPTION type ref to IF_OS_EXCEPTION_INFO optional
     " importing I_EX_OS type ref to CX_OS optional
************************************************************************
* Purpose        : Handles exceptions (os_exception) triggered from a
*                  service.
*
* Version        : 2.0
*
* Precondition   : --
*
* Postcondition  : --
*
* OO Exceptions  : --
*
* Implementation : Text ...
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* Modify if you like
************************************************************************

  if i_ex_os is not initial.
    raise exception i_ex_os.
  endif.

endmethod.


method IF_OS_STATE~INIT .
***BUILD 010501
************************************************************************
* Purpose        : Initialisation of the transient state partition.
*
* Version        : 2.0
*
* Precondition   : --
*
* Postcondition  : Transient state is initial.
*
* OO Exceptions  : --
*
* Implementation : Caution!: Avoid Throwing ACCESS Events.
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* Modify if you like
************************************************************************

endmethod.


method IF_OS_STATE~INVALIDATE .
***BUILD 010501
************************************************************************
* Purpose        : Do something before all persistent attributes are
*                  cleared.
*
* Version        : 2.0
*
* Precondition   : --
*
* Postcondition  : --
*
* OO Exceptions  : --
*
* Implementation : Whatever you like to do.
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* Modify if you like
************************************************************************

endmethod.


method IF_OS_STATE~SET .
***BUILD 010501
     " importing I_STATE type ref to object
************************************************************************
* Purpose        : Set state.
*
* Version        : 2.0
*
* Precondition   : --
*
* Postcondition  : --
*
* OO Exceptions  : --
*
* Implementation : --
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************
* GENERATED: Do not modify
************************************************************************

  data: STATE_OBJECT type ref to CL_OS_STATE.

  STATE_OBJECT ?= I_STATE.
  call method STATE_OBJECT->SET_OBJECT_FROM_STATE( ME ).

endmethod.


method SET_AIRPFROM.
***BUILD 020501
     " importing I_AIRPFROM
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute AIRPFROM
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_AIRPFROM <> AIRPFROM ).

    AIRPFROM = I_AIRPFROM.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_AIRPFROM <> AIRPFROM )

           " GET_AIRPFROM
endmethod.


method SET_AIRPTO.
***BUILD 020501
     " importing I_AIRPTO
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute AIRPTO
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_AIRPTO <> AIRPTO ).

    AIRPTO = I_AIRPTO.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_AIRPTO <> AIRPTO )

           " GET_AIRPTO
endmethod.


method SET_ARRTIME.
***BUILD 020501
     " importing I_ARRTIME
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute ARRTIME
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_ARRTIME <> ARRTIME ).

    ARRTIME = I_ARRTIME.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_ARRTIME <> ARRTIME )

           " GET_ARRTIME
endmethod.


method SET_CITYFROM.
***BUILD 020501
     " importing I_CITYFROM
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute CITYFROM
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_CITYFROM <> CITYFROM ).

    CITYFROM = I_CITYFROM.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_CITYFROM <> CITYFROM )

           " GET_CITYFROM
endmethod.


method SET_CITYTO.
***BUILD 020501
     " importing I_CITYTO
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute CITYTO
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_CITYTO <> CITYTO ).

    CITYTO = I_CITYTO.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_CITYTO <> CITYTO )

           " GET_CITYTO
endmethod.


method SET_COUNTRYFR.
***BUILD 020501
     " importing I_COUNTRYFR
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute COUNTRYFR
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_COUNTRYFR <> COUNTRYFR ).

    COUNTRYFR = I_COUNTRYFR.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_COUNTRYFR <> COUNTRYFR )

           " GET_COUNTRYFR
endmethod.


method SET_COUNTRYTO.
***BUILD 020501
     " importing I_COUNTRYTO
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute COUNTRYTO
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_COUNTRYTO <> COUNTRYTO ).

    COUNTRYTO = I_COUNTRYTO.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_COUNTRYTO <> COUNTRYTO )

           " GET_COUNTRYTO
endmethod.


method SET_DEPTIME.
***BUILD 020501
     " importing I_DEPTIME
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute DEPTIME
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_DEPTIME <> DEPTIME ).

    DEPTIME = I_DEPTIME.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_DEPTIME <> DEPTIME )

           " GET_DEPTIME
endmethod.


method SET_DISTANCE.
***BUILD 020501
     " importing I_DISTANCE
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute DISTANCE
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_DISTANCE <> DISTANCE ).

    DISTANCE = I_DISTANCE.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_DISTANCE <> DISTANCE )

           " GET_DISTANCE
endmethod.


method SET_DISTID.
***BUILD 020501
     " importing I_DISTID
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute DISTID
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_DISTID <> DISTID ).

    DISTID = I_DISTID.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_DISTID <> DISTID )

           " GET_DISTID
endmethod.


method SET_FLTIME.
***BUILD 020501
     " importing I_FLTIME
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute FLTIME
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_FLTIME <> FLTIME ).

    FLTIME = I_FLTIME.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_FLTIME <> FLTIME )

           " GET_FLTIME
endmethod.


method SET_FLTYPE.
***BUILD 020501
     " importing I_FLTYPE
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute FLTYPE
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_FLTYPE <> FLTYPE ).

    FLTYPE = I_FLTYPE.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_FLTYPE <> FLTYPE )

           " GET_FLTYPE
endmethod.


method SET_PERIOD.
***BUILD 020501
     " importing I_PERIOD
     " raising CX_OS_OBJECT_NOT_FOUND
************************************************************************
* Purpose        : Set attribute PERIOD
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : The object state is loaded, attribute is set
*
* OO Exceptions  : CX_OS_OBJECT_NOT_FOUND
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-14   : (BGR) Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
* - 2000-10-04   : (SB)  Namespaces
************************************************************************

* * Inform class agent and handle exceptions
  state_write_access.

  if ( I_PERIOD <> PERIOD ).

    PERIOD = I_PERIOD.

*   * Inform class agent and handle exceptions
    state_changed.

  endif. "( I_PERIOD <> PERIOD )

           " GET_PERIOD
endmethod.
ENDCLASS.
