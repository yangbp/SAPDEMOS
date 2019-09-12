REPORT demo_uuids.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).
    DATA(system_uuid) = cl_uuid_factory=>create_system_uuid( ).
    TRY.
        DATA(uuid_x16) = system_uuid->create_uuid_x16( ).
        system_uuid->convert_uuid_x16( EXPORTING
                                         uuid = uuid_x16
                                       IMPORTING
                                         uuid_c22 = DATA(uuid_c22)
                                         uuid_c26 = DATA(uuid_c26)
                                         uuid_c32 = DATA(uuid_c32) ).
      CATCH cx_uuid_error.
        out->display( `Error when creating UUIDs` ).
        RETURN.
    ENDTRY.
    out->write_data( uuid_x16
      )->write_data( uuid_c22
      )->write_data( uuid_c26
      )->write_data( uuid_c32 )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
