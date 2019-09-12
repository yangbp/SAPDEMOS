*&---------------------------------------------------------------------*
*&  Include           LDEMO_CR_CAR_RENTAL_SCREENSI01
*&---------------------------------------------------------------------*

MODULE cancel INPUT.
  screen_handler=>cancel( ).
ENDMODULE.

MODULE user_command_0100 INPUT.
  screen_handler=>user_command_0100( ).
ENDMODULE.

MODULE customers_mark INPUT.
  customer_table=>mark( ).
ENDMODULE.

MODULE reservations_mark INPUT.
  reservation_table=>mark( ).
ENDMODULE.
