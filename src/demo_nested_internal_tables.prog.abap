REPORT demo_nested_internal_tables.

CLASS table_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF t_address,
        street TYPE c LENGTH 20,
        city   TYPE c LENGTH 20,
      END OF t_address,
      t_address_tab TYPE STANDARD TABLE
                    OF t_address
                    WITH NON-UNIQUE KEY city.
    CLASS-DATA:
      BEGIN OF company,
        name       TYPE c LENGTH 20,
        addresses  TYPE t_address_tab,
      END OF company,
      company_tab LIKE HASHED TABLE
                  OF   company
                  WITH UNIQUE KEY name,
      company_sorted_tab LIKE SORTED TABLE
                         OF   company
                         WITH UNIQUE KEY name.
ENDCLASS.

CLASS table_demo IMPLEMENTATION.
  METHOD main.
    DATA: address TYPE t_address,
          idx     TYPE sy-tabix,
          output  TYPE c LENGTH 80.
    FIELD-SYMBOLS <fs> LIKE company.

    DATA(out) = cl_demo_output=>new( ).

* Filling Internal Tables
    company_tab = VALUE #(
      ( name   = 'Racing Bikes Inc.'
        addresses = VALUE #( ( street = 'Fifth Avenue'
                               city   = 'New York' )
                             ( street = 'Second Street'
                               city   = 'Boston' ) ) )
      ( name   = 'Chocolatiers Suisse'
        addresses = VALUE #( ( street = 'Avenue des Forets'
                               city   = 'Geneve' )
                             ( street = 'Kleine Bachgasse'
                               city   = 'Basel' )
                             ( street = 'Piazza di Lago'
                               city   = 'Lugano' ) ) ) ).
* Reading Internal Tables
    READ TABLE company_tab
         WITH TABLE KEY name = 'Racing Bikes Inc.'
         ASSIGNING <fs>.
    out->write( |{ <fs>-name }| ).
    LOOP AT <fs>-addresses INTO address.
      CLEAR output.
      WRITE: sy-tabix       TO output+4(4),
             address-street TO output+8(20),
             address-city   TO output+28(20).
      out->write( output ).
    ENDLOOP.
* Modifying Internal Tables
    address-street = 'Rue des Montagnes'.
    address-city   = 'Geneve'.
    READ TABLE company_tab
         WITH TABLE KEY name = 'Chocolatiers Suisse'
         INTO company.
    READ TABLE company-addresses TRANSPORTING NO FIELDS
               WITH TABLE KEY city = address-city.
    idx = sy-tabix.
    MODIFY company-addresses FROM address INDEX idx.
    MODIFY TABLE company_tab FROM company.
* Moving and sorting Internal Tables
    company_sorted_tab = company_tab.
    LOOP AT company_sorted_tab INTO company.
      out->write( |{ company-name }| ).
      SORT company-addresses.
      LOOP AT company-addresses INTO address.
        CLEAR output.
        WRITE: sy-tabix       TO output+4(4),
               address-street TO output+8(20),
               address-city   TO output+28(20).
        out->write( output ).
      ENDLOOP.
    ENDLOOP.
* text output
    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  table_demo=>main( ).
