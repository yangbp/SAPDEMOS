REPORT demo_exception_text.

DATA oref TYPE REF TO cx_sy_file_open_mode.

TRY.
    RAISE EXCEPTION TYPE cx_sy_file_open_mode
      EXPORTING
        textid   = cx_sy_file_open_mode=>read_only
        filename = `DUMMY.DAT`.
  CATCH cx_sy_file_open_mode INTO oref.
    cl_demo_output=>write( oref->get_text( ) ).
ENDTRY.

TRY.
    RAISE EXCEPTION TYPE cx_sy_file_open_mode
      EXPORTING
        textid   = cx_sy_file_open_mode=>not_open
        filename = `DUMMY.DAT`.
  CATCH cx_sy_file_open_mode INTO oref.
    cl_demo_output=>write( oref->get_text( ) ).
ENDTRY.

TRY.
    RAISE EXCEPTION TYPE cx_sy_file_open_mode
      EXPORTING
        textid   = cx_sy_file_open_mode=>incompatible_mode
        filename = `DUMMY.DAT`.
  CATCH cx_sy_file_open_mode INTO oref.
    cl_demo_output=>display( oref->get_text( ) ).
ENDTRY.
