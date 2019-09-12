REPORT demo_structure_filling.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF name_type,
        title   TYPE string,
        prename TYPE string,
        surname TYPE string,
      END OF name_type,
      BEGIN OF street_type,
        name   TYPE string,
        number TYPE string,
      END OF street_type,
      BEGIN OF city_type,
        zipcode TYPE string,
        name    TYPE string,
      END OF city_type,
      BEGIN OF address_type,
        name   TYPE name_type,
        street TYPE street_type,
        city   TYPE city_type,
      END OF address_type.
    CLASS-METHODS main.
ENDCLASS.
CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: name TYPE name_type,
          addr TYPE address_type.
    name-title   = `Mr.`.
    name-prename = `Duncan`.
    name-surname = `Pea`.
    addr-name = name.
    addr-street-name   = `Vegetable Lane`.
    addr-street-number = `11`.
    addr-city-zipcode = `349875`.
    addr-city-name    = `Botanica`.

    DATA(address) =
      VALUE address_type(
        name-title   = `Mr.`
        name-prename = `Duncan`
        name-surname = `Pea`
        street = VALUE #( name   = `Vegetable Lane`
                          number = `11` )
        city   = VALUE #( zipcode = `349875`
                          name    = `Botanica` ) ).

    ASSERT address = addr.

    cl_demo_output=>new(
      )->write( address-name
      )->write( address-street
      )->write( address-city
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
