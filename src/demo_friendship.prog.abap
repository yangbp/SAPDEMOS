REPORT demo_friendship.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_demo_friend.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    cl_demo_output=>display( cl_demo_friendship=>attr ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
