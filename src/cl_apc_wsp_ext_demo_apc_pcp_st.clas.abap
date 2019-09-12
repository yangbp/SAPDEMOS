class CL_APC_WSP_EXT_DEMO_APC_PCP_ST definition
  public
  inheriting from CL_APC_WSP_EXT_STATEFUL_PCP_B
  final
  create public .

public section.

  methods IF_APC_WSP_EXT_PCP~ON_ACCEPT
    redefinition .
  methods IF_APC_WSP_EXT_PCP~ON_CLOSE
    redefinition .
  methods IF_APC_WSP_EXT_PCP~ON_ERROR
    redefinition .
  methods IF_APC_WSP_EXT_PCP~ON_MESSAGE
    redefinition .
  methods IF_APC_WSP_EXT_PCP~ON_START
    redefinition .
protected section.
private section.

  aliases ON_ACCEPT
    for IF_APC_WSP_EXT_PCP~ON_ACCEPT .
  aliases ON_CLOSE
    for IF_APC_WSP_EXT_PCP~ON_CLOSE .
  aliases ON_ERROR
    for IF_APC_WSP_EXT_PCP~ON_ERROR .
  aliases ON_MESSAGE
    for IF_APC_WSP_EXT_PCP~ON_MESSAGE .
  aliases ON_START
    for IF_APC_WSP_EXT_PCP~ON_START .

  data APC_PCP type ref to CL_APC_WSP_EXT_DEMO_APC_PCP .
ENDCLASS.



CLASS CL_APC_WSP_EXT_DEMO_APC_PCP_ST IMPLEMENTATION.


METHOD if_apc_wsp_ext_pcp~on_accept.
  apc_pcp = NEW #( ).
  apc_pcp->on_accept( EXPORTING i_context_base = i_context_base IMPORTING e_connect_mode = e_connect_mode ).
ENDMETHOD.


METHOD if_apc_wsp_ext_pcp~on_close.
  IF apc_pcp IS NOT BOUND.
    "should not happen !
    MESSAGE 'Handler reference is initial!' TYPE 'X'.
  ENDIF.
  apc_pcp->on_close( i_reason = i_reason  i_code = i_code i_context_base = i_context_base ).
ENDMETHOD.


METHOD if_apc_wsp_ext_pcp~on_error.
  IF apc_pcp IS NOT BOUND.
    "should not happen !
    MESSAGE 'Handler reference is initial!' TYPE 'X'.
  ENDIF.
  apc_pcp->on_error( i_reason = i_reason  i_code = i_code i_context_base = i_context_base ).
ENDMETHOD.


METHOD if_apc_wsp_ext_pcp~on_message.
  IF apc_pcp IS NOT BOUND.
    "should not happen !
    MESSAGE 'Handler reference is initial!' TYPE 'X'.
  ENDIF.
  apc_pcp->on_message( i_message = i_message  i_message_manager = i_message_manager i_context = i_context ).
ENDMETHOD.


METHOD if_apc_wsp_ext_pcp~on_start.
  IF apc_pcp IS NOT BOUND.
    "should not happen !
    MESSAGE 'Handler reference is initial!' TYPE 'X'.
  ENDIF.
  apc_pcp->on_start( i_context = i_context i_message_manager = i_message_manager ).
ENDMETHOD.
ENDCLASS.
