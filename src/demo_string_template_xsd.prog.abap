REPORT demo_string_template_xsd.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA result TYPE TABLE OF string.

    DATA: i          TYPE i            VALUE -123,
          int8       TYPE int8         VALUE -123,
          p          TYPE p DECIMALS 2 VALUE `-1.23`,
          decfloat16 TYPE decfloat16   VALUE `123E+1`,
          decfloat34 TYPE decfloat34   VALUE `-3.140000E+02`,
          f          TYPE f            VALUE `-3.140000E+02`,
          c          TYPE c LENGTH 3   VALUE ` Hi`,
          string     TYPE string       VALUE ` Hello `,
          n          TYPE n LENGTH 6   VALUE `001234`,
          d          TYPE d            VALUE `20020204`,
          t          TYPE t            VALUE `201501`,
          x          TYPE x LENGTH 3   VALUE `ABCDEF`,
          xstring    TYPE xstring      VALUE `456789AB`.

    DEFINE write_template.
      APPEND |{ &1 width = 14  }| &&
             |{ &2 width = 30  }| &&
             |{ &2 xsd   = yes }| TO result.
    END-OF-DEFINITION.

    FORMAT FRAMES OFF.
    write_template `i`          i.
    write_template `int8`       int8.
    write_template `p`          p.
    write_template `decfloat16` decfloat16.
    write_template `decfloat34` decfloat34.
    write_template `f`          f.
    APPEND `` TO result.
    write_template `c`          c.
    write_template `string`     string.
    write_template `n`          n.
    write_template `d`          d.
    write_template `t`          t.
    APPEND `` TO result.
    write_template `x`          x.
    write_template `xstring`    xstring.
    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
