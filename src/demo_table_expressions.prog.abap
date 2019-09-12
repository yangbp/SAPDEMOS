report DEMO_TABLE_EXPRESSIONS.

selection-screen begin of screen 100.
parameters: cntnt radiobutton group rad default 'X',
            compl radiobutton group rad.
selection-screen skip.
parameters filtr type c length 50.
selection-screen skip.
parameters: wsml  radiobutton group siz,
            wbig  radiobutton group siz default 'X'.
selection-screen skip.
parameters: kwsml radiobutton group kw default 'X',
            kwbig radiobutton group kw,
            kwnon radiobutton group kw.
selection-screen end of screen 100.

data index type i value 1.
data brkpt value ' '.
data ginfo value 'X'.

include DEMO_HTML_AUXILIARY.
define  D_PREPARE.
  clear: s1, s2, s3, s4, s5, s6, s7, s8,
         i1, i2, i3, i4, i5, elnf.
  str1tab = value #(
    ( c1 = 'AAA' c2 = 'ccc' c3 = 'x' s = `L.1` i = 90
      atab = value #( ( a1 = 'Aaa' a2 = `L.1.1` ) ( a1 = 'Aab' a2 = `L.1.2` ) ) )
    ( c1 = 'AAB' c2 = 'ccd' c3 = 'y' s = `L.2` i = 80
      atab = value #( ( a1 = 'Baa' a2 = `L.2.1` ) ( a1 = 'Bab' a2 = `L.2.2` ) ) )
    ( c1 = 'AAB' c2 = 'cdd' c3 = 'x' s = `L.3` i = 70
      atab = value #( ( a1 = 'Caa' a2 = `L.3.1` ) ( a1 = 'Cab' a2 = `L.3.2` ) ) )
    ( c1 = 'AAA' c2 = 'cdd' c3 = 'y' s = `L.4` i = 60 )
    ( c1 = 'AAB' c2 = 'cdd' c3 = 'y' s = `L.5` i = 50 )
  ).
  str1tabtab = value #( ( str1tab )
*    ( value #( ( c1 = 'XXX' c2 = 'xxx' c3 = 'x' s = `L.1` i = 900 atab = value #( ( ) ) )
*               ( c1 = 'XXY' c2 = 'xxy' c3 = 'y' s = `L.2` i = 800 ) ) )
*    ( value #( ( c1 = 'XXX' c2 = 'xxy' c3 = 'y' s = `L.1` i = 700 ) ) )
  ).
  itab = value #( ( 3 ) ( 4 ) ( 2 ) ( 1 ) ( 5 ) ).
  assign str1tab to <idxtab>.
  create object h.
end-of-definition.

class lcl definition deferred.
types  t_c1    type c length 1.
types  t_c3    type c length 3.
types  t_x     type x length 4.
types: begin of t_stra,
         a1 type t_c3,
         a2 type string,
       end of t_stra,
       t_stratab type standard table of t_stra with empty key
         with unique hashed key kh components a1 a2.
types: begin of t_str1,
         c1   type t_c3,
         c2   type t_c3,
         c3   type t_c1,
         s    type string,
         i    type i,
         atab type t_stratab,
       end of t_str1,
       t_str1tab type standard table of t_str1 with default key
         with non-unique sorted key ksc1c2 components c1 c2
         with non-unique sorted key ksic2  components i c2.
data: s1 type string, s2 type string, s3 type string, s4 type string,
      s5 type string, s6 type string, s7 type string, s8 type string,
      s type string, kn type string, cn1 type string, cn2 type string.
data: i1 type i, i2 type i, i3 type i,
      i4 type i, i5 type i, i type i.
data  str1tab type t_str1tab.
data  str1tabtab type standard table of t_str1tab with empty key.
data  itab type standard table of i.
data: str1 type t_str1.
data  h type ref to lcl.
data: elnf type ref to cx_sy_itab_line_not_found.
field-symbols: <idxtab> type index table.
field-symbols: <str1> type t_str1.
field-symbols: <stra> type t_stra.

class lcl definition.
 public section.
  methods show  importing in type any returning value(val) type string.
  methods set_sideeffect_table importing rtab type ref to data.
  methods sideeffect importing in  type any
                               idx type i default 1
                     returning value(val) type string.
  methods modify importing in type simple default 9
                 changing ch type any.
  data ref_tab type ref to data.
endclass.


**==========================================================
start-of-selection.
**
call selection-screen 100 starting at 10 10.
if sy-subrc <> 0.
  leave program.
endif.
**
if demo=>init(
  ttl = `ABAP Table Expressions as of Release 7.40`
  idx = index
  flt = filtr
  flags = |{ cntnt width = 1 }{ compl width = 1 }{ brkpt width = 1 }| &
          |{ wsml width = 1 }{ wbig width = 1 }| &
          |KW:{ kwsml width = 1 }{ kwbig width = 1 }{ kwnon width = 1 }|
  ) < 1.
  return.  " empty selection
endif.
**
do.  " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
**
demo=>top( ).
**==========================================================

""""" Comments in demo cases
* a normal full-line comment like this is suppressed
*+ a comment beginning with *+ is output as a headline
* an empty *+ comment can be used to generate vertical space:
*+
*. a comment beginning with *. is output as a normal comment (w/o the '.')


************************************************************
D_BEG `Basic Syntax for Table-Line Selection`.

*+ By index
s1 = h->show( in = str1tab[ lines( str1tab ) ] ).  "^ str1tab

*+ Free key
s2 = h->show( str1tab[ c2 = 'cdd' c3 = 'x' ] ).
*. Of multiple hits, the first is selected
s3 = h->show( str1tab[ c3 = 'x' ] ).

*+ Table key
s4 = h->show( str1tab[ key ksc1c2 c1 = 'AAB' c2 = 'ccd' ] ).
s5 = h->show( str1tab[ key ksc1c2
                       components c1 = 'AAA' c2 = 'cdd' ] ).

*+ Index w.r.t. table key
s6 = h->show( str1tab[ key ksic2 index 1 ] ).

D_SHOW: s1, s2, s3, s4, s5, s6. D_END.


************************************************************
D_BEG `Read Mode`.

". Prepare side effects on str1tab
h->set_sideeffect_table( ref #( str1tab ) ).  "^ str1tab

*+ Basic syntax means "ASSIGNING"

*. Parameter "in" witnesses the side effect on str1tab
s1 = h->sideeffect( in = str1tab[ 1 ] idx = 1 ).

*+ Value selection ("INTO")

*. Parameter "in" is protected against the side effect
s2 = h->sideeffect( in = value #( str1tab[ 2 ] ) idx = 2 ).

*+ Reference selection ("REFERENCE INTO")
s3 = h->show( ref #( str1tab[ 3 ] ) ).

*. Instead of '#', the operator may prescribe a type
s4 = h->show( value decfloat34( itab[ 1 ] ) ).  "^ itab
s5 = h->show( ref   t_str1( <idxtab>[ 2 ] ) ).

D_SHOW: s1, s2, s3, s4, s5. D_END.


************************************************************
D_BEG `Read Mode: Some Technicalities`.

*+ Extended syntax check warning for suspicious mode
h->show( value #( str1tab[ 1 ] ) ).  ". warning
h->show( itab[ 1 ] ).                ". warning
*. Warning can be suppressed by pragma
h->show( value #( str1tab[ 2 ] ) ) ##OPERATOR.
h->show( itab[ 2 ] )               ##OPERATOR.

*+

*+ Generic type requires "ASSIGNING" mode
s1 = h->show( <idxtab>[ 4 ] ).

*+

*+ Certain contexts choose "INTO" automatically
*. No need to use explicit "VALUE" operator

*. "Small" type in an "atomic" context
i1 = itab[ itab[ itab[ 1 ] ] ].  "^ itab
i2 = itab[ 2 ] + itab[ 3 ] * 100.

*. Explicit target variable
str1 = str1tab[ 2 ].  "^ str1tab

D_SHOW: s1, i1, i2, str1-s. D_END.


************************************************************
D_BEG `Chained Selection`.

*+ Chaining a component
s1 = str1tab[ 1 ]-c1.  "^ str1tab

*+ Chaining a selection in a nested table
s2 = h->show( str1tab[ 2 ]-atab[ 1 ] ).
*. Nested table, then component
s3 = h->show( str1tab[ 1 ]-atab[ 2 ]-a1 ).
*. Direct chaining (table of table)
s4 = h->show( str1tabtab[ 1 ][ 3 ] ).  "^ str1tabtab

*. Inline declaration (type inference)
data(stra_1) = str1tab[ s = `L.2` ]-atab[ 2 ].

*+

*+ VALUE / REF operator affects the final selection (only)
s5 = h->show( value #( str1tab[ 1 ]-atab[ 2 ] ) ) ##OPERATOR.
s6 = h->show( ref #( str1tab[ 1 ]-atab[ 1 ] ) ).
*. REF with chained component creates a final reference
s7 = h->show( ref #( str1tabtab[ 1 ][ 3 ]-atab[ 1 ]-a1 ) ).

D_SHOW: s1, s2, s3, s4, stra_1-a1, s5, s6, s7. D_END.


************************************************************
D_BEG `On the Left Hand Side`.

i = 2. s = `L.1.2`.

*+ L-value position, hence mode is "ASSIGNING"
itab[ i ] = itab[ i ] * 1001.  "^ itab
*. check effect
i1 = itab[ i ].

*+ LHS chaining is also possible
str1tab[ 1 ]-atab[ key kh a1 = 'Aab' a2 = s ]-a1 = 'xxx'.  "^ str1tab
*. check effect
s1 = h->show( str1tab[ 1 ]-atab[ key kh a1 = 'xxx' a2 = s ] ).

str1tab[ 4 ]-atab = value #( a1 = 'new' ( a2 = 'n1' )
                                        ( a2 = 'n2' ) ).
*. check effect
s2 = h->show( str1tab[ 4 ]-atab[ 2 ] ).

D_SHOW: i1, s1, s2. D_END.


************************************************************
D_BEG `Other L-Value Positions: ASSIGN, CHANGING`.

*+ As source of ASSIGN

*. Replaces "READ TABLE ASSIGNING"
assign str1tab[ 1 ]-atab[ 1 ] to <stra>.  "^ str1tab

*. Inline declaration
assign str1tab[ 3 ]-atab[ 2 ]-a1 to field-symbol(<a1>).

*. Failing selection in ASSIGN (nowhere else) sets SY-SUBRC
assign str1tab[ 1000 ]-atab[ 1 ]-a1 to <a1>.
assert sy-subrc = 4.

*. Component of selected table line
assign component 4 of structure str1tab[ 2 ] to field-symbol(<c4>).

*+

*+ As CHANGING parameter

h->modify( exporting in = '****'
           changing  ch = str1tab[ 2 ]-atab[ 1 ] ).
s1 = h->show( str1tab[ 2 ]-atab[ 1 ] ).

D_SHOW: <stra>-a1, <a1>, <c4>, s1. D_END.


************************************************************
D_BEG `Runtime Error "Line Not Found"`.

*+ Exception, not SY-SUBRC

try.
  h->show( value #( str1tab[ 1000 ]-atab[ 1 ]-a1 ) ).
catch cx_sy_itab_line_not_found into elnf.
  assert sy-subrc = 0.
  i1 = elnf->index.
endtry.

try.
  str1tab[ 1 ]-atab[ key kh a1 = '?!' a2 = `~` ]-a1 = 'X'.
catch cx_sy_itab_line_not_found into data(elnf2).
  assert sy-subrc = 0.
  s1 = elnf2->key_comp_values.
endtry.

D_SHOW: elnf, i1, elnf2, s1. D_END.


************************************************************
D_BEG `Built-In Functions`.

*+ Predicate function

if line_exists( str1tab[ key ksc1c2 c1 = 'AAB' c2 = 'ccd'
                       ]-atab[ a1 = 'Bab' ] ).
  s1 = `the line exists`.
endif.

s2 = boolc( line_exists( str1tab[ 2 ]-atab[ a1 = 'Baa' ] ) ).
s3 = boolc( line_exists( str1tab[ c2 = 'X' ]-atab[ a1 = '' ] ) ).

*+

*+ Index function

i1 = line_index( str1tab[ key ksc1c2 c1 = 'AAB' c2 = 'ccd' ] ).

*. Result 0 indicates "not found"
i2 = line_index( str1tab[ c2 = 'X' ] ).
i3 = line_index( str1tab[ 1 ]-atab[ key kh a1 = 'X' a2 = 'Y' ] ).

*. Result -1 indicates "found with hash key"
i4 = line_index( str1tab[ 1 ]-atab[ key kh a1 = 'Aab' a2 = `L.1.2` ] ).

D_SHOW: s1, s2, s3, i1, i2, i3, i4. D_END.


************************************************************
D_BEG `Dynamic Key Specification`.
kn = `KSC1C2`. cn1 = `C1`. cn2 = `C2`.

*. Partly dynamic
s1 = h->show( str1tab[ key (kn)  "^ str1tab
                       c1 = 'AAB' c2 = 'ccd' ] ).
s2 = h->show( str1tab[ key ksc1c2
                      (cn1) = 'AAA' (cn2) = 'cdd' ] ).

*. Fully dynamic
s3 = h->show( str1tab[ key (kn)
                       (cn1) = 'AAB' (cn2) = 'cdd' ] ).
s4 = h->show( str1tab[ key (kn) index 5 ] ).

D_SHOW: s1, s2, s3, s4. D_END.



**==========================================================
demo=>bottom( ginfo ).
if demo=>f_compl = 'X'.  exit.  endif.
**
enddo.  " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
**
RETURN.  " end-of-program
**==========================================================



class lcl implementation.

  method show.
    describe field in type data(t).
    if 'uv' cs t.
      data(i) = 1.
      do.
        assign component i of structure in to field-symbol(<c>).
        if sy-subrc <> 0.  return.  endif.
        val = |{ val }\{{ show( <c> ) }\}|.
        add 1 to i.
      enddo.
    elseif t = 'l'.
      assign in->* to field-symbol(<d>).
      val = |->{ show( <d> ) }|.
    elseif t = 'h'.
      field-symbols <t> type any table.  assign in to <t>.
      val = |[{ lines( <t> ) }]|.
    elseif 'ae' cs t.
      val = |{ conv decfloat34( in ) style = scale_preserving_scientific }|.
    else.
      val = |{ in }|.
    endif.
  endmethod.

  method set_sideeffect_table.
    ref_tab = rtab.
  endmethod.
  method sideeffect.
    field-symbols <tab> type index table.
    assign ref_tab->* to <tab>.
    assign component 1 of structure <tab>[ idx ] to field-symbol(<c>).
    <c> = '!!!'.
    val = show( in ).
  endmethod.

  method modify.
    assign component 1 of structure ch to field-symbol(<c>).
    <c> = in.
  endmethod.

endclass.
