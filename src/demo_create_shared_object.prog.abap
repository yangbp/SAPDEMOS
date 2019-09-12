REPORT demo_create_shared_object.

CLASS class DEFINITION
            SHARED MEMORY ENABLED.
  PUBLIC SECTION.
    DATA attr TYPE string.
    METHODS set_attr IMPORTING text TYPE string.
ENDCLASS.

CLASS class IMPLEMENTATION.
  METHOD set_attr.
    attr = text.
  ENDMETHOD.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: handle TYPE REF TO cl_demo_area,
          root   TYPE REF TO cl_demo_root,
          exc    TYPE REF TO cx_shm_attach_error,
          oref   TYPE REF TO class.

    TRY.
        handle = cl_demo_area=>attach_for_write( ).
        CREATE OBJECT root AREA HANDLE handle.
        handle->set_root( root ).
        CREATE OBJECT root->oref AREA HANDLE handle TYPE class.
        oref ?= root->oref.
        oref->set_attr( `String in shared memory` ).
        CLEAR oref.
        handle->detach_commit( ).
      CATCH cx_shm_attach_error INTO exc.
        cl_demo_output=>display_text( exc->get_text( ) ).
        LEAVE PROGRAM.
    ENDTRY.

    TRY.
        handle = cl_demo_area=>attach_for_read( ).
        oref ?= handle->root->oref.
        cl_demo_output=>display_data( oref->attr ).
        CLEAR oref.
        handle->detach( ).
      CATCH cx_shm_attach_error INTO exc.
        cl_demo_output=>display_text( exc->get_text( ) ).
        LEAVE PROGRAM.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
