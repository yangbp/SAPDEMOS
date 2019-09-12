REPORT pgl_upper_lower_case.

DATA source TYPE TABLE OF string.

source = VALUE #(
  ( `* Bad Example` )
  ( `` )
  ( `CLASS ClDemoCrReservationService DEFINITION ABSTRACT.` )
  ( `  PROTECTED SECTION.` )
  ( `    DATA carTab TYPE demoCrCarsTt.` )
  ( `    CONSTANTS basisRate TYPE demoCrBasisRate VALUE 20.` )
  ( `    METHODS makeReservation` )
  ( `      IMPORTING` )
  ( `        iCustomerId TYPE DemoCrCustomerId` )
  ( `        iDateFrom   TYPE DemoCrDateFrom` )
  ( `        iDateTo     TYPE DemoCrDateTo` )
  ( `      RAISING` )
  ( `        CxDemoCrNoCustomer` )
  ( `        CxDemoCrLock` )
  ( `        CxDemoCrReservation.` )
  ( `    METHODS computePrice` )
  ( `      IMPORTING` )
  ( `        iDateFrom TYPE DemoCrDateFrom` )
  ( `        iDateTo   TYPE DemocrDateTo` )
  ( `      RETURNING` )
  ( `        VALUE(rPrice) TYPE DemoCrPrice.` )
  ( `ENDCLASS.` )
  ( `` )
  ( `* Good Example` )
  ( `` )
  ( `CLASS cl_demo_cr_reservation_service DEFINITION ABSTRACT.` )
  ( `  PROTECTED SECTION.` )
  ( `    DATA car_tab TYPE demo_cr_cars_tt.` )
  ( `    CONSTANTS basis_rate TYPE demo_cr_basis_rate VALUE 20.` )
  ( `    METHODS make_reservation` )
  ( `      IMPORTING` )
  ( `        i_customer_id TYPE demo_cr_customer_id` )
  ( `        i_date_from   TYPE demo_cr_date_from` )
  ( `        i_date_to     TYPE demo_cr_date_to` )
  ( `      RAISING` )
  ( `        cx_demo_cr_no_customer` )
  ( `        cx_demo_cr_lock` )
  ( `        cx_demo_cr_reservation.` )
  ( `    METHODS compute_price` )
  ( `      IMPORTING` )
  ( `        i_date_from TYPE demo_cr_date_from` )
  ( `        i_date_to   TYPE demo_cr_date_to` )
  ( `      RETURNING` )
  ( `        VALUE(r_price) TYPE demo_cr_price.` )
  ( `ENDCLASS.` ) ).

INSERT REPORT 'PGL_CAMEL_CASE_STYLE' FROM source STATE 'A'.
INSERT REPORT 'PGL_CAMEL_CASE_STYLE' FROM source STATE 'I'.

IF sy-subrc <> 0.
  MESSAGE 'Error creating sample code' TYPE 'I' DISPLAY LIKE 'E'.
  LEAVE PROGRAM.
ENDIF.

EDITOR-CALL FOR REPORT 'PGL_CAMEL_CASE_STYLE'.
