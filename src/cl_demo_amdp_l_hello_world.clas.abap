CLASS cl_demo_amdp_l_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    TYPES:
      BEGIN OF t_text,
        text TYPE string,
      END OF t_text,
      t_texts TYPE STANDARD TABLE OF t_text WITH  EMPTY KEY.

    METHODS hello_world
      IMPORTING VALUE(text)  TYPE string
      EXPORTING VALUE(texts) TYPE t_texts
      RAISING cx_amdp_error.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_DEMO_AMDP_L_HELLO_WORLD IMPLEMENTATION.


  METHOD hello_world BY DATABASE PROCEDURE
                     FOR HDB LANGUAGE LLANG
                     OPTIONS READ-ONLY.
* Hello World in L
    typedef Table <String "TEXT"> TT_TABLE;  /* Type definition
                                                repeated  */
    //Main entry point
    export Void main(String text, TT_TABLE & texts)
      { String hello = String("Hello ");
        texts."TEXT"[0z] = hello.append( text ).append( "!" ); }
  ENDMETHOD.
ENDCLASS.
