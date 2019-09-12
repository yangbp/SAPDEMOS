REPORT demo_checkpoints.

PARAMETERS: subkey TYPE c LENGTH 30 LOWER CASE DEFAULT sy-uname,
            field1 TYPE c LENGTH 10 LOWER CASE DEFAULT 'Field1',
            field2 TYPE i DEFAULT 0.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    LOG-POINT ID demo_checkpoint_group
                 SUBKEY subkey
                 FIELDS field1 field2.

    BREAK-POINT ID demo_checkpoint_group.

    ASSERT ID demo_checkpoint_group
              CONDITION field2 IS NOT INITIAL.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
