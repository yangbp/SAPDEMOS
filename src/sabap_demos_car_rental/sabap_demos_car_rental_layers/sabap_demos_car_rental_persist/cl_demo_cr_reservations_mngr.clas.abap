class CL_DEMO_CR_RESERVATIONS_MNGR definition
  public
  final
  create public .

public section.
*"* public components of class CL_DEMO_CR_RESERVATIONS_MNGR
*"* do not include other source files here!!!

  class-methods CREATE_RESERVATION
    importing
      !I_RESERVATION type DEMO_CR_SRESERVATION
    raising
      CX_DEMO_CR_RESERVATION .
  class-methods GET_RESERVATION_BY_ID
    importing
      !I_RESERVATION_ID type DEMO_CR_RESERVATION_ID
    returning
      value(R_RESERVATION) type DEMO_CR_SRESERVATION .
  class-methods DELETE_RESERVATION_BY_ID
    importing
      !I_RESERVATION_ID type DEMO_CR_RESERVATION_ID
    raising
      CX_DEMO_CR_RESERVATION .
  class-methods DELETE_ALL .
  class-methods GET_ALL
    returning
      value(R_RESERVATIONS) type DEMO_CR_RESERVATIONS_TT .
  class-methods LOCK
    importing
      !I_RESERVATION_ID type DEMO_CR_RESERVATION_ID
    raising
      CX_DEMO_CR_LOCK .
  class-methods UNLOCK
    importing
      !I_RESERVATION_ID type DEMO_CR_RESERVATION_ID .
  class-methods GET_RESERVATIONS_BY_CUST_ID
    importing
      !I_CUSTOMER_ID type DEMO_CR_CUSTOMER_ID
    returning
      value(R_RESERVATIONS) type DEMO_CR_RESERVATIONS_TT .
protected section.
private section.
*"* private components of class ZCL_MA_RESERVATIONS_MANAGER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_DEMO_CR_RESERVATIONS_MNGR IMPLEMENTATION.


METHOD CREATE_RESERVATION.

  DATA l_reservation_wa TYPE demo_cr_reservtn.

  MOVE-CORRESPONDING i_reservation TO l_reservation_wa.
  INSERT demo_cr_reservtn FROM l_reservation_wa.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_demo_cr_reservation
      EXPORTING textid = cx_demo_cr_reservation=>reservation_create.
  ENDIF.

ENDMETHOD.


METHOD DELETE_ALL.

  DELETE FROM demo_cr_reservtn. "#EC CI_NOWHERE

ENDMETHOD.


METHOD DELETE_RESERVATION_BY_ID.

  DELETE FROM demo_cr_reservtn
         WHERE reservation_id = i_reservation_id.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_demo_cr_reservation
      EXPORTING textid = cx_demo_cr_reservation=>reservation_delete.
  ENDIF.

ENDMETHOD.


METHOD GET_ALL.

  SELECT *
         FROM demo_cr_reservtn
         INTO CORRESPONDING FIELDS OF TABLE r_reservations.

ENDMETHOD.


METHOD GET_RESERVATIONS_BY_CUST_ID.

  SELECT *
         FROM demo_cr_reservtn
         INTO CORRESPONDING FIELDS OF TABLE r_reservations
         WHERE customer_id = i_customer_id.

ENDMETHOD.


METHOD GET_RESERVATION_BY_ID.

  SELECT SINGLE *
         FROM demo_cr_reservtn
         INTO CORRESPONDING FIELDS OF r_reservation
         WHERE reservation_id = i_reservation_id.

ENDMETHOD.


METHOD lock.

  IF i_reservation_id IS INITIAL.
    RETURN.
  ENDIF.

  CALL FUNCTION 'ENQUEUE_E_DEMO_CR_RESERV'
    EXPORTING
      mode_demo_cr_reservtn = 'X'
      reservation_id        = i_reservation_id
    EXCEPTIONS
      foreign_lock          = 1
      system_failure        = 2
      OTHERS                = 3.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_demo_cr_lock
      EXPORTING textid = cx_demo_cr_lock=>reservation_lock.
  ENDIF.

ENDMETHOD.


METHOD unlock.

  CALL FUNCTION 'DEQUEUE_E_DEMO_CR_RESERV'
    EXPORTING
      mode_demo_cr_reservtn = 'X'
      reservation_id        = i_reservation_id.

ENDMETHOD.
ENDCLASS.
