*"* local class implementation for public class
*"* use this source file for the implementation part of
*"* local helper classes

CLASS lcl_test_reservation_cata DEFINITION DEFERRED.
CLASS cl_demo_cr_reservation_cata DEFINITION LOCAL FRIENDS lcl_test_reservation_cata.
