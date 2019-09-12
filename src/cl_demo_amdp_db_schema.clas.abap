CLASS cl_demo_amdp_db_schema DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb .

    TYPES:
      BEGIN OF schema,
        schema_name TYPE string,
      END OF schema,
      schemas TYPE TABLE OF schema WITH EMPTY KEY.

    CLASS-METHODS get_schemas_physical
      EXPORTING
                VALUE(schemas) TYPE schemas
      RAISING   cx_amdp_error.

    CLASS-METHODS get_schemas_logical
      EXPORTING
                VALUE(schemas) TYPE schemas
      RAISING   cx_amdp_error.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_DEMO_AMDP_DB_SCHEMA IMPLEMENTATION.


  METHOD get_schemas_logical BY DATABASE PROCEDURE
                             FOR HDB LANGUAGE SQLSCRIPT.
    schemas =
      select schema_name
        FROM "$ABAP.schema( DEMO_LOGICAL_DB_SCHEMA )"."SCHEMAS";
  ENDMETHOD.


  METHOD get_schemas_physical BY DATABASE PROCEDURE
                              FOR HDB LANGUAGE SQLSCRIPT.
    schemas =
      select schema_name
        FROM "SYS"."SCHEMAS";
  ENDMETHOD.
ENDCLASS.
