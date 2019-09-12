REPORT demo_create_shared_data_object.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: handle TYPE REF TO cl_demo_area,
          root   TYPE REF TO cl_demo_root,
          exc    TYPE REF TO cx_shm_attach_error.

    FIELD-SYMBOLS <fs> TYPE any.

    DATA(out) = cl_demo_output=>new( ).

    TRY.
        handle = cl_demo_area=>attach_for_write( ).
        CREATE OBJECT root AREA HANDLE handle.
        handle->set_root( root ).
        CREATE DATA root->dref AREA HANDLE handle TYPE string.
        ASSIGN root->dref->* TO <fs>.
        <fs> = `String in shared memory`.
        handle->detach_commit( ).
      CATCH cx_shm_attach_error INTO exc.
        out->display( exc->get_text( ) ).
        LEAVE PROGRAM.
      CATCH cx_shm_external_type.
        out->display( 'Type cannot be used' ).
        LEAVE PROGRAM.
    ENDTRY.

    TRY.
        handle = cl_demo_area=>attach_for_read( ).
        ASSIGN handle->root->dref->* TO <fs>.
        out->display( <fs> ).
        handle->detach( ).
      CATCH cx_shm_attach_error INTO exc.
        out->display( exc->get_text( ) ).
        LEAVE PROGRAM.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
