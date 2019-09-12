REPORT demo_string_template_timezone.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES: BEGIN OF timezone,
             tzone    TYPE ttzz-tzone,
             descript TYPE ttzzt-descript,
             datetime TYPE string,
           END OF timezone.

    DATA: timezones TYPE TABLE OF timezone,
          tstamp    TYPE timestamp.

    FIELD-SYMBOLS <timezone> TYPE timezone.

    SELECT ttzz~tzone, ttzzt~descript
           FROM ttzz INNER JOIN ttzzt
           ON ttzz~tzone = ttzzt~tzone
           WHERE ttzz~tzone  NOT LIKE '%UTC%' AND
                 ttzzt~langu = 'E'
           INTO CORRESPONDING FIELDS OF TABLE @timezones
           ##too_many_itab_fields.

    GET TIME STAMP FIELD tstamp.

    LOOP AT timezones ASSIGNING <timezone>.
      <timezone>-datetime = |{ tstamp TIMEZONE  = <timezone>-tzone
                                      TIMESTAMP = USER }|.
    ENDLOOP.

    SORT timezones BY datetime.

    cl_demo_output=>new(
      )->begin_section( 'Timezones Around the World'
      )->display( timezones ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
