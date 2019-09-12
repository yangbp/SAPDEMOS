REPORT demo_parallel_rfc.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: main,
                   callbback_meth IMPORTING p_task TYPE clike.
  PRIVATE SECTION.
    TYPES: BEGIN OF task_type,
           name TYPE string,
           dest TYPE string,
         END OF task_type.
    CLASS-DATA: task_list TYPE STANDARD TABLE OF task_type,
                task_wa   TYPE task_type,
                rcv_jobs  TYPE i,
                mess      TYPE c LENGTH 80.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: snd_jobs  TYPE i,
          exc_flag  TYPE i,
          indx      TYPE c LENGTH 4,
          name      TYPE c LENGTH 8.

    DATA(out) = cl_demo_output=>new( ).

    DO 10 TIMES.
      indx = sy-index.
      name = 'Task' && indx.
      CALL FUNCTION 'RFC_SYSTEM_INFO'
        STARTING NEW TASK name
        DESTINATION IN GROUP DEFAULT
        CALLING callbback_meth ON END OF TASK
        EXCEPTIONS
          system_failure        = 1 MESSAGE mess
          communication_failure = 2 MESSAGE mess
          resource_failure      = 3.
      CASE sy-subrc.
        WHEN 0.
          snd_jobs = snd_jobs + 1.
        WHEN 1 OR 2.
          out->write_text( mess ).
        WHEN 3.
          IF snd_jobs >= 1 AND
             exc_flag = 0.
             exc_flag = 1.
            WAIT UNTIL rcv_jobs >= snd_jobs
                 UP TO 5 SECONDS.
          ENDIF.
          IF sy-subrc = 0.
            exc_flag = 0.
          ELSE.
            out->display( 'Resource failure' ).
          ENDIF.
        WHEN OTHERS.
          out->display( 'Other error' ).
      ENDCASE.
    ENDDO.
    WAIT UNTIL rcv_jobs >= snd_jobs.
    out->display( task_list ).
  ENDMETHOD.
  METHOD callbback_meth.
    DATA info TYPE rfcsi.
    task_wa-name = p_task.
    rcv_jobs = rcv_jobs + 1.
    RECEIVE RESULTS FROM FUNCTION 'RFC_SYSTEM_INFO'
      IMPORTING
        rfcsi_export = info
      EXCEPTIONS
        system_failure        = 1 MESSAGE mess
        communication_failure = 2 MESSAGE mess.
    IF sy-subrc = 0.
      task_wa-dest = info-rfcdest.
    ELSE.
      task_wa-dest = mess.
    ENDIF.
    APPEND task_wa TO task_list.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
