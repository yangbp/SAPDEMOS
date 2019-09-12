*&---------------------------------------------------------------------*
*&  Include           LDEMO_CR_CAR_RENTAL_SCREENSO01
*&---------------------------------------------------------------------*

MODULE status_0100 OUTPUT.
  screen_handler=>status_0100( ).
ENDMODULE.

MODULE customers_change_tc_attr OUTPUT.
  customer_table=>change_tc_attr( ).
ENDMODULE.

MODULE reservations_change_tc_attr OUTPUT.
  reservation_table=>change_tc_attr( ).
ENDMODULE.
