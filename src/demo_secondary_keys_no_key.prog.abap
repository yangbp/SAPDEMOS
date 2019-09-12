PROGRAM  demo_secondary_keys_no_key.

INCLUDE demo_scnd_keys.

CLASS measure IMPLEMENTATION.
  METHOD runtime.
    DATA: itab TYPE HASHED TABLE OF example_data=>struc
               WITH UNIQUE KEY idx.



    DATA:
          wa    TYPE example_data=>struc,
          t0    TYPE i,
          t1    TYPE i.

* Fill table
    example_data=>get_table(
      EXPORTING lines = lines
      IMPORTING table = itab ).

* Perform measurement
    GET RUN TIME FIELD t0.
    DO n_mess TIMES.
      READ TABLE itab INTO wa
        WITH KEY name = `Bugsy Siegel`
                 postal_code = 89033.
    ENDDO.
    GET RUN TIME FIELD t1.

* Calculate runtime
    rtime  = ( t1 - t0 ) / n_mess.
  ENDMETHOD.
ENDCLASS.
