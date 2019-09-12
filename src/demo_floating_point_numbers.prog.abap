REPORT demo_floating_point_numbers.

DATA ok_code       TYPE sy-ucomm.
DATA op1           TYPE c LENGTH 46.
DATA op2           TYPE c LENGTH 46.
DATA operator      TYPE c LENGTH 2.
DATA res_df34      TYPE c LENGTH 46.
DATA res_df16      TYPE c LENGTH 46.
DATA res_f         TYPE c LENGTH 46.
DATA exct_34       TYPE c LENGTH 4.
DATA exct_16       TYPE c LENGTH 4.
DATA continue_flag TYPE c LENGTH 1.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA: df34_1   TYPE decfloat34,
                df34_2   TYPE decfloat34.
    CLASS-METHODS: start,
                   main,
                   init_operator,
                   check_operand IMPORTING operand TYPE  c
                                 CHANGING  df34    TYPE  decfloat34,
                   handle_user_command IMPORTING ucomm TYPE sy-ucomm.
  PRIVATE SECTION.
    CLASS-DATA: operator_list TYPE vrm_values,
                df34_r        TYPE decfloat34,
                df16_r        TYPE decfloat16,
                f1            TYPE f,
                f2            TYPE f,
                f_r           TYPE f.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
*   Calculate decfloat34
    TRY.
        CASE operator.
          WHEN ' '.
            df34_r = EXACT #( + df34_1 ).
          WHEN '+'.
            df34_r = EXACT #( df34_1 + df34_2 ).
          WHEN '-'.
            df34_r = EXACT #( df34_1 - df34_2 ).
          WHEN '*'.
            df34_r = EXACT #( df34_1 * df34_2 ).
          WHEN '/'.
            df34_r = EXACT #( df34_1 / df34_2 ).
          WHEN '**'.
            df34_r = df34_1 ** df34_2.
            CLEAR exct_34.
        ENDCASE.
      CATCH cx_sy_conversion_overflow.
        res_df34 = text-ove.
        CLEAR exct_34.
      CATCH cx_sy_arithmetic_overflow.
        res_df34 = text-ove.
        CLEAR exct_34.
      CATCH cx_sy_conversion_rounding INTO DATA(exrnd).
        df34_r = exrnd->value.
        exct_34 = text-noe.
    ENDTRY.
    IF res_df34 = ' '.
      res_df34 = |{ df34_r ALIGN = LEFT STYLE = SCALE_PRESERVING }|.
      continue_flag = 'X'.
    ENDIF.
*   Calculate decfloat16
    TRY.
        CASE operator.
          WHEN ' '.
            df16_r = EXACT #( df34_1 ).
          WHEN '+'.
            df16_r = EXACT #( df34_1 + df34_2 ).
          WHEN '-'.
            df16_r = EXACT #( df34_1 - df34_2 ).
          WHEN '*'.
            df16_r = EXACT #( df34_1 * df34_2 ).
          WHEN '/'.
            df16_r = EXACT #( df34_1 / df34_2 ).
          WHEN '**'.
            df16_r = df34_1 ** df34_2.
            CLEAR exct_16.
        ENDCASE.
      CATCH cx_sy_conversion_overflow.
        res_df16 = text-ove.
        CLEAR exct_16.
      CATCH cx_sy_arithmetic_overflow.
        res_df16 = text-ove.
        CLEAR exct_16.
      CATCH cx_sy_conversion_rounding INTO exrnd.
        df16_r = exrnd->value.
        exct_16 = text-noe.
    ENDTRY.
    IF res_df16 = ' '.
      res_df16 = |{ df16_r ALIGN = LEFT STYLE = SCALE_PRESERVING }|.
    ENDIF.
*   Calculate type f
    TRY.
        f1 = df34_1.
        f2 = df34_2.
        CASE operator.
          WHEN ' '.
            f_r = f1.
          WHEN '+'.
            f_r = f1 + f2.
          WHEN '-'.
            f_r = f1 - f2.
          WHEN '*'.
            f_r = f1 * f2.
          WHEN '/'.
            f_r = f1 / f2.
          WHEN '**'.
            f_r = f1 ** f2.
        ENDCASE.
      CATCH cx_sy_conversion_overflow.
        res_f = text-ove.
      CATCH cx_sy_arithmetic_overflow.
        res_f = text-ove.
    ENDTRY.
    IF res_f = ' '.
      res_f = |{ f_r ALIGN = LEFT }|.
    ENDIF.
  ENDMETHOD.
  METHOD start.
    CALL SCREEN 100.
  ENDMETHOD.
  METHOD check_operand.
    DATA rc    TYPE i.
    CLEAR exct_34 .
    CLEAR exct_16 .
    TRY.
        cl_abap_decfloat=>read_decfloat34(
        EXPORTING  string = operand
        IMPORTING  value  = df34
                   rc     = rc  ).
        IF rc = cl_abap_decfloat=>parse_inexact OR
           rc = cl_abap_decfloat=>parse_underflow.
          exct_34 = text-noe.
          exct_16 = text-noe.
        ENDIF.
      CATCH cx_sy_conversion_overflow.
        MESSAGE e002(sy) WITH |OVERFLOW ({ operand } TOO LARGE)|.
      CATCH cx_abap_decfloat_parse_err INTO DATA(expe).
        MESSAGE expe TYPE 'E'.
    ENDTRY.
  ENDMETHOD.
  METHOD init_operator.
    DATA name  TYPE vrm_id VALUE 'OPERATOR'.
    IF operator_list IS INITIAL.
      operator_list = VALUE #( ( )
                               ( key  = '+'  text = '+' )
                               ( key  = '-'  text = '-' )
                               ( key  = '*'  text = '*' )
                               ( key  = '/'  text = '/' )
                               ( key  = '**' text = '**' ) ).
    ENDIF.
    CALL FUNCTION 'VRM_SET_VALUES'
      EXPORTING
        id     = name
        values = operator_list.
  ENDMETHOD.
  METHOD handle_user_command.
    CASE ucomm.
      WHEN 'EXECUTE'.
        CLEAR: res_df34, res_df16, res_f,
               continue_flag.
        IF exct_34 = ' '.
          exct_34 = text-yes.
        ENDIF.
        IF exct_16 = ' '.
          exct_16 = text-yes.
        ENDIF.
        demo=>main( ).
      WHEN 'REFRESH'.
        CLEAR: op1, op2, operator,
               res_df34, res_df16, res_f,
               exct_34, exct_16,
               continue_flag.
      WHEN 'CONTINUE'.
        op1 = |{ df34_r COUNTRY = '   ' }|.
        CLEAR: op2, operator,
               res_df34, res_df16, res_f,
               exct_34, exct_16,
               continue_flag.
      WHEN OTHERS.
        "do nothing
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>start( ).

MODULE status_100 OUTPUT.
  IF continue_flag = 'X'.
    SET PF-STATUS 'STATUS_100'.
  ELSE.
    SET PF-STATUS 'STATUS_100' EXCLUDING 'CONTINUE'.
  ENDIF.
  SET TITLEBAR  'TITLE_100'.
  demo=>init_operator( ).
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command_100 INPUT.
  demo=>handle_user_command( ok_code ).
  CLEAR ok_code.
ENDMODULE.

MODULE check_op1 INPUT.
  demo=>check_operand(
    EXPORTING operand = op1
    CHANGING  df34    = demo=>df34_1 ).
ENDMODULE.

MODULE check_op2 INPUT.
  demo=>check_operand(
    EXPORTING operand = op2
    CHANGING  df34    = demo=>df34_2 ).
ENDMODULE.
