*&---------------------------------------------------------------------*
*&  Include           DEMO_HTML_AUXILIARY
*&---------------------------------------------------------------------*

define D_BEG ##NO_BREAK .
  if demo=>f_restart = abap_false and
     demo=>matching( line = &1 cntnt = abap_false ) = abap_true.
    D_PREPARE.  " defined by includer: e.g. clear "display" variables
    demo=>begin_case( &1 ) ##NO_TEXT.
    if demo=>f_brkpt is not initial.
      break-point ##NO_BREAK.
      clear demo=>f_brkpt.
      demo=>f_in_dbg = abap_true.
    endif.
end-of-definition.
define D_SHOW.
    demo=>show( v_name = `&1` v_value = &1 ).
end-of-definition.
define D_END.
    demo=>end_case( ).
  endif.
  clear demo=>f_in_dbg.
end-of-definition.
define D_IF_IN_DEBUGGER.
  if demo=>f_in_dbg is not initial.
end-of-definition.
define D_PAR.
  check &1 = &1.
end-of-definition.
define D_SPC. ##NEEDED
end-of-definition.

* for defining multi-line strings (e.g. scripts)
field-symbols <_string> type any.
define _SB.  " multi-line string: begin
  clear &1.
  assign &1 to <_string>.
end-of-definition.
define _S.   " multi-line string: append line
  if <_string> is not initial.
    <_string> = |{ <_string> }\n{ &1 }|.
  else.
    <_string> = &1.
  endif.
end-of-definition.


class demo definition.
 public section.
  class-methods: init importing ttl type string
                                idx type i
                                flt type csequence
                                flags type string
                      returning value(found) type i,
                 top, bottom importing f_ginfo type abap_bool,
                 begin_case importing title type string,
                 end_case,
                 show importing v_name type string v_value type any,
                 mark_current,
                 matching importing line type string cntnt type abap_bool
                         returning value(result) type abap_bool,
                 popup_html importing wtitle type csequence.
  class-data:    filter type string, title type string,
                 head type string, foot type string, scale type string,
                 out type string, cpage type string.
  class-data     event_flag type abap_bool.
  class-data:    wsize like cl_abap_browser=>medium, fsize type string.
  class-data:    index_cur type i, index_min type i, index_max type i.
  class-data:    f_cntnt type abap_bool, f_compl type abap_bool,
                 f_brkpt type abap_bool, f_in_dbg type abap_bool, f_restart type abap_bool.
 private section.
  types: begin of t_kwtoken,
           row type i, col type i, len type i, rep type string,
         end of t_kwtoken.
  class-data:    kwtokens type sorted table of t_kwtoken with unique key row col,
                 kwchar   type c length 1.
  class-methods  mark_keywords importing mode type string.
  class-methods  show_itab importing v_name type string
                                     v_value type any table
                           returning value(html) type string.
  class-methods  unpack_structured_components changing components type abap_component_view_tab.
  class-methods  handle_sapevent
    for event sapevent of cl_abap_browser importing action.
  class-data     src type standard table of string.
  class-data:    var_index type i, min_col type i, max_len type i.
  constants      f_html like cl_abap_format=>e_html_text value cl_abap_format=>e_html_text.
  constants      demo_end_macros type string value ` D_END D_SHOW `.
  types:         begin of t_value,  val type string,  idx type i,  end of t_value.
  class-data     hvalues type hashed table of t_value with unique key val.
endclass.


class demo implementation.

  method init.
    constants: s_co type string value `color:#008060; font-size:smaller; font-style:oblique`,
               s_ix type string value `font-size:smaller; text-decoration:none`.
    data: tt type string, hr type string.
    data number type i.
    field-symbols <src> like line of src.
    index_min = idx. filter = to_upper( flt ).
    if flags+3(1) = 'X'.  wsize = cl_abap_browser=>medium. fsize = `small`.
    else.                 wsize = cl_abap_browser=>xlarge. fsize = `large`.  endif.
    f_cntnt = flags+0(1).  f_compl = flags+1(1).  f_brkpt = flags+2(1).
    if f_compl = abap_true. f_cntnt = abap_true. endif.
    f_restart = abap_false.
* HTML bits
    head =
    |<html>| &
      |<head>| &
        |<style type="text/css">\n| &
          | .bd \{ background-color:#fefefa; font-weight:bold; font-size:{ fsize }; font-family:Verdana,sans-serif \}\n| &
          | .bt \{ color:#c060a6; font-size:smaller \}| &
          | .ti \{ color:#002080; font-size:large \}| &
          | .sti\{ color:#002080; font-size:medium; font-style:italic \}| &
          | .re \{ color:#002080; font-size:smaller \}| &
          | .vl \{ width:40em; vertical-align:top \}\n| &
          | .ln \{ #color: 200080; text-decoration:underline \}| &
          | .co0\{ color:#888888 \}| &
          | .kc \{ color:#0a0af4 \}| &
          | .kb \{ color:#0a0ab0 \}| &
          | .co1\{ { s_co }; margin-top:-1px;  margin-bottom:-12px \}| &
          | .co \{ { s_co }; margin-top:-10px; margin-bottom:-12px \}| &
          | .sc \{ color:#aaaaaa; font-weight:normal \}\n| &
          | .ix1\{ { s_ix }; color:#0040e8 \}| &
          | .ix \{ { s_ix }; color:#002080 \}| &
          | .ft \{ color:#006040; font-size:small; font-style:oblique \}\n| &
          | .rt \{ font-size: smaller;font-weight:bold \}| &
          | .st \{ background-color:#f2f2e0; font-weight:bold; font-size:{ fsize }; font-family:Verdana,sans-serif \}\n| &
          | .spc\{ height:1px; position:relative; top:8px \}\n| &
        |</style>| &&
        |<script type="text/javascript">| &
        | /*defs-go-here*/\nfunction popup_val(hd, tx, wd) \{| &
        | while(1)\{ w = window.open('', wd, "height=400,width=300,resizable=1"); d = w.document;| &
        | if(!(d.getElementsByTagName("br")[0])) break; w.close(); \}| &
        | d.write('<html><title>' + hd + '</title><body style="background-color:#fbfde4; font-family:monospace"><br>');| &
        | d.write(tx); d.write('</body></html>'); return false; \}\n| &
        |</script> | &
      |</head>| &
      |<body class="bd">\n|.
    foot =
      |<br>\n</body>| &
    |</html>\n|.
    scale = repeat( val = `^^^^+^^^^|` occ = 6 ).
* load report source, count demo cases, construct contents page
    read report sy-repid into src.
    mark_keywords( substring_after( val = flags sub = 'KW:' ) ).
    cpage = |{ head }<div class="ti">{ ttl }</div><br>\n|.
    loop at src assigning <src>.
      if <src> = `RETURN.  " end-of-program`.  exit.  endif.
      if contains( val = <src> start = `D_PAR` ).
        tt = substring_before( val = substring_after( val = <src> sub = '`' ) sub = '`' ).
        if number = 0.
          cpage = |{ cpage }<div class="sti">{ tt }</div><br>\n|.
        else.
          cpage = |{ cpage }<br><div class="sti">{ tt }</div><br>\n|.
        endif.
        continue.
      endif.
      if contains( val = <src> start = `D_SPC` ).
        cpage = |{ cpage }<div class="spc"/>|.
        continue.
      endif.
      check contains( val = <src> start = `D_BEG ` ).
      check matching( line = <src> cntnt = abap_true ) = abap_true.
      add 1 to number.
      if f_compl = abap_false.  hr = |SAPEVENT:Goto{ number }|.
      else.                     hr = |#Case{ number }|.  endif.
      tt = substring_before( val = substring_after( val = <src> sub = '`' ) sub = '`' ).
      cpage = |{ cpage }<a class="ix" href="{ hr }">{ number }. { tt }</a><br>\n|.
    endloop.
    found = index_max = number.
    if index_max < 2.  f_cntnt = abap_false.  endif.
    if f_compl = abap_false.
      cpage = |{ cpage }<br>{ foot }|.
    endif.
  endmethod.

  method mark_keywords.
  data: tokens type standard table of stokesx,
        stmts  type standard table of sstmnt,
        stok   type string, etok type string.
    data(mv) = find( val = mode sub = 'X' ).
    check mv = 0 or mv = 1.
    kwchar = cl_abap_conv_in_ce=>uccpi( 7 ).
* find and remember keywords/operators; mark by special initial character in source
    scan abap-source src with analysis
      tokens into tokens statements into stmts.
    loop at stmts assigning field-symbol(<stm>) where type ca 'KMC'.
      call function 'RS_QUALIFY_ABAP_TOKENS_STR'
        exporting statement_type = <stm>-type
                  index_from     = <stm>-from
                  index_to       = <stm>-to
        changing  stokesx_tab    = tokens.
    endloop.
    loop at tokens assigning field-symbol(<tok>) where type ca 'cb'.
      read table src index <tok>-row assigning field-symbol(<src>).
      stok = substring( val = <src> off = <tok>-col len = <tok>-len1 ).
      check to_upper( stok ) = <tok>-str.
      if <tok>-type = 'b' and matches( val = <tok>-str regex = `[[:word:]]*` ).
        <tok>-type = 'c'.
      endif.
      replace section offset <tok>-col length 1 of <src> with kwchar.
      if mv = 0.
        stok = to_lower( stok ).
      else.
        stok = to_upper( stok ).
      endif.
      etok = escape( val = substring( val = stok off = 1 ) format = f_html ).
      insert value #( row = <tok>-row col = <tok>-col
        rep = |<span class="k{ <tok>-type }">{ escape( val = stok format = f_html ) }</span>|
        len = 1 + strlen( etok ) ) into table kwtokens.
    endloop.
  endmethod.

  method top.
    if f_cntnt = abap_true.
      if f_compl = abap_false.
        mark_current( ).
        out = cpage.
        popup_html( `Contents` ).
      else.
        out = cpage.
      endif.
    elseif f_compl = abap_true.
      out = head.
    endif.
    clear: index_cur, f_restart.
  endmethod.

  method begin_case.
    data  line type string.
    data: cl   type string, nl type string, id type string.
    data: text type string, textvar type string, tline type string, links type string.
    data: i    type i, curr_row type i.
    field-symbols <src> like line of src.
    demo=>title = title.
    var_index = 0.
*   buttons and title
    if f_compl = abap_false.
      out = head.  clear hvalues.
      if index_cur < index_max.
        out = |{ out }<a class="bt" href="SAPEVENT:Next">Next</a>&nbsp;&nbsp;|.
      endif.
      if index_cur > 1.
        out = |{ out }<a class="bt" href="SAPEVENT:Prev">Prev</a>&nbsp;&nbsp;|.
      endif.
      out   = |{ out }<a class="bt" href="SAPEVENT:Debug">Debug</a>&nbsp;&nbsp;| &
              |<a class="bt" href="SAPEVENT:Stop">Stop</a>|.
    endif.
    if index_max > 1.
      if f_compl = abap_false.
        out = |{ out }&nbsp;&nbsp;<a class="bt" href="SAPEVENT:Index">Index</a>|.
      endif.
      id = |{ index_cur }.&nbsp; |.
    endif.
    out = |{ out }<br><br>\n\n<a name="Case{ index_cur }">| &
          |<span class="ti">{ id }{ title }</span>| &
          |</a>\n<pre>|.
* find demo case in source code
    line = |D_BEG `{ title }`.|.
    read table src assigning <src> with key table_line = line.
    assert sy-subrc = 0.
    cl = 'co1'. nl = ''.
    loop at src assigning <src> from sy-tabix + 1.
      curr_row = sy-tabix.
      if textvar is not initial.
* multi-line string definition is open
        if contains( val = <src> regex = `^ *_(S|s) ` ).
* next line of multi-line string, beginnning with macro _S
          tline = substring_after( val = <src> regex = `_(S|s) ` ).
          i = find_any_of( val = tline sub = ```'` ) + 1.
          tline = substring( val = tline off = i ).
          i = find_any_of( val = tline sub = ```'` occ = -1 ).
          tline = substring( val = tline len = i ).
          if text is initial.  text = tline.
          else. text = |{ text }\n{ tline }|.  endif.
          continue.
        elseif contains( val = <src> start = `*` )
            or contains( val = <src> regex = `^ *\"` ).
          continue.
        else.
* end of multi-line string definition: output as separate text section
          out = |{ out }{ textvar } = | &
            |<table class="st"><tr style="position:relative;top:8px"><td><pre>| &
            |{ text }</pre></td></tr></table>|.
          clear: textvar, text.
          " process line after last line of multi-line string
        endif.
      endif.
      if contains( val = <src> start = `*+` ).
        if <src> = '*+'.
          nl = |\n|.
        else.
* comment line displayed as headline
          out = |{ out }</pre>\n<div class="{ cl }">| &
                |{ escape( val = substring_after( val = <src> sub = ` ` ) format = f_html ) }| &
                |</div>\n<pre>|.
          nl = ''.
        endif.
      elseif contains( val = <src> start = '*.' ).
* comment line displayed as normal comment line (grey)
        out = |{ out }{ nl }<span class="co0">*| &
              |{ escape( val = substring( val = <src> off = 2 ) format = f_html ) }</span>|.
        nl = |\n|.
      elseif contains( val = <src> regex = `^ *_(S|s)(B|b) ` ).
* start of multi-line string definition with macro _SB
        textvar = translate( val = substring_after( val = <src> regex = `_(S|s)(B|b) ` )
                             from = ` .` to = `` ).
      elseif not contains( val = <src> start = '*' ).
* program line
        i = nmax( val1 = 0 val2 = find_any_not_of( val = <src> sub = ` ` ) ).
        i = find_any_of( val = <src> sub = ` :,.` off = i ).
        if i > 0.
          line = | { to_upper( substring( val = <src> len = i ) ) } |.
          if contains( val = demo_end_macros sub = line ).
            exit.  " end of case reached
          endif.
        endif.
        i = find( val = <src> sub = `".` occ = -1 ).
        if i >= 0.
* end-of-line comment (grey)
          line =
                |{ escape( val = substring( val = <src> len = i ) format = f_html ) }| &
                |<span class="co0">"| &
                |{ escape( val = substring( val = <src> off = i + 2 ) format = f_html ) }</span>|.
        else.
          i = find( val = <src> sub = `"^` occ = -1 ).
          if i >= 0.
* list of variable names to link in this line
            links = to_upper( substring( val = <src> off = i + 2 ) ).
            line = escape( val = substring( val = <src> len = i - 1 ) format = f_html ).
          else.
            line = escape( val = <src> format = f_html ).
          endif.
        endif.
* highlight keywords/operators in line
        loop at kwtokens assigning field-symbol(<kwt>) where row = curr_row.
          data(fnd) = find_any_of( val = line sub = kwchar ).
          replace section offset fnd length <kwt>-len of line with <kwt>-rep.
        endloop.
* add links (for variables to display on click)
        if links is not initial.
          do 10 times.
            data(seg) = sy-index.
            try.
              data(lnam) = condense( segment( val = links sep = `,` index = seg ) ).
            catch cx_sy_strg_par_val.  exit.  endtry.
            data(npos) = find( val = line sub = lnam case = ' ' ).
            check npos >= 0.
            assign (lnam) to field-symbol(<var>).
            check sy-subrc = 0.
            data(nlen) = strlen( lnam ).
            data(lval) = show_itab( v_name = `` v_value = <var> ).
            replace all occurrences of `"` in lval with `&quot;`.
            read table hvalues with table key val = lval assigning field-symbol(<v>).
            if sy-subrc = 0.  i = <v>-idx.
            else.             i = lines( hvalues ).
              insert value #( val = lval idx = i ) into table hvalues.
            endif.
            replace section offset npos length nlen of line with
              |<span class="ln" onclick="popup_val('{ lnam }', val_{ i }, '_val_{ i }');">{
              substring( val = line off = npos len = nlen ) }</span>|.
          enddo.
          clear links.
        endif.
        out = |{ out }{ nl }{ line }|.
        cl = 'co'. nl = |\n|.
      endif.
    endloop.
  endmethod.

  method end_case.
    out = |{ out }</pre>|.
    if f_compl = abap_false.
      out = |{ out }{ foot }|.
      popup_html( title ).
    endif.
  endmethod.

  method bottom.
    if f_compl = abap_true.
      if f_ginfo = abap_false.
        out = |{ out }{ foot }|.
      else.
        out = |{ out }<br><br>\n\n<div class="ft">Generated by program { sy-repid }, | &
              |{ sy-datum date = iso } { sy-uzeit time = iso } | &
              |in system { sy-sysid }, { sy-host }</div>| &
              |{ foot }|.
      endif.
      popup_html( `ABAP Demonstration` ).
    endif.
    if f_restart = abap_false.
      index_min = 1.
      f_cntnt = abap_true.  " start over (with contents page)
    endif.
  endmethod.

  method show.
    data: q type c, t type c.
    data: s type string, d type string.
    data i type i.
    data e type ref to cx_root.
    if var_index = 0.
      out = |{ out }| &
            |</pre>\n| &
            |<div class="re">Results</div>\n| &
            |<pre>|.
      min_col = 100. max_len = 0.
    endif.
    if contains( val = v_name end = 'SCALE' ).
      out = |{ out }| &
            |{ repeat( val = ` ` occ = min_col ) }| &
            |<span class="sc">{ substring( val = scale len = max_len ) }</span>\n|.
    else.
      add 1 to var_index.
      describe field v_value type t.
      d = ` = `.
      case t.
        when 'g' or 'y'.  q = '`'.
        when 'C' or 'X'.  q = `'`.
        when 'r'.
          d = `: `.
          e ?= v_value.
          s = e->get_text( ).
        when 'h'.
          out = out && show_itab( v_name = v_name v_value = v_value ).
          return.
      endcase.
      if t <> 'r'.  s = |{ v_value }|.  endif.
      out = out && |{ escape( val = v_name format = f_html ) }{ d }| &
                   |<span class="vl">{ q }| &
*                   |{ escape( val = s format = f_html ) }|.
                   |{ replace( val = escape( val = s format = f_html )
                               sub = ` ` with = `&nbsp;` occ = 0 ) }| &
                   |{ q }</span>\n|.
      i = strlen( v_name ) + 3 + strlen( q ).
      if i < min_col.  min_col = i.  endif.
      if strlen( s ) > max_len.  max_len = strlen( s ).  endif.
    endif.
  endmethod.

  method show_itab.
    data table_descr type ref to cl_abap_tabledescr.
    data components  type abap_component_view_tab.
    data s type string.
    if v_value is initial.
      return.
    endif.
    table_descr ?= cl_abap_typedescr=>describe_by_data( v_value ).
    data(line_descr) = table_Descr->get_table_line_type( ).
    case line_descr->type_kind.
      when cl_abap_typedescr=>typekind_struct1 or cl_abap_typedescr=>typekind_struct2.
        components = cast cl_abap_structdescr( line_descr )->get_symbols( ).
        unpack_structured_components( changing components = components ).
      when cl_abap_typedescr=>typekind_table.
        table_descr ?= line_descr.
        components = value #( ( name = `` type = table_descr ) ).
      when others.
        components = value #( ( name = `` type = cast cl_abap_elemdescr( line_descr ) ) ).
    endcase.
    if v_name is not initial.  html = |{ v_name } = |.  endif.
    html = |{ html }<table border="1" class="rt">|.
    " Title row
    html = |{ html }<thead style="background-color:ddddfd">|.
    loop at components assigning field-symbol(<component>).
      html = |{ html }<th>{ <component>-name }</th>|.
    endloop.
    html = |{ html }</thead><tbody>|.
    " Data rows
    loop at v_value assigning field-symbol(<line>).
      html = |{ html }<tr>|.
      loop at components assigning <component>.
        if <component>-name is not initial.
          assign component <component>-name of structure <line> to field-symbol(<fs>).
        else.
          assign <line> to <fs>.
        endif.
        describe field <fs> type data(ft).
        if ft = 'h'.
          s = show_itab( v_name = `` v_value = <fs> ).
        else.
          s = replace( val = escape( val = <fs> format = f_html )
                       sub = ` ` with = `&nbsp;` occ = 0 ).
        endif.
        if s is initial.  s = `&nbsp;`.  endif.
        html = |{ html }<td>{ s }</td>|.
      endloop.
      html = |{ html }</tr>|.
    endloop.
    html = html && |</tbody></table>|.
  endmethod.

  method matching.
    if filter <> ''.
      check contains( val = to_upper( line ) sub = filter ).
    endif.
    add 1 to index_cur.
    check cntnt = abap_true or index_cur >= index_min.
    result = abap_true.
  endmethod.

  method mark_current.
    data p type i.
    find first occurrence of `<a class="ix1"` in cpage match offset p.
    if sy-subrc = 0.
      replace section offset p length 14 of cpage with `<a class="ix"`.
    endif.
    find first occurrence of |<a class="ix" href="SAPEVENT:Goto{ index_min }">|
      in cpage match offset p.
    if sy-subrc = 0.
      replace section offset p length 14 of cpage with `<a class="ix1" `.
    endif.
  endmethod.

  method popup_html.
    data win_title type cl_abap_browser=>title.
    set handler handle_sapevent.
    win_title = wtitle.
    set handler handle_sapevent.
    event_flag = abap_false.
    " insert definitions for on-click values
    data defs type string.
    loop at hvalues assigning field-symbol(<v>).
      defs = |{ defs }\nvar val_{ <v>-idx } = "{ <v>-val }";\n|.
    endloop.
    replace first occurrence of `/*defs-go-here*/` in out with |{ defs }|.
    cl_abap_browser=>show_html( html_string = out
                                title       = win_title
                                size        = wsize
                                format      = cl_abap_browser=>landscape
                                modal       = 'X'
                                buttons     = ' '
                               context_menu = 'X'
                                check_html  = ' ' ).
    if event_flag = abap_false. leave program. endif.
  endmethod.

  method handle_sapevent.
    index_min  = index_cur.
    f_cntnt    = abap_false.
    f_restart  = abap_true.
    event_flag = abap_true.
    case action(4).
      when 'Next'.  index_min = index_min + 1.  f_restart = abap_false.
      when 'Prev'.  index_min = index_min - 1.
      when 'Debu'.  f_brkpt = 'X'.
      when 'Inde'.  f_cntnt = 'X'.
      when 'Goto'.  index_min = substring_after( val = action sub = 'Goto' ).
      when 'Stop'.
        leave program.
      when others.
        exit.
    endcase.
*    submit (sy-repid) with index = index_min with cntnt = f_cntnt with brkpt = f_brkpt.
    cl_abap_browser=>close_browser( ).
  endmethod.

  method unpack_structured_components.
    " in: a list of components which can be structured
    " out: a list of components which are all elementary, subcomponents
    "      separated by '-'
  data struc like line of components.
  data index type i.

  data sub_struct_descr type ref to cl_abap_structdescr.
  data subcomponents type abap_component_symbol_tab.

  data subcomponent type line of abap_component_view_tab.

  do.
    loop at components into struc
      where type->type_kind = cl_abap_typedescr=>typekind_struct1
         or type->type_kind = cl_abap_typedescr=>typekind_struct2.
      index = sy-tabix.
      exit.
    endloop.
    if sy-subrc is not initial.
      return. " no structured components any more
    endif.

    delete components index index.

    sub_struct_descr ?= struc-type.
    subcomponents = sub_struct_descr->get_symbols( ).

    loop at subcomponents into subcomponent.
      subcomponent-name = |{ struc-name }-{ subcomponent-name }|.
      insert subcomponent into components index index.
      add 1 to index.
    endloop.

  enddo.
  endmethod.

endclass.
