REPORT demo_nested_structure.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.
CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      BEGIN OF address,
        BEGIN OF name,
          title   TYPE string VALUE `Mr.`,
          prename TYPE string VALUE `Duncan`,
          surname TYPE string VALUE `Pea`,
        END OF name,
        BEGIN OF street,
          name   TYPE string VALUE `Vegetable Lane`,
          number TYPE string VALUE `11`,
        END OF street,
        BEGIN OF city,
          zipcode TYPE string VALUE `349875`,
          name    TYPE string VALUE `Botanica`,
        END OF city,
      END OF address.
    cl_demo_output=>new(
      )->write( address-name
      )->write( address-street
      )->write( address-city
      )->display( ).
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  demo=>main( ).
