CLASS cl_demo_valid_json DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF example,
        text TYPE string,
        json TYPE string,
      END OF example.
    CLASS-DATA
      examples TYPE STANDARD TABLE OF example WITH DEFAULT KEY.
    CLASS-METHODS
      class_constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_DEMO_VALID_JSON IMPLEMENTATION.


  METHOD class_constructor.
    examples = VALUE #(
      ( text = `Character Data`
        json = `"abcde"` )
      ( text = `Numeric Data`
        json = `1.234e+5` )
      ( text = `Boolean Value`
        json = `true` )
      ( text = `Boolean Value`
        json = `false` )
      ( text = `Null Value`
        json = `null` )
      ( text = `Empty Array`
        json = `[ ]` )
      ( text = `Array`
        json = `[ "abcde", 1.234e+5, null ]` )
      ( text = `Nested Array`
        json = `[ [ "abcde", 1.234e+5, true ], ` &&
               `  [ "fghij", 1.234e+5, false ] ]` )
      ( text = `Empty Object`
        json = `{ }` )
      ( text = `Object`
        json = `{ "text":"abcde", "number":1.234e+5, "unknown":null }` )
      ( text = `Nested Objects`
        json = `{ "obj1":{ "text":"text", "number":1.234e+5, "flag":true},` &&
               `  "obj2":{ "text":"text", "number":1.234e+5, "flag":false}}` )
      ( text = `Object with different Components`
        json = `{ "Title":"abcde", ` &&
               `  "Date":"` && |{ sy-datlo DATE = ISO }| && `",` &&
               `  "Time":"` && |{ sy-timlo TIME = ISO }| && `",` &&
               `  "Amount":"111",` &&
               `  "Object":{` &&
               `    "Name":"fghij",` &&
               `    "Flag":true,` &&
               `    "Array1":["comp1","comp2","comp3"],` &&
               `    "Array2":[{"attr1":111,"attr2":222},[333,444]],` &&
               `    "Array3":[],` &&
               `    "Significance":null` &&
               `  } }` ) ).
  ENDMETHOD.
ENDCLASS.
