*&---------------------------------------------------------------------*
*& Subroutine pool  DEMO_OO_TRANSACTION                                *
*&                                                                     *
*&---------------------------------------------------------------------*

PROGRAM  demo_oo_transaction.

*

CLASS demo_class DEFINITION.
  PUBLIC SECTION.
    METHODS instance_method.
ENDCLASS.

*

CLASS demo_class IMPLEMENTATION.
  METHOD instance_method.
    cl_demo_output=>display( 'Instance method in local class' ).
  ENDMETHOD.
ENDCLASS.
