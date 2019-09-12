REPORT demo_st_program.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( `Serialization` ).
    DATA source1(10) TYPE c VALUE 'Field1'.
    DATA source2(10) TYPE c VALUE 'Field2'.
    CALL TRANSFORMATION demo_st_program
      SOURCE root1 = source1
             root2 = source2
      RESULT XML DATA(xml).
    out->write_xml( xml ).

    out->next_section( `Deserialization` ).
    DATA result1 LIKE source1.
    DATA result2 LIKE source1.
    CALL TRANSFORMATION demo_st_program
      SOURCE XML xml
      RESULT root1 = result1
             root2 = result2.
    out->write_data( result1
      )->write_data( result2
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
