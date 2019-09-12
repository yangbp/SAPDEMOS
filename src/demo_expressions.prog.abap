*&---------------------------------------------------------------------*
*& Report  DEMO_EXPRESSIONS
*&---------------------------------------------------------------------*

report DEMO_EXPRESSIONS.

selection-screen begin of screen 100.
parameters: cntnt radiobutton group rad default 'X',
            compl radiobutton group rad.
selection-screen skip.
parameters filtr type c length 50.
selection-screen skip.
parameters: wsml  radiobutton group siz default 'X',
            wbig  radiobutton group siz.
selection-screen skip.
parameters: kwsml radiobutton group kw default 'X',
            kwbig radiobutton group kw,
            kwnon radiobutton group kw.
selection-screen end of screen 100.

data index type i value 1.
data brkpt value ' '.
data ginfo value 'X'.

define append_to.
  append &2 to &1.
end-of-definition.

define fill_struc_tab.
  clear struc_tab.
  _str-i = 1. _str-s = `x`.    append _str to struc_tab.
  _str-i = 2. _str-s = `x1`.   append _str to struc_tab.
  _str-i = 3. _str-s = `x10`.  append _str to struc_tab.
end-of-definition.

include DEMO_HTML_AUXILIARY.
define  D_PREPARE.
  clear: s1, s2, s3, s4, s5, s6, s_tab,
         i1, i2, i3, i4, i5, i_tab, f_tab,
         x1, x2, o, ex, ep, eb.
  append_to i_tab: 1, 2, 3, 4, 5, 6.
  append_to s_tab: `L1`, ` L2  `, `L3`.
  fill_struc_tab.
end-of-definition.

class lcl definition deferred.
class lcx definition deferred.
types  t_c1    type c length 1.
types  t_x     type x length 4.
types  t_s_tab type standard table of string with default key.
types  t_i_tab type standard table of i with default key.
types: begin of t_struc,
         s type string,
         i type i,
       end of t_struc.
data: s1 type string, s2 type string, s3 type string,
      s4 type string, s5 type string, s6 type string, s type string.
data  s_tab type t_s_tab.
data: i1 type i, i2 type i, i3 type i,
      i4 type i, i5 type i, i type i.
data  i_tab type t_i_tab.
data  f_tab type standard table of f with default key.
data  struc_tab type standard table of t_struc with default key
      with non-unique sorted key ksi components s i.
data  p1 type p length 8 decimals 2.
data: f1 type f, f2 type f.
data: df1 type decfloat34, df2 type decfloat34.
data: c1, c2.
data: x1 type t_x, x2 type t_x.
data: d1 type d, t1 type t.
data: str1 type t_struc, str2 type t_struc, _str type t_struc.
data: ts type tzonref-tstamps, tz type tzonref-tzone.
data: o type ref to lcl, ex type ref to lcx.
data: ep type ref to cx_sy_strg_par_val.
data: eb type ref to cx_sy_range_out_of_bounds.
data: ri type ref to i.
field-symbols: <f1>  type simple.
field-symbols: <f2>  type simple.
field-symbols: <f3>  type simple.
field-symbols: <f4>  type simple.
field-symbols: <fi>  type i.
field-symbols: <ff1> type f.
field-symbols: <ff2> type f.
field-symbols: <fs>   type string.
field-symbols: <ftab> type index table.
field-symbols: <str1> type t_struc.
field-symbols: <str2> type t_struc.

class lcl definition.
 public section.
  methods constructor importing in type i.
  class-methods mi    importing in type any returning value(val) type i.
  class-methods mi1   importing in type any returning value(val) type i.
  class-methods mf    importing in type any returning value(val) type f.
  class-methods ms    importing in type any returning value(val) type string.
  class-methods mc    importing in type any returning value(val) type t_c1.
  class-methods mx    importing in type any returning value(val) type xstring.
  class-methods md    importing in type any returning value(val) type d.
  class-methods mt    importing in type any returning value(val) type t.
  class-methods mtz   importing in type syst-zonlo returning value(val) type syst-zonlo.
  class-methods mst   importing in type t_s_tab returning value(val) type t_s_tab.
  class-methods mit   importing in type t_i_tab returning value(val) type t_i_tab.
  class-methods mstr  importing in type t_struc returning value(val) type t_struc.
  class-methods mref  importing in type i returning value(val) type ref to lcl.
  methods       imref importing in type i returning value(val) type ref to lcl.
  methods       imi   importing in type i returning value(val) type i.
  data          ai    type i.
endclass.

class lcx definition inheriting from cx_dynamic_check.
 public section.
  methods constructor importing in type i.
  data ai type i.
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
  ttl = `ABAP Extended Expressions as of Release 7.38`
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
D_PAR `Release 7.02`.
************************************************************


************************************************************
D_BEG `Expression Types`.

*+ Arithmetic Expression
i1 = 1 + abs( -2 ).
*+ Binary Expression
x1 = bit-set( 1 ) bit-or bit-set( 17 ).
*+ String Expression
s1 = `ab` && 'cd'.

D_SHOW: i1, x1, s1. D_END.


************************************************************
D_BEG `Computation in Logical Expressions`.

*+ Arithmetic
CHECK lcl=>mi( 1 ) + abs( -2 ) >= 3.
*+ Binary
CHECK lcl=>mx( x1 ) bit-or x2 <> bit-set( 4 ).
*+ String
CHECK `ab` && 'cd' CN 'xyz'.

D_END.


************************************************************
D_BEG `Logical Operator EQUIV`.

c1 = ' '.  i1 = 0.
CHECK  lcl=>mi( i1 ) > 0  EQUIV  c1 IS NOT INITIAL.

*+
c1 = 'X'.  i1 = 1.
CHECK  lcl=>mi( i1 ) > 0  EQUIV  c1 = 'X' AND i1 > 0.

D_END.


************************************************************
D_BEG `Expression-level Debugging`.

CHECK
  1 + lcl=>mi( 2 ) <> 7  AND  `ab` && `c` CA `b`
  AND ( `x` = lcl=>ms( `y` )  OR  s1 IS INITIAL )
  AND (  x1 = bit-set( 2 )
      OR lcl=>mi1( 2 * 3 ) MOD 2 <> 0 ).

D_END.


************************************************************
D_BEG `Computation in Method Parameters`.

*+ Arithmetic
i1 = lcl=>mi( in = 1 + lcl=>mf( '3.14' * abs( -2 ) ) ).
*+ Binary
x1 = lcl=>mx( bit-not bit-set( 17 + 4 ) ).
*+ String
s1 = lcl=>ms( `ab` && lcl=>ms( 'cd' && 'ef' ) ).

*+ Constructor
CREATE OBJECT o EXPORTING in = 1 + 2.

*+ Exception constructor
try.
  RAISE EXCEPTION TYPE lcx EXPORTING in = 3 + 4.
catch lcx into ex. endtry.

D_SHOW: i1, x1, s1, o->ai, ex->ai. D_END.


************************************************************
D_BEG `Chained Method Call`.

i1 = lcl=>mref( 1 + 2 )->imref( in = 3 )->imi( 4 ).

*+
CREATE OBJECT o EXPORTING in = lcl=>mref( 1 )->imi( 2 ).

*+ Chained attribute access
i2 = 4 + lcl=>mref( in = 1 + 2 )->imref( 3 )->ai.

D_SHOW: i1, o->ai, i2. D_END.

D_SPC.

************************************************************
D_BEG `Computation in Numeric Input Positions`.

DO lcl=>mi( 6 - 4 ) / 5 TIMES.  ADD 1 TO i1.  ENDDO.

*+
s1 = `abcdefghijklmn`.
SHIFT s1 LEFT BY 1 + 2 PLACES.

*+ SECTION OFFSET ... LENGTH ...
REPLACE SECTION OFFSET 2 + 2 LENGTH 7 - 4 OF s1 WITH 'XYZ'.

*+
*. now s1 = `defgXYZklmn`
FIND `Zk` IN SECTION OFFSET 8 / 4 LENGTH 3 + 3 OF s1 MATCH OFFSET i2.

*+ SET/GET BIT
SET BIT 10 + 6 OF x1 TO 1 - lcl=>mi( 0 ).
GET BIT 6 + 10 OF x1 INTO i3.

D_SHOW: i1, s1, i2, x1, i3. D_END.


************************************************************
D_BEG `Method Call in Input Positions`.

CONCATENATE LINES OF lcl=>mst( s_tab ) INTO s1.  "^ s_tab

*+
s2 = s1.
CLEAR s2 WITH lcl=>mc( 'x' ).

*+
MOVE-CORRESPONDING lcl=>mstr( str1 ) TO str2.

*+
CONVERT DATE lcl=>md( sy-datum ) TIME lcl=>mt( sy-uzeit )
        INTO TIME STAMP ts TIME ZONE lcl=>mtz( sy-zonlo ).

*+ SUBKEY, FIELDS evaluated only if checkpoint group is active (and assertion fails):
ASSERT ID abap_docu_demos SUBKEY `K` && i1
  FIELDS lcl=>ms( s1 && `x` ) lcl=>mi( i2 ) lcl=>mt( sy-uzeit )
  CONDITION 1 + lcl=>mi( 2 ) > 0.

*+
LOG-POINT ID abap_docu_demos SUBKEY lcl=>ms( `K` && i1 )
  FIELDS lcl=>mi( i2 + 1 ) lcl=>mt( sy-uzeit ).

D_SHOW: s1, s2, ts. D_END.


************************************************************
D_BEG `Method Call in Input Positions of Table Operations`.

READ TABLE i_tab FROM lcl=>mi1( 2 ) INTO i1.  "^ i_tab
READ TABLE i_tab WITH KEY table_line = lcl=>mi1( 3 ) INTO i2.

*+
DELETE TABLE i_tab FROM lcl=>mi1( 4 ).
DELETE TABLE i_tab WITH TABLE KEY table_line = lcl=>mi1( 5 ).

*+
APPEND lcl=>mi( 1 + 2 ) TO i_tab.
APPEND LINES OF lcl=>mit( i_tab ) FROM 4 TO i_tab.

*+
INSERT lcl=>mi( 1 + 3 ) INTO i_tab INDEX 1.
INSERT LINES OF lcl=>mit( i_tab ) TO 3 INTO i_tab INDEX 2.

*+
MODIFY i_tab FROM lcl=>mi( 5 ) INDEX 2 ASSIGNING <fi>.
COLLECT lcl=>mi( 6 ) INTO i_tab REFERENCE INTO ri.

D_SHOW: i1, i2, <fi>, ri->*. D_END.


************************************************************
D_BEG `Computation in Index Positions of Table Operations`.

READ TABLE i_tab INTO i1 INDEX 12 - lcl=>mi( 4 - 3 ).  "^ i_tab

*+ FROM ... TO ...
LOOP AT i_tab INTO i FROM i1 + 1 TO i1 + 2.  ADD i TO i2.  ENDLOOP.

APPEND LINES OF i_tab FROM 3 - 1 TO lcl=>mi( 2 ) - 17 TO i_tab.

INSERT LINES OF i_tab FROM 1 + 2 TO 2 + 3 INTO i_tab INDEX  3 + 4.

*+ INDEX
INSERT 70 INTO i_tab INDEX sqrt( 16 ) - 1 ASSIGNING <fi>.

MODIFY i_tab FROM 80 INDEX 4 + 4 REFERENCE INTO ri.

DELETE i_tab INDEX 8 / 4.

DELETE i_tab FROM 1 + 2 TO 7 - 3.

D_SHOW: i1, i2, <fi>, ri->*. D_END.


************************************************************
D_BEG `Computation in Character Input Positions`.

FIND `b` && `c` IN lcl=>ms( `ab` ) && `cde` MATCH OFFSET i1.

*+
s1 = `abcde`.
REPLACE `b` && `c` IN s1 WITH lcl=>ms( `X` ) && `YZ`.

*+
s2 = s1.
SHIFT s2 LEFT DELETING LEADING substring( val = s1 len = 1 ).

s3 = s2.
SHIFT s3 LEFT UP TO `Z` && `d`.

*+
SPLIT `123` && s3 AT `3` && `Z` INTO s s4.

*+
s5 = s4.
TRANSLATE s5 USING `dDe` && `EfF`.

D_SHOW: i1, s1, s2, s3, s4, s5. D_END.


************************************************************
D_BEG `String Expressions: && Operator`.

s1 = `abc` && `def`.

*+ C fields have no trailing blanks
s2 = `abc ` && 'def  ' && 'ghi' && '  jkl'.

D_SHOW: s1, s2, demo=>scale. D_END.

D_SPC.

************************************************************
D_BEG `String Templates`.

s1 = |A value: { sqrt( 9 ) / 2 }. Another value: { lcl=>mi( 2 ) }.|.

*+ Escape sequences
s2 = |Linebreak:\n. Tab: \t. Reserved: \\, \{, \}.|.

*+ Whitespace and comments
s3 = |line 1;\n| &  " the 1st line
*. note: only 2 significant spaces in next line
     |  line{ 1 + 1 }| &
*. note: no '\n' in previous line
     | (still line { 1 + 1 });\n| &
     |    line { 1 + 2 };|.

D_SHOW: s1, s2, s3. D_END.


************************************************************
D_BEG `Default Formatting in String Templates`.

i1 = 12.  p1 = '100.50'.
s1 = |[{ i1 }] [{ - i1 }] [{ p1 }] [{ - p1 }]|.

*+
f1 = '6.25E-02'.  f2 = sqrt( 2 ).
s2 = |[{ f1 }] [{ - f2 }]|.

*+
df1 = 3 / 2.  df2 = 2 / 3.
s3 = |[{ df1 }] [{ - df1 }] [{ df2 }]|.

*+
s4 = |[{ bit-set( -14 ) }] [{ sy-datum }] [{ sy-uzeit }]|.

D_SHOW: s1, s2, s3, s4. D_END.


************************************************************
D_BEG `Width, Alignment, Padding, Zero, Case`.

clear: i1, f1.
s1 = |[{ 12 width = 5 align = left }]| &
     |[{ 12 width = 5 align = center }]| &
     |[{ 12 width = 5 align = (cl_abap_format=>a_RIGHT) }]| &
     |[{ i1 width = 5 zero = no }]| &
     |[{ i1 width = 5 zero = yes }]|.

*+
s2 = |[{ 12 width = 5 align = left pad = '.' }]| &
     |[{ 12 width = 5 align = center pad = '.' }]| &
     |[{ 12 width = 5 align = right pad = '_' }]| &
     |[{ f1 width = 5 pad = '_' zero = no }]| &
     |[{ f1 width = 5 pad = '_' zero = yes }]|.

*+
x1 = bit-set( -30 ).
s3 = |[{ x1 }] [{ x1 case = lower }]|.

D_SHOW: s1, s2, s3. D_END.


************************************************************
D_BEG `Sign, Decimals, Exponent, Currency, Number, Style`.

i1 = 12.  p1 = '100.50'.  f1 = '0.75'.
*+ Sign position
s1 = |Left: [{ f1 sign = left  }] [{ f1 sign = leftplus  }] [{ f1 sign = leftspace  }]| &
  |  Right: [{ i1 sign = right }] [{ i1 sign = rightplus }] [{ i1 sign = rightspace }]|.

*+ Decimals
s2 = |[{ i1 decimals = 1 }] [{ p1 decimals = 1 }] [{ f1 decimals = 1 exponent = -3 }]|.

*+ Currency
s3 = |[{ i1 currency = 'EUR' }] [{ p1 / 20 currency = 'EUR' }]|.

*+ Decimal separators
i1 = 123456789. f1 = '1234.0625'.
s4 = |[{ i1 number = raw }] [{ i1 number = user }]| &
    | [{ f1 number = raw }] [{ f1 number = (cl_abap_format=>n_USER) }]|.

*+ Style (as in WRITE)
df1 = '-2.345'.
s5 = |[{ df1 style = simple }] [{ df1 style = scientific  }]| &
    | [{ df1 style = sign_as_postfix  }]|.

D_SHOW: s1, s2, s3, s4, s5. D_END.


************************************************************
D_BEG `Date, Time, Timestamp, Timezone`.

*+ Date
d1 = sy-datum.
s1 = |{ d1 date = raw } { d1 date = iso } { d1 date = user }|.

*+ Time
t1 = sy-uzeit.
s2 = |{ t1 time = raw } { t1 time = (cl_abap_format=>t_ISO) }|.

*+ Timestamp
get time stamp field ts. tz = 'UTC+1'.
s3 = |{ ts timezone = tz timestamp = space }\n| &
    | { ts timezone = tz timestamp = iso }\n| &
    | { ts timezone = tz timestamp = environment }|.

D_SHOW: s1, s2, s3. D_END.


************************************************************
* SP4:
D_BEG `Country vs. User vs. Environment`.

d1 = sy-datum. f1 = '12345.75'. p1 = '1234567.89'.

*+ Using an explicit country
s1 = |{ d1 country = 'US ' } { f1 country = 'US ' } { p1 country = 'US ' }\n | &
     |{ d1 country = 'DE ' } { f1 country = 'DE ' } { p1 country = 'DE ' }|.

*+ Using the environment settings (SET COUNTRY)
set country 'US '.
s2 = |{ d1 date = environment } { f1 number = environment } { p1 number = environment }\n | &
     |{ d1 date = user        } { f1 number = user        } { p1 number = user        }|.
set country 'DE '.
s3 = |{ d1 date = environment } { f1 number = environment } { p1 number = environment }\n | &
     |{ d1 date = user        } { f1 number = user        } { p1 number = user        }|.

D_SHOW: s1, s2, s3. D_END.
set country '   '.

D_SPC.

************************************************************
D_BEG `SUBSTRING`.

*+ Extraction by offset & length
s1 = substring( val = `abcdefgh` off = 2 len = 3 ).

*+ Order of function parameters is free
s2 = substring( off = 2 val = `abcdefgh` ).

*+ Nested computations
s3 = substring( val = `ab` && `cdefgh` len = 1 + 2 ).

*+ Out-of-bounds exception
try.
 s = substring( val = `abcd` off = 5 ).
catch cx_sy_range_out_of_bounds into eb. endtry.

D_SHOW: s1, s2, s3, eb. D_END.


************************************************************
D_BEG `SUBSTRING_AFTER( SUB )`.

*+ SUBSTRING_AFTER excludes the search string from the result
s1 = substring_after( val = `abcdef` sub = `cd` ).

s2 = substring_after( val = `abcdefgh` sub = `c` && `d` len = 1 + 2 ).

s3 = substring_after( val = `bcabcabcXabc` sub = `bc` occ = 1 + 2 ).

*+ Negative OCC(urrence) counts from end of string
s4 = substring_after( val = `bcabcabcXabc` sub = `bc` occ = -3 ).

s5 = substring_after( val = `bcabcabcXabc` sub = `bc` occ = -3 len = 4 ).

*+
try.
 s = substring_after( val = `abcde` sub = `bc` len = 3 ).
catch cx_sy_range_out_of_bounds into eb. endtry.

D_SHOW: s1, s2, s3, s4, s5, eb. D_END.


************************************************************
D_BEG `SUBSTRING_FROM( SUB )`.

*+ SUBSTRING_FROM includes the search string in the result
s1 = substring_from( val = `abcdef` sub = `cd` ).

s2 = substring_from( val = `abcdefgh` sub = `cd` len = 3 ).

s3 = substring_from( val = `bcabcXabc` sub = `bc` occ = 2 ).

*+ Negative OCC(urrence) counts from end of string
s4 = substring_from( val = `bcabcabcXabc` sub = `bc` occ = -3 ).

D_SHOW: s1, s2, s3, s4. D_END.


************************************************************
D_BEG `SUBSTRING_AFTER/FROM( REGEX ) / MATCH`.

*+ SUBSTRING_AFTER
s1 = substring_after( val = `XaabYabZ` regex = `a*` && `b` ).

s2 = substring_after( val = `XaabYabZ` regex = `a*b` occ = 2 ).

*+ SUBSTRING_FROM
s3 = substring_from( val = `XaabYabZ` regex = `a*b` len = 5 ).

s4 = substring_from( val = `XaabYabZ` regex = `a*b` occ = -2 len = 4 ).

*+ MATCH
s5 = match( val = `XaabYaaabbZ` regex = `a*b` occ = 2 ).

D_SHOW: s1, s2, s3, s4, s5. D_END.


************************************************************
D_BEG `SUBSTRING_BEFORE/TO( SUB/REGEX )`.

*+ SUBSTRING_BEFORE excludes the search string from the result
s1 = substring_before( val = `abcde` sub = `cd` ).

s2 = substring_before( val = `xyzAABu` regex = `A*B` len = 2 ).

s3 = substring_before( val = `xAByABzAB` sub = `AB` occ = 2 ).

*+ SUBSTRING_TO includes the search string in the result
s4 = substring_to( val = `xyzABuv` sub = `AB` len = 4 ).

s5 = substring_to( val = `xyAABzAB` regex = `A*B` len = 4 occ = -2 ).

D_SHOW: s1, s2, s3, s4, s5. D_END.


************************************************************
D_BEG `SEGMENT`.

*+ Parameter SEP: separator string
s1 = segment( val = `ab, c, def, gh` index = 3 sep = `, ` ).

*+ Default: SEP = ` `
s2 = segment( val = `ab c def gh` index = 2 ).

*+ Parameter SPACE: tokenization ("any of" characters)
s3 = segment( val = `~ ab _~_c__ def~gh_` index = 3 space = ` _~` ).

*+ Negative index counts from end of string
s4 = segment( val = `ab/c/def//g/` index = -4 sep = `/` ).
s5 = segment( val = `ab c  def   gh  ` index = -4 space = ` ` ).

*+ Non-existing segment: exception
try.
 s = segment( val = `ab c de` index = 4 ).
catch cx_sy_strg_par_val into ep. endtry.

D_SHOW: s1, s2, s3, s4, s5, ep. D_END.


************************************************************
D_BEG `REPLACE( OFF+LEN )`.

s1 = replace( val = 'abcdef' with = `XY` off = 2 len = 3 ).
s2 = replace( val = 'abcdef' with = `XY` len = 3 ).

*+ Insertion
s3 = replace( val = 'abcdef' with = `XY` off = 2 ).
s4 = replace( val = 'abcdef' with = `XY` off = 0 ).
s5 = replace( val = 'abcdef' with = `XY` off = 6 ).

*+
try.
 s = replace( val = `abcd` with = 'XY' off = 5 ).
catch cx_sy_range_out_of_bounds into eb. endtry.

D_SHOW: s1, s2, s3, s4, s5, eb. D_END.


************************************************************
D_BEG `REPLACE( SUB/REGEX )`.

s1 = replace( val = 'abcdbce' sub = 'bc' with = 'X' ).
s2 = replace( val = 'abcaabd' regex = 'a*b' with = 'X' occ = 2 ).
s3 = replace( val = 'abcdbce' sub = 'bc' with = 'X' occ = -1 ).

*+ OCC = 0 means "all occurrences"
s4 = replace( val = 'abcdbce' sub = 'bc' with = 'X' occ = 0 ).
s5 = replace( val = 'abcaabd' regex = 'a*b' with = 'X' occ = 0 ).

*+
try.
 s = replace( val = `abcde` sub = `` with = `X` ).
catch cx_sy_strg_par_val into ep. endtry.

D_SHOW: s1, s2, s3, s4, s5, ep. D_END.


************************************************************
D_BEG `REPEAT`.

s1 = repeat( val = '.' occ = 5 ).

*+
try.
 s = repeat( val = `_` occ = -1 ).
catch cx_sy_strg_par_val into ep. endtry.

D_SHOW: s1, ep. D_END.


************************************************************
D_BEG `REVERSE`.

s1 = reverse( val = `Was it a cat I saw?` ).

s2 = reverse( `I, madam, I made radio. So I dared! Am I mad? Am I?` ).

D_SHOW: s1, s2. D_END.


************************************************************
D_BEG `SHIFT_LEFT`.

*+ Remove leading occurrences of a substring
s1 = shift_left( val = `   abc  ` ).
s2 = shift_left( val = `/-/-abc/-` sub = `/-` ).

*+ Remove leading characters
s3 = shift_left( val = `abcXY` places = 3 ).

*+ Circulate leading characters to the back
s4 = shift_left( val = `abcXY` circular = 3 ).

*+
try.
  s = shift_left( val = `abcXY` circular = 6 ).
catch cx_sy_range_out_of_bounds into eb. endtry.

D_SHOW: s1, s2, s3, s4, eb. D_END.


************************************************************
D_BEG `SHIFT_RIGHT`.

*+ Remove trailing occurrences of a substring
s1 = shift_right( val = `   abc  ` ).
s2 = shift_right( val = `/-/-abc/-` sub = `/-` ).

*+ Remove trailing characters
s3 = shift_right( val = `abXYZ` places = 3 ).

*+ Circulate trailing characters to the front
s4 = shift_right( val = `abXYZ` circular = 3 ).

D_SHOW: s1, s2, s3, s4. D_END.


************************************************************
D_BEG `CONDENSE`.

*+ Delete delimiting blanks, condense inner blanks into one
s1 = condense( val = `   a bc  de   fgh  ` ).

*+ Using DEL: Delete other delimiting characters
s2 = condense( val = `-++a+-bc  de   fgh-+` del = `+-` ).

*+ Using FROM/TO: Condense other characters
s3 = condense( val = `  a bc  de   fgh  ` to = '!' ).
s4 = condense( val = `  -++a+-bc  de+f--+  ` from = `+-` to = '!' ).

*+ Delete and condense other characters
s5 = condense( val = `~_+-a+bc  de-+f+_~~` del = `_~` from = `+-` to = '!' ).

*+ Empty FROM: Do not condense inner characters
s6 = condense( val = `  a bc  de   fgh  ` from = '' ).

*+ Empty TO: Condense to nothing
s6 = |{ s6 }\n{ condense( val = `  a_bc__de___fgh  ` from = '_' to = '' ) }|.

D_SHOW: s1, s2, s3, s4, s5, s6. D_END.


************************************************************
D_BEG `TRANSLATE`.

*+ Character mapping by position
s1 = translate( val = `abcdef` from = 'bce' to = 'XYZ' ).

*+ Positions in FROM but not in TO are deleted
s2 = translate( val = `abcdef` from = 'bce' to = 'X' ).

D_SHOW: s1, s2. D_END.


************************************************************
D_BEG `TO_UPPER / TO_LOWER`.

s1 = to_upper( `aBcD 12!` ).

*+
s2 = to_lower( `aBcD 12!` ).

D_SHOW: s1, s2. D_END.


************************************************************
D_BEG `TO_MIXED / FROM_MIXED`.

*+ Underscore discipline to mixed-case
s1 = to_mixed( 'AA_BBB_CD' ).

*+ Other separator character
s2 = to_mixed( val = 'AA/BBB/CD' sep = '/' ).
*s3 = to_mixed( val = 'AA_BBB_CD' case = 'x' ).

*+ Minimal length of a "mixed" segment
s3 = to_mixed( val = 'A_BB_CC_DD' min = 3 ).

*+ Mixed-case to underscore discipline
s4 = from_mixed( 'AbCdeFg' ).

s5 = from_mixed( val = 'AABbCDd' sep = '-' min = 2 ).

D_SHOW: s1, s2, s3, s4, s5. D_END.


************************************************************
D_BEG `ESCAPE`.

*+ Markup (XML and HTML contexts)
s1 = |{ escape( val = `<X> & "Y" 'Z'` format = cl_abap_format=>e_XML_TEXT ) }\n | &
     |{ escape( val = `<X> & "Y" 'Z'` format = cl_abap_format=>e_XML_ATTR ) }\n | &
     |{ escape( val = `<X> & "Y" 'Z'` format = cl_abap_format=>e_HTML_ATTR_SQ ) }|.

*+ URL / URI
s2 = |{ escape( val = `<X> & "Y" 'Z' \+?[]#` format = cl_abap_format=>e_URL ) }\n | &
     |{ escape( val = `<X> & "Y" 'Z' \+?[]#` format = cl_abap_format=>e_URI ) }|.

* SP4:
*+ Regex / ABAP string template
s3 = |{ escape( val = `\+?*{}` format = cl_abap_format=>e_REGEX ) }\n | &
     |{ escape( val = `\+?*{}` format = cl_abap_format=>e_STRING_TPL ) }|.

D_SHOW: s1, s2, s3. D_END.


************************************************************
D_BEG `CONCAT_LINES_OF`.

*+
s1 = concat_lines_of( s_tab ).  "^ s_tab

s2 = concat_lines_of( table = s_tab sep = '//' ).

D_SHOW: s1, s2. D_END.


************************************************************
D_BEG `FIND/FIND_END( SUB/REGEX )`.

i1 = find( val = `xAByABzzAB` sub = `AB` ).

i2 = find( val = `xAByABzzAB` sub = `AB` off = 2 len = 1 + 3 ).

i3 = find( val = `xAByABzzAB` sub = `AB` occ = 2 ).

*+ Negative OCC(urrence) counts from end of string
i4 = find( val = `xAByAABzzAB` regex = `A*B` occ = -1 ).

*+ FIND_END adds length of found string
i5 = find_end( val = `xAByAABzzAB` regex = `A*B` occ = 2 ).

*+ The empty string can not be searched
try.
 i = find( val = `abc` sub = `` ).
catch cx_sy_strg_par_val into ep. endtry.

D_SHOW: i1, i2, i3, i4, i5, ep. D_END.


************************************************************
D_BEG `FIND_ANY_OF / FIND_ANY_NOT_OF`.

i1 = find_any_of( val = `abcd` sub = `XbY` ).
i2 = find_any_of( val = `abcd` sub = `XYZ` ).

*+
i3 = find_any_not_of( val = `abcd` sub = `aXb` ).

*+ OCC(urrence)
i4 = find_any_of( val = `abcd` sub = `bXd` occ = 2 ).

i5 = find_any_not_of( val = `abcd` sub = `bcX` occ = -2 ).

D_SHOW: i1, i2, i3, i4, i5. D_END.


************************************************************
* SP4:
D_BEG `COUNT / COUNT_ANY_OF / COUNT_ANY_NOT_OF`.

i1 = count( val = `xAAByABzzABB` sub = `AB` ).

i2 = count( val = `xAAByABzzABB` regex = `A*B` ).

i3 = count_any_of( val = `xAAByABzzABB` sub = `AB` off = 3 ).

i4 = count_any_not_of( val = `xAAByABzzABB` sub = `AB` len = 8 ).

D_SHOW: i1, i2, i3, i4. D_END.


************************************************************
D_BEG `DISTANCE`.

*+ Insert a character
i1 = distance( val1 = `abcde` val2 = `aXbcde` ).

*+ Replace a character
i2 = distance( val1 = `abcde` val2 = `abCde` ).

*+ Delete a character
i3 = distance( val1 = `abcde` val2 = `abce` ).

*+ 1 "Insert" + 1 "Replace" + 1 "Delete"
i4 = distance( val1 = `abcde` val2 = `XaBce` ).

D_SHOW: i1, i2, i3, i4. D_END.


************************************************************
D_BEG `BOOLC`.

c1 = boolc( 1 + 2 between 1 + 1 and 2 + 2 and 3 < 4 + 5 ).

c2 = boolc( 1 < 2  equiv  bit-set( 128 ) = bit-set( 255 ) ).

D_SHOW: c1, c2. D_END.


************************************************************
D_BEG `BOOLX`.

x1 = boolx( bit = 1  bool = 1 + 1 = 2 ).

x2 = boolx( bit = 16  bool = x1 is not initial ).

D_SHOW: x1, x2. D_END.


************************************************************
D_BEG `CONTAINS( SUB/REGEX ) / MATCHES`.

CHECK contains( val = `abcde` sub = `cd` ).
c1 = boolc( contains( val = `abcde` sub = `cd` off = 2 len = 3 ) ).

*+ Minimum number of OCC(urrences)
CHECK NOT contains( val = `abcdbce` sub = `cd` occ = 2 ).

*+ Contains START
ASSERT NOT contains( val = `abcde` start = `cd` ).

ASSERT contains( val = `abcabcde` start = `abc` occ = 2 ).

*+ Contains END
CHECK NOT contains( val = `abcd` end = `cd` occ = 2 ).

CHECK contains( val = `abcdcd` end = `cd` occ = 2 ).

*+ Contains REGEX vs. MATCHES
CHECK contains( val = `abcccdde` regex = `c*d` ).
*. No exact match:
CHECK NOT matches( val = `abcccdde` regex = `c*d` ).
*. Exact match:
CHECK matches( val = `cccd` regex = `c*d` ).

D_SHOW: c1. D_END.


************************************************************
D_BEG `CONTAINS_ANY_OF / CONTAINS_ANY_NOT_OF`.

CHECK contains_any_of( val = `abcd` sub = `XbY` ).

CHECK contains_any_not_of( val = `abcd` sub = `aXcd` ).

*+ Minimum number of OCC(urrences)
CHECK contains_any_of( val = `abcd` sub = `bXd` occ = 2 ).

*+ Contains START
c1 = boolc( contains_any_of( val = `abcd` start = `acd` occ = 2 ) ).

CHECK contains_any_not_of( val = `abcd` start = `cdX` occ = 2 ).

*+ Contains END
CHECK contains_any_of( val = `abcd` end = `acdX` occ = 2 ).

c2 = boolc( contains_any_not_of( val = `abcd` start = `cXY` occ = 2 ) ).

D_SHOW: c1, c2. D_END.


************************************************************
* SP4:
D_BEG `Case (In)Sensitivity`.

*+ CASE = ' ' for "case-insensitive search"
s1 = replace( val = 'aBcdbce' sub = 'bc' with = 'Xy' case = ' ' ).
*+ CASE = 'X' for "case-sensitive search" (default)
s2 = replace( val = 'aBcdbce' sub = 'bc' with = 'Xy' case = 'X' ).

s3 = substring_after( val = 'xaBbyz' regex = 'AB*' case = ' ' ).

i1 = find( val = `xabbyABz` sub = `AB` case = ' ' ).

i2 = count( val = `xabbyABz` regex = `ab*` case = ' ' ).

CHECK contains( val = `AbCDE` sub = `BCd` case = ' ' ).


D_SHOW: s1, s2, s3, i1, i2. D_END.


************************************************************
D_PAR `Release 7.38`.
************************************************************


************************************************************
D_BEG `CASE`.

i1 = 10. s1 = s2 = s3 = '?'.

*+ Calculation type is not influenced by WHEN operands
f1 = 3.
CASE i1 / 4.
  WHEN f1.  s1 = |{ i1 / 4 }|.
ENDCASE.

*+ ...but can be influenced by choice of CASE operands
f1 = 4. f2 = '2.5'.
CASE i1 / f1.
  WHEN f2.  s2 = |{ i1 / f1 }|.
ENDCASE.

CASE |x{ s1 }| && 'y'.
  WHEN `x3y`.   s3 = `x3y`.
ENDCASE.

D_SHOW: s1, s2, s3. D_END.


************************************************************
D_BEG `APPEND / INSERT / MODIFY`.

i1 = 10.

*+ Arithmetic expression
APPEND i1 / 4 TO i_tab.  "^ i_tab
READ TABLE i_tab INDEX lines( i_tab ) INTO i2.

*+ Line type contributes to calculation type
APPEND i1 / 4 TO f_tab ASSIGNING <ff1>.

*+ ...also dynamically
ASSIGN f_tab TO <ftab>.  ". type index table
APPEND i1 / 8 TO <ftab> ASSIGNING <ff2>.

MODIFY i_tab FROM i1 / 4 + 100 INDEX 1 ASSIGNING <fi>.

*+ String expression
INSERT |x{ i1 / 4 }| INTO TABLE s_tab ASSIGNING <fs>.

D_SHOW: i2, <ff1>, <ff2>, <fi>, <fs>. D_END.


************************************************************
D_BEG `READ / DELETE TABLE WITH [TABLE] KEY`.

f1 = 10. s1 = `x1yz1`.

*+
READ TABLE struc_tab TRANSPORTING NO FIELDS  "^ struc_tab
  WITH KEY i = f1 / 4.
i1 = sy-tabix.

READ TABLE struc_tab INTO str1 WITH TABLE KEY ksi
  COMPONENTS s = 'x' && substring( val = s1 off = 4 )
             i = find( val = s1 sub = 'y' ).

*+
DELETE TABLE struc_tab WITH TABLE KEY ksi
  COMPONENTS s = |x{ i1 / 3 }|
             i = f1 / 6.
ASSERT sy-subrc = 0.

D_SHOW: i1, str1-i. D_END.


************************************************************
D_BEG `ASSIGN COMPONENT`.

i1 = 2. s1 = `IJK`.
str1-s = `10`.  ". component 1
str1-i = 20.    ". component 2

*+ Arithmetic expression
ASSIGN COMPONENT i1 - 1 OF STRUCTURE str1 TO <f1>.

*+ String expression
ASSIGN COMPONENT substring( val = s1 len = 1 )
  OF STRUCTURE str1 TO <f2>.

*+ Method call
ASSIGN COMPONENT lcl=>mi1( 1 ) OF STRUCTURE str1 TO <f3>.
ASSIGN COMPONENT lcl=>mc( 's' ) OF STRUCTURE str1 TO <f4>.

D_SHOW: <f1>, <f2>, <f3>, <f4>. D_END.


************************************************************
D_BEG `MESSAGE`.

i1 = 2.

*+ Call / string expression as WITH parameter
MESSAGE i888(sabapdemos) WITH
 lcl=>ms( 'par1' )
 |[par{ i1 * 10 }]|
 INTO s1.

*+ Call / string expression as text
D_IF_IN_DEBUGGER.
  MESSAGE `Message parameters: ` && s1 TYPE 'I'.
ENDIF.

D_SHOW: s1. D_END.


**==========================================================
demo=>bottom( ginfo ).
if demo=>f_compl = 'X'.  exit.  endif.
**
enddo.  " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
**
RETURN.  " end-of-program
**==========================================================



class lcl implementation.
  method constructor.  me->ai = in.     endmethod.
  method mi.    val = in * 10.          endmethod.
  method mi1.   val = in + 1.           endmethod.
  method mf.    val = in * 10 + '0.5'.  endmethod.
  method ms.    val = 'M' && in.        endmethod.
  method mc.    val = to_upper( in ).   endmethod.
  method mx.
    data: s type string, xs type xstring.
    s = in.  translate s to upper case.  xs = s.
    val = bit-not xs.
  endmethod.
  method md.    val = in.                endmethod.
  method mt.    val = in.                endmethod.
  method mtz.   val = in.                endmethod.
  method mst.   val = in.                endmethod.
  method mit.   val = in.                endmethod.
  method mstr.  val = in.                endmethod.
  method mref.
    create object val exporting in = in.
  endmethod.
  method imref.
    add in to me->ai.
    val = me.
  endmethod.
  method imi.
    add in to me->ai.
    val = me->ai.
  endmethod.
endclass.

class lcx implementation.
  method constructor.
    super->constructor( ).
    me->ai = in.
  endmethod.
endclass.
