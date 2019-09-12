*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations


CLASS memory IMPLEMENTATION.
  METHOD get.
    value = me->value.
  ENDMETHOD.
  METHOD set.
    me->value = value.
  ENDMETHOD.
  METHOD add.
    me->value = me->value + value.
  ENDMETHOD.
  METHOD sub.
    me->value = me->value - value.
  ENDMETHOD.
ENDCLASS.
