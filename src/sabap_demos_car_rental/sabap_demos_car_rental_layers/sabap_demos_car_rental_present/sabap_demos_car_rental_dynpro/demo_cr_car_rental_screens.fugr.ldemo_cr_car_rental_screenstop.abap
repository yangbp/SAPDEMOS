FUNCTION-POOL demo_cr_car_rental_screens.

SELECTION-SCREEN BEGIN OF SCREEN 200 TITLE text-ccr.
PARAMETERS g_name TYPE demo_cr_customer_name OBLIGATORY LOWER CASE.
SELECTION-SCREEN END OF SCREEN 200.

SELECTION-SCREEN BEGIN OF SCREEN 300 TITLE text-rcr.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(20)  text-res.
SELECTION-SCREEN COMMENT 22(40) g_commnt.
SELECTION-SCREEN END OF LINE.
PARAMETERS: g_from  TYPE demo_cr_date_from OBLIGATORY DEFAULT sy-datum,
            g_to    TYPE demo_cr_date_to   OBLIGATORY DEFAULT sy-datum,
            g_cat   TYPE demo_cr_category  OBLIGATORY VALUE CHECK.
SELECTION-SCREEN END OF SCREEN 300.


TABLES demo_cr_scustomer_cntrl.

CONTROLS: customers    TYPE TABLEVIEW USING SCREEN 0100,
          reservations TYPE TABLEVIEW USING SCREEN 0100.

DATA g_ok_code TYPE sy-ucomm.

DATA: g_customers    TYPE TABLE OF demo_cr_scustomer_cntrl,
      g_customer     LIKE LINE OF  g_customers.

DATA: g_reservations TYPE TABLE OF demo_cr_sreservation_cntrl,
      g_reservation  LIKE LINE OF  g_reservations.


INCLUDE ldemo_cr_car_rental_screensd01.
