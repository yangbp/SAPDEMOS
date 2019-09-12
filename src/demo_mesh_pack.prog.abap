program demo_mesh_pack.

* Demonstrates mesh operations, using DDIC development objects as sample data
* (packages, DB tables/fields, domains).
*
* To find mesh operations, either
* -- search for occurrences of macro MESH_OP in this program, or
* -- execute the program, select the Debugger option on the 2nd ("Operation")
*    screen, then choose an operation button.
* Use e.g. "*DEMO*" to select all packages containing "DEMO"; use F4 help on
* the 2nd screen to specify a package from this set.

tables sscrfields.
types  t_packname  type tdevc-devclass.
types  t_obj_name  type tadir-obj_name.
types  tr_obj_name type range of t_obj_name.
types  t_tabclass  type dd02l-tabclass.
types  tr_tabclass type range of t_tabclass.
types  t_text      type as4text.

constants dy_main type sy-dynnr value 1001.
constants dy_oper type sy-dynnr value 1002.
data      dy_curr type sy-dynnr value dy_main.
data      g_devc  type t_packname.

selection-screen begin of screen 1001 title ti_main.
select-options so_devc for g_devc.
parameters     p_langu type sy-langu default sy-langu.
parameters     p_dark  type char255 no-display.
selection-screen end of screen 1001.

define def_button.
  selection-screen pushbutton /1(52): but&1 user-command uc&1.
end-of-definition.

constants n_ops type i value 9. " number of example operations

selection-screen begin of screen 1002 title ti_op.
selection-screen function key: 1, 2. " arrows
def_button: 1, 2, 3, 4, 5, 6, 7, 8, 9.
selection-screen skip.
parameters p_pack  type t_packname.
parameters p_tabcl type t_tabclass. " default 'INTTAB'.
selection-screen skip.
parameters show_dom as checkbox default 'X'.
parameters show_dbt as checkbox default 'X'.
parameters show_dbf as checkbox default 'X'.
selection-screen skip.
parameters break_op as checkbox default ' ' user-command brp.
selection-screen end of screen 1002.

* For demo purposes, we want the descriptions for *all* entities in one table.
* But then we would need constant "ON" conditions for the object-type field in
* associations. As a workaround, we keep the object-type in the source tables.

* Mesh Node: Packages
types: begin of t_pack,
         object     type tadir-object,  " DEVC
         devclass   type t_obj_name,
         "as4user    type t_packname,
         parentcl   type t_obj_name,
         is_root    type sychar01,
         n_subs     type i,
       end of t_pack,
       tt_pack type sorted table of t_pack with unique key devclass
         with non-unique sorted key kpar components parentcl.

* Mesh Node: Descriptions
types: begin of t_descr,
         object     type tadir-object,  " DEVC, TABL, DOMA
         obj_name   type tadir-obj_name,
         langu      type sy-langu,
         text       type t_text,
       end of t_descr,
       tt_descr type sorted table of t_descr with unique key object obj_name langu.

* Mesh Node: DB tables
types: begin of t_dbtab,
         object     type tadir-object,  " TABL
         tabname    type t_obj_name,
         tabclass   type t_tabclass,
        "applclass  type dd02l-applclass,
         devclass   type t_obj_name,
       end of t_dbtab,
       tt_dbtab type sorted table of t_dbtab with unique key tabname
         with non-unique sorted key kpack components devclass.
* Mesh Node: DB table fields (w/o descriptions)
types: begin of t_dbfld,
         tabname    type t_obj_name,
         fieldname  type t_obj_name,
         position   type dd03l-position,
         domname    type t_obj_name,
       end of t_dbfld,
       tt_dbfld type sorted table of t_dbfld with non-unique key tabname fieldname.

* Mesh Node: Domains
types: begin of t_domain,
         object     type tadir-object,  " DOMA
         domname    type t_obj_name,
         devclass   type t_obj_name,
       end of t_domain,
       tt_domain type sorted table of t_domain with unique key domname
         with non-unique sorted key kpack components devclass.

* Mesh Type: Development Objects ################################################
types: begin of mesh t_dev_obj_mesh,

  description type tt_descr,

  package type tt_pack
    association descr   to description on object = object and obj_name = devclass
    association subs    to package on parentcl = devclass using key kpar
    association super   to package on devclass = parentcl using key primary_key
    association dbtabs  to dbtable on devclass = devclass using key kpack
    association domains to domain  on devclass = devclass using key kpack,

  dbtable type tt_dbtab
    association fields  to dbfield on tabname = tabname using key primary_key
    association descr   to description on object = object and obj_name = tabname,

  dbfield type tt_dbfld
    association domain  to domain on domname = domname using key primary_key,

  domain  type tt_domain
    association descr   to description on object = object and obj_name = domname,

end of mesh t_dev_obj_mesh. " ###################################################


data exop type c length 60.

define MESH_OP.
  if break_op = 'X' and exop+&1(1) = ' '.
    exop+&1(1) = 'X'.
    break-point ##NO_BREAK.
  endif.
end-of-definition.


class lcl_demo definition.
public section.
  " Hierarchical table structure for "to-tree" demo
  types: begin of t_dbfld_n,
           fieldname  type t_obj_name,
           position   type dd03l-position,
           domname    type t_obj_name,
         end of t_dbfld_n,
         tt_dbfld_n type sorted table of t_dbfld_n with unique key fieldname position.
  types: begin of t_dbtab_n,
           tabname    type t_obj_name,
           descr      type t_text,
           tabclass   type t_tabclass,
           fields     type tt_dbfld_n,
         end of t_dbtab_n,
         tt_dbtab_n type sorted table of t_dbtab_n with unique key tabname.
  types: begin of t_domain_n,
           domname    type t_obj_name,
           descr      type t_text,
         end of t_domain_n,
         tt_domain_n type sorted table of t_domain_n with unique key domname.
  types: begin of t_pack_n,
           devclass   type t_obj_name,
           descr      type t_text,
           dbtables   type tt_dbtab_n,
           domains    type tt_domain_n,
           n_subs     type i,
           subs       type ref to data, " tt_pack_n
         end of t_pack_n,
         tt_pack_n type sorted table of t_pack_n with unique key devclass.
  methods execute_op          importing op     type sy-ucomm
                              returning value(opno) type i.
  methods load_mesh           importing langu  type sy-langu.
  methods serialize_package   importing pack   type t_pack.
  methods serialize_dbtab     importing dbtab  type t_dbtab.
  methods serialize_domain    importing domain type t_domain.
  methods serialize_packages.
  methods header              importing str type csequence optional.
  methods domains_in_package  importing value(name) type string optional.
  methods domains_change      importing chgdescr type sychar01 default ' '.
  methods package_size        importing name type csequence
                              changing  tabl type i optional
                                        doma type i optional
                              returning value(subs) type i.
  methods subpackage_count.
  methods package_max         returning value(pack) type t_packname.
  methods dbtables_delete.
  methods dbfields_insert.
  methods dbfields_modify.
  methods object_tree         returning value(tree) type tt_pack_n.
  methods object_tree_node    importing pack type t_pack
                              returning value(node) type t_pack_n.
  methods get_descr           importing dobj type data
                              returning value(text) type t_text.
  methods check_pack          returning value(ok) type sychar01.
  methods browser.
*  types: begin of t_root,
*           devc type t_obj_name,
*           root type t_obj_name,
*           nest type i,
*         end of t_root,
*         tt_root type sorted table of t_root with unique key devc.
*  data roots      type tt_root.
  data dom        type t_dev_obj_mesh.
  data counted    type sychar01.
  data sel_langu  type sy-langu.
  data sel_name   type t_packname.
  data sel_pack   type t_pack.
  data sel_tabcl  type t_tabclass.
  data sel_tc     type tr_tabclass.
  data hstr       type string.
  data title      type string.
  data tree       type tt_pack_n.
  data mode       type i.
  data s_dbt      type sychar01.
  data s_dbf      type sychar01.
  data s_dom      type sychar01.
endclass.

class lcl_demo implementation.

method serialize_package.

  if mode = 3 and p_dark is not initial.  return.  endif.

  data(pname) = |<span class="nm">{ pack-devclass }</span>|.
  " find the description (language-dependent)
  hstr = |{ hstr }\n<tr><td class="nm"><h3>{ pack-devclass }</h3></td>| &
         |<td class="pd"> { get_descr( pack ) }</td></tr>|.

  if s_dbt = 'X' and line_exists( dom-package\dbtabs[ pack ] ).
    hstr = |{ hstr }\n<tr><td colspan=2><table class="db"><tr><h4>{ text-e01 } ( { pname } )</h4></tr>|.
    " --- loop over db-tables in this package
    MESH_OP 2.
    loop at dom-package\dbtabs[ pack ] assigning field-symbol(<dbtab>).
      serialize_dbtab( <dbtab> ).
    endloop.
    hstr = |{ hstr }</table><br>|.
  endif.

  if s_dom = 'X' and line_exists( dom-package\domains[ pack ] ).
     hstr = |{ hstr }\n<tr><td colspan=2><table class="do"><tr><h4>{ text-e02 } ( { pname } )</h4></tr>|.
    " --- loop over domains in this package
    MESH_OP 3.
    loop at dom-package\domains[ pack ] assigning field-symbol(<domain>).
      serialize_domain( <domain> ).
    endloop.
    hstr = |{ hstr }</table><br>|.
  endif.

  if line_exists( dom-package\subs[ pack ] ).
    hstr = |{ hstr }\n<tr><td colspan=2><table class="pk">|.
    " --- loop recursively over the sub-packages of this package
    MESH_OP 4.
    loop at dom-package\subs~package[ pack ] assigning field-symbol(<subpack>).
      serialize_package( <subpack> ).
    endloop.
    hstr = |{ hstr }</table>|.
  endif.

endmethod. " serialize_package


method serialize_dbtab.

  if mode = 4 and p_dark is not initial.  return.  endif.

  hstr = |{ hstr }\n<tr><td class="nm"><a id="TA.{ dbtab-tabname }">| &
         |{ dbtab-tabname }<div class="tc">[{ dbtab-tabclass }]</div></td>| &
         |<td>{ get_descr( dbtab ) }</td></tr>|.

  if s_dbf = 'X' and line_exists( dom-dbtable\fields[ dbtab ] ).
    hstr = |{ hstr }<tr><td colspan=2><table class="fd">|.
    " loop over fields in the db-table
    MESH_OP 6.
    loop at dom-dbtable\fields[ dbtab ] assigning field-symbol(<dbfld>).
      hstr = |{ hstr }\n<tr><td>{ <dbfld>-position }</td><td>{ <dbfld>-fieldname }</td><td class="dn">|.
      if s_dom = 'X' and <dbfld>-domname is not initial
       and line_exists( dom-domain[ domname = <dbfld>-domname ] ).
        hstr = |{ hstr }<a href="#DO.{ <dbfld>-domname }">{ <dbfld>-domname }</a></td></tr>|.
      else.
        hstr = |{ hstr }{ <dbfld>-domname }</td></tr>|.
      endif.
    endloop.
    hstr = |{ hstr }</table>|.
  endif.

endmethod. " serialize_dbtab


method serialize_domain.

  hstr = |{ hstr }\n<tr><td class="nm"><a id="DO.{ domain-domname }">{ domain-domname }</a></td>|.
  if mode = 2. hstr = |{ hstr }<td class="nm">{ domain-devclass }</td>|. endif.
  hstr = |{ hstr }<td>{ get_descr( domain ) }|.

  " where-used list: loop over associated db-tables
  MESH_OP 8.
  data(ustr) = reduce string( init u = `` sep = ``

    for <dbt> in dom-domain\^domain~dbfield[ domain ]\^fields~dbtable[ ]

    next u = cond #( when s_dbt is not initial
      then |{ u }{ sep }<a href="#TA.{ <dbt>-tabname }">{ <dbt>-tabname }</a>|
      else |{ u }{ sep }{ <dbt>-tabname }| )  sep = ` , ` ).

  if ustr <> ``.  hstr = |{ hstr }<br><i>{ text-e03 }:</i> { ustr }|.  endif.
  hstr = |{ hstr }</td></tr>|.

endmethod. " serialize_domain


method serialize_packages.
  field-symbols <pack> type t_pack.

  mode = 1.
  header( |<h1>{ title }</h1>\n| ).
  if sel_name is initial.
    loop at dom-package assigning <pack> where is_root = 'X'.
      hstr = |{ hstr }\n<table class="pk">|.
      serialize_package( <pack> ).
      hstr = |{ hstr }</table><br>|.
    endloop.
  else.
    assign dom-package[ devclass = sel_name ] to <pack>.
    if sy-subrc = 0.
      hstr = |{ hstr }\n<table border=0>|.
      serialize_package( <pack> ).
      hstr = |{ hstr }</table><br>|.
    endif.
  endif.

endmethod. " serialize_packages


method domains_in_package.

  if name is initial.  name = sel_name.  endif.
  sel_pack = value #( devclass = name ).
  if mode < 0 or check_pack( ) is initial.  return.  endif.
  mode = 2.  s_dbt = ' '.
  header( |<h1>{ title } ({ name })</h1>\n<table class="do">| ).

  " --- loop over sub-packages (incl. self) and included domains
  MESH_OP 10.
  loop at dom-package\subs*[ sel_pack ]\domains[ ]
   assigning field-symbol(<domain>) ##PRIMKEY.
    serialize_domain( <domain> ).
  endloop.
  hstr = |{ hstr }</table>|.

endmethod. " domains_in_package


method domains_change.

  if check_pack( ) is initial.  return.  endif.

  if chgdescr is initial.
    " don't change descriptions -> one multi-instance operation

    MESH_OP 12.
    set association
     dom-package\subs+[ sel_pack ]\domains[ ]\^domains~package[ ] = sel_pack.

    return.
  endif.

  " build range table of sub-packages by table comprehension
  MESH_OP 14.
  data(packs) = value tr_obj_name(
    for <p> in dom-package\subs+[ sel_pack ]
    ( sign = 'I' option = 'EQ' low = <p>-devclass ) ).

  " loop / single-instance operations
  loop at dom-domain assigning field-symbol(<domain>) where devclass in packs.
    " get description of package previously containing the domain
    data(old) = get_descr( value #( dom-domain\^domains~package[ <domain> ] ) ).

    " change package of domain
    MESH_OP 16.
    set association dom-domain\^domains~package[ <domain> ] = sel_pack.

    " change description of domain
    assign dom-domain\descr[ <domain> langu = sel_langu ] to field-symbol(<descr>).
    if sy-subrc = 0.
      <descr>-text = |[{ old }] { <descr>-text }|.
    else.
      " domain didn't have a description -> insert one
      MESH_OP 18.
      insert value #( text = old langu = sel_langu )
       into table dom-domain\descr[ <domain> ].
    endif.
  endloop.

" NB: Cannot use the following loop:
"  loop at dom-package\subs+[ main_pack ]\domains[ ] assigning field-symbol(<domain>).
" Single-instance SET ASSOCIATION would fail with runtime error, because the loop
" would write-protect <domain>-devclass.

endmethod. " domains_change


method package_size.
  data: l type i, r type i.
  data(pack) = value t_pack( devclass = name ).

  if doma is requested.
    MESH_OP 20.
    l = reduce #( init i = 0
                  for d in dom-package\domains[ pack ] next i = i + 1 ).
    r = reduce #( init i = 0
                  for d in dom-package\subs+[ pack ]\domains[ ] next i = i + 1 ).
    doma = l + r.
  endif.

  if tabl is requested.
    MESH_OP 22.
    l = reduce #( init i = 0
                  for t in dom-package\dbtabs[ pack ] next i = i + 1 ).
    r = reduce #( init i = 0
                  for t in dom-package\subs+[ pack ]\dbtabs[ ] next i = i + 1 ).
    tabl = l + r.
  endif.

  if subs is requested.
*    if roots is initial.
*      " --- compute table of roots and nesting depths
*      MESH_OP 24.
*      roots = value #( for <p> in dom-package
*        let sups = value tt_root( for <s> in dom-package\super+[ <p> ]
*          ( devc = <s>-devclass
*            nest = cond #( when <s>-is_root <> 'X' then 1 ) ) )
*        in ( devc = <p>-devclass
*             root = cond #( when sups is initial then <p>-devclass
*                                else sups[ nest = 0 ]-devc )
*             nest = lines( sups ) ) ).
*    endif.
*    nest = roots[ devc = pack-devclass ]-nest.
    if counted is initial.
      subpackage_count( ).
    endif.
    subs = dom-package[ devclass = name ]-n_subs.
  endif.

endmethod. " package_size


method subpackage_count.

  MESH_OP 24.
  loop at dom-package assigning field-symbol(<pack>).
    " compute sub-package count
    loop at dom-package\super+[ <pack> ] assigning field-symbol(<sup>).
      add 1 to <sup>-n_subs.
    endloop.
  endloop.
  counted = 'X'.

endmethod. " subpackage_count


method package_max.
  data: max type i, nt type i, nd type i.

  loop at dom-package assigning field-symbol(<pack>).
    package_size( exporting name = <pack>-devclass changing tabl = nt doma = nd ).
    if nd > 0  and nt > 0 and nt + nd > max.
      pack = <pack>-devclass.  max = nt + nd.
    endif.
  endloop.

endmethod. " package_max


method dbtables_delete.

  if check_pack( ) is initial.  return.  endif.
  s_dbf = ' '.  mode = 4.
  header( |<h1>{ title } ({ sel_name } / { sel_tabcl })</h1>\n<table class="db">| ).

  " --- display before delete: loop over dbtables
  MESH_OP 26.
  loop at dom-package\subs*[ sel_pack ]\dbtabs[ where tabclass = sel_tabcl ]
   assigning field-symbol(<dbtab>) ##PRIMKEY.
    serialize_dbtab( <dbtab> ).
  endloop.
  hstr = |{ hstr }</table>|.

  " --- delete them
  MESH_OP 28.
  delete dom-package\dbtabs[ sel_pack where tabclass = sel_tabcl ].
  delete dom-package\subs+[ sel_pack ]\dbtabs[ where tabclass = sel_tabcl ].

endmethod. " dbtables_delete


method dbfields_insert.

  if check_pack( ) is initial.  return.  endif.
  header( |<h1>{ title } ({ sel_name } / { sel_tabcl })</h1>\n| ).

  MESH_OP 30.
  " --- loop over all dbtables in package(s)
  loop at dom-package\subs*[ sel_pack ]\dbtabs[ where tabclass in sel_tc ]
   assigning field-symbol(<dbtab>) ##PRIMKEY.

    data(pos) = 1.  data(idx) = 1.
    " --- loop over all fields in dbtable: determine position and name index
    loop at dom-dbtable\fields[ <dbtab> ] assigning field-symbol(<dbfld>).
      pos = nmax( val1 = pos val2 = <dbfld>-position + 1 ).
      if matches( val = <dbfld>-fieldname regex = `NEW_FIELD_[[:digit:]]+` ).
        data(x) = substring_after( val = <dbfld>-fieldname sub = `_` occ = 2 ).
        idx = nmax( val1 = idx val2 = x + 1 ).
      endif.
    endloop.

    " --- insert new field into dbtable
    MESH_OP 32.
    insert value t_dbfld( fieldname = |NEW_FIELD_{ idx }| position = pos
                          domname = 'XSDBOOLEAN' )
     into table dom-dbtable\fields[ <dbtab> ].

  endloop.

  s_dbf = 'X'.  s_dom = ' '.  mode = 3.  serialize_package( sel_pack ).

endmethod. " dbfields_insert


method dbfields_modify.

  if check_pack( ) is initial.  return.  endif.
  header( |<h1>{ title } ({ sel_name } / { sel_tabcl })</h1>\n| ).
  data(fld) = value t_dbfld( domname = 'XSDLANGUAGE' ).

  " --- modify field in all tables in package(s)
  MESH_OP 34.
  modify dom-package\dbtabs[ sel_pack where tabclass in sel_tc
                   ]\fields[ where fieldname cs 'NEW_FIELD_' ]
   from fld transporting domname.
  modify dom-package\subs+[ sel_pack ]\dbtabs[ where tabclass in sel_tc
                   ]\fields[ where fieldname cs 'NEW_FIELD_' ]
   from fld transporting domname.

  s_dbf = 'X'.  s_dom = ' '.  mode = 3.  serialize_package( sel_pack ).

endmethod. " dbfields_modify


method object_tree.

MESH_OP 40.
if sel_pack is initial.
  tree = value #( for <pack> in dom-package where ( is_root is not initial )
                  ( object_tree_node( <pack> ) ) ).
else.
  tree = value #( ( object_tree_node( sel_pack ) ) ).
endif.

endmethod. " object_tree


method object_tree_node.

node = value #(

  devclass = pack-devclass
  descr    = get_descr( pack )
  n_subs   = package_size( name = pack-devclass )

  dbtables = cond #( when s_dbt is not initial then value #(
    for <dbtab> in dom-package\dbtabs[ pack ]
    ( tabname  = <dbtab>-tabname
      tabclass = <dbtab>-tabclass
      descr    = get_descr( <dbtab> )
      fields   = cond #( when s_dbf is not initial then value #(
        for <dbfld> in dom-dbtable\fields[ <dbtab> ]
        ( corresponding #( <dbfld> ) )
      ) )
    )
  ) )

  domains = cond #( when s_dom is not initial then value #(
    for <domain> in dom-package\domains[ pack ]
    ( domname  = <domain>-domname
      descr    = get_descr( <domain> )
    )
  ) )

  subs = cond #( when line_exists( dom-package\subs[ pack ] ) then
    new tt_pack_n( for <sub> in dom-package\subs[ pack ]
                   ( object_tree_node( <sub> ) )
  ) )
).

endmethod. " object_tree_node


method get_descr.
  field-symbols: <pak> type t_pack, <tab> type t_dbtab, <dom> type t_domain.
  field-symbols: <obj> type tadir-object, <descr> type t_descr.
  assign dobj to <obj> casting.
  case <obj>.
    when 'DEVC'.
      assign dobj to <pak>.
      assign dom-package\descr[ <pak> langu = sel_langu ] to <descr>.
    when 'TABL'.
      assign dobj to <tab>.
      assign dom-dbtable\descr[ <tab> langu = sel_langu ] to <descr>.
    when 'DOMA'.
      assign dobj to <dom>.
      assign dom-domain\descr[ <dom> langu = sel_langu ] to <descr>.
  endcase.
  if <descr> is assigned.
    text = <descr>-text.
  endif.
endmethod. " get_descr


method check_pack.
  ok = 'X'.
  if sel_pack is initial.
    clear ok.  mode = -1.
    message text-er1 type 'I'.
  endif.
endmethod. " check_pack.


method header.
  hstr =
  |<html><head>| &
  |<meta http-equiv="content-type" content="text/html; charset=| &
  |{ cl_abap_codepage=>for_language( sy-langu ) }">| &
  |<style type="text/css">\n| &
  |a \{font-family:monospace;text-decoration:none\} a:link\{color:207090\}| &
  |h3 \{color: #1000d0\}| &
  |table \{width:98%\}| &
  |td \{border:0px;padding-left:5px;padding-right:5px;vertical-align:top\}| &
  |.pk \{border:2px solid #1000d0;margin-left:15px\}| &
  |.db \{border:2px solid #bb2020;margin-left:10px\}| &
  |.fd \{border:1px solid #bf2f2f;margin-left:10px;border-collapse:collapse\}| &
  |.do \{border:2px solid #f8b000;margin-left:10px\}| &
  |.nm \{font-family:monospace;width:2%;border:0px;vertical-align:top\}| &
  |.pd \{font-size:larger;padding-left:10px\}| &
  |.tc \{font-size:smaller;color:#a02020\}| &
  |table.fd tr td \{font-family:monospace;font-size:smaller;width:2%;| &
  | border-style:solid;border-width:0px;border-right-width:1px\}| &
  |table.fd tr td.dn \{font-family:monospace;width:98%\}| &
  |</style></head><body>\n| &
  |{ str }|.
endmethod. " header


method load_mesh.

  clear: dom, counted.
  sel_langu = langu.

* --- Get packages
  select * from tdevc into corresponding fields of table dom-package
    where devclass in so_devc.
  select 'DEVC' as object, devclass as obj_name, spras as langu, ctext as text
    from tdevct appending table @dom-description
    where devclass in @so_devc and spras = @sel_langu.
  " mark root packages in this selection
  loop at dom-package assigning field-symbol(<pack>).
    <pack>-object = 'DEVC'.
    <pack>-is_root = boolc( not line_exists( dom-package\super[ <pack> ] ) ).
  endloop.

* --- Get DB-tables
  select 'TABL' as object, tabname, tabclass, devclass from info_tabl
    into table @dom-dbtable where devclass in @so_devc and as4local = 'A'.
  select 'TABL' as object, tabname as obj_name, ddlanguage as langu,
    ddtext as text from info_tablt appending table @dom-description
    where devclass in @so_devc and as4local = 'A' and ddlanguage = @sel_langu.
* --- Get DB-table fields
  select tabname fieldname position domname from info_tabls
    into corresponding fields of table dom-dbfield
    where devclass in so_devc and as4local = 'A' and precfield = ''.

* --- Get domains
  select 'DOMA' as object, domname, devclass from info_doma
    into table @dom-domain where devclass in @so_devc and as4local = 'A'.
  select 'DOMA' as object, domname as obj_name, ddlanguage as langu,
    ddtext as text from info_domat appending table @dom-description
    where devclass in @so_devc and as4local = 'A' and ddlanguage = @sel_langu.

endmethod. " load_mesh


method browser.
  if p_dark is not initial.
    return.
  elseif hstr is not initial and mode >= 0.  " mode < 0 indicates error
    hstr = |{ hstr }</body></html>|.
    cl_abap_browser=>show_html( size = cl_abap_browser=>xlarge
                                html_string = hstr
                                context_menu = 'X' ).
  elseif tree is not initial.
    call transformation id
     options initial_components = 'SUPPRESS'  data_refs = 'EMBEDDED'
     source data = tree result xml data(xstr).
    cl_abap_browser=>show_xml( size = cl_abap_browser=>xlarge
                               xml_xstring = xstr ).
  endif.
endmethod. " browser


method execute_op.
  data(ix) = conv i( conv char5( |0{ substring_after( val = op sub = `UC` ) }| ) ).
  s_dbt = show_dbt.  s_dbf = show_dbf.  s_dom = show_dom.
  sel_name = p_pack.  sel_tabcl = p_tabcl.
  sel_pack = value #( devclass = sel_name ).
  clear: sel_tc, mode, hstr, tree, exop.
  if sel_tabcl is not initial.
    sel_tc = value tr_tabclass( ( sign = 'I' option = 'EQ' low = sel_tabcl ) ).
  endif.
  opno = cond #( when ix between 1 and n_ops then ix else 1 ).
  case opno.
    when 1.
      title = text-o01.
      serialize_packages( ).
    when 2.
      title = text-o02.
      domains_in_package( ).
    when 3.
      title = text-o03.
      p_pack = sel_name = package_max( ).
      serialize_packages( ).
    when 4.
      title = text-o04.
      domains_change( ).
      domains_in_package( ).
    when 5.
      title = text-o05.
      domains_change( chgdescr = 'X' ).
      domains_in_package( ).
    when 6.
      title = text-o06.
      dbtables_delete( ).
    when 7.
      title = text-o07.
      dbfields_insert( ).
    when 8.
      title = text-o08.
      dbfields_modify( ).
    when 9.
      title = text-o09.
      tree = object_tree( ).
  endcase.
  browser( ).
endmethod. " execute_op

endclass. " lcl_demo


data demo type ref to lcl_demo.
data opno type i.
data opuc type sy-ucomm.

initialization.
  ti_main = text-t00. ti_op = text-t01.
  sscrfields-functxt_01 = '@0H@'.  sscrfields-functxt_02 = '@0I@'.
  "so_devc[] =  value #( ( sign = 'I' option = 'CP' low = 'SABP*' ) ).
  opno = 1.
  demo = new #( ).

at selection-screen output.
  do n_ops times. " mark currently selected operation
    data(_b) = |BUT{ sy-index }|.      assign (_b) to field-symbol(<_b>).
    data(_t) = |TEXT-O0{ sy-index }|.  assign (_t) to field-symbol(<_t>).
    if sy-index = opno. <_b> = `@0E@ ` && <_t>. else. <_b> = <_t>. endif.
  enddo.

at selection-screen.
  clear opuc.
  if dy_curr = dy_main and sscrfields-ucomm = 'CRET'.
    if so_devc[] is initial.
      message text-er1 type 'W'.
      return.
    endif.
    dy_curr = dy_oper.
  elseif contains( val = sy-ucomm start = 'UC' ).
    opno = demo->execute_op( sy-ucomm ).
  elseif sy-ucomm = 'FC01'.
    opno = opno mod n_ops + 1.
  elseif sy-ucomm = 'FC02'.
    opno = cond #( when opno = 1 then n_ops else opno - 1 ).
  elseif sy-ucomm = 'CRET'.
    opuc = |UC{ opno }|. " execute selected operation
  endif.

start-of-selection.
  if p_dark is not initial.
    " execute dark operations sequence
    demo->load_mesh( p_langu ).
    split p_dark at ',' into table data(dark_ops).
    loop at dark_ops assigning field-symbol(<dark_op>).
      if <dark_op> = 'SHOW'.
        clear p_dark.  continue.
      endif.
      assert <dark_op> between 1 and n_ops.
      sy-ucomm = |UC{ <dark_op> }|.
      demo->execute_op( sy-ucomm ).
    endloop.
    return.
  endif.
  do.
    if dy_curr = dy_main.
      call selection-screen dy_main.
      if sy-subrc = 4.  leave program.  endif.
      demo->load_mesh( p_langu ).
    elseif dy_curr = dy_oper.
      call selection-screen dy_oper.
      if sy-subrc = 4.
        dy_curr = dy_main.
      else.
        if opuc is initial.  opuc = sy-ucomm.  endif.
        opno = demo->execute_op( opuc ).
      endif.
    endif.
  enddo.

at selection-screen on value-request for p_pack.
  call screen 100 starting at 10 5 ending at 57 15.

at line-selection.
  leave to screen 0.

module value_help_pack output.
  data: vht type i, vhd type i, vhs type i.
  suppress dialog.  set pf-status space.  new-page no-title.  clear exop.
  ##NO_TEXT write: 32 'Subs', 38 'TABL', 44 'DOMA'.
  loop at demo->dom-package into data(vhp).
    p_pack = vhp-devclass.
    vhs = demo->package_size( exporting name = vhp-devclass
                              changing  tabl = vht doma = vhd ).
    write: / p_pack color col_key, 32(5) vhs, 38(5) vht, 44(5) vhd.
    hide p_pack.
  endloop.
  leave to list-processing and return to screen 0.
endmodule.
