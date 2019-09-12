*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

CLASS memory DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS:
      get RETURNING value(value) TYPE decfloat34,
      set IMPORTING value TYPE decfloat34,
      add IMPORTING value TYPE decfloat34,
      sub IMPORTING value TYPE decfloat34.
  PRIVATE SECTION.
    DATA
      value TYPE decfloat34.
ENDCLASS.
