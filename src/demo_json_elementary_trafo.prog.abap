REPORT demo_json_elementary_trafo.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(text) = `Hello JSON, I'm ABAP!`.
    DATA(out) = cl_demo_output=>new(
      )->write_data( text ).
    DATA(writer) = cl_sxml_string_writer=>create(
      type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE text = text
                           RESULT XML writer.
    DATA(json) = writer->get_output( ).
    out->write_json( json ).

    out->line( ).

    text = `{"TEXT":"Hello ABAP, I'm JSON!"}`.
    out->write_json( text ).
    CALL TRANSFORMATION id SOURCE XML text
                           RESULT text = text.
    out->write_data( text
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
