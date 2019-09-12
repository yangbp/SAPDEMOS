program DEMO_SYSLOG_GROUP_CORRESPOND.

" This program
" - selects some syslog entries into a flat table
" - transforms the flat table into a table of tables by GROUPing
" - adds data from another table by CORRESPONDING in "pull mode"
" - transforms it into a similar, but different hierarchical type
"   by CORRESPONDING in "push mode"
" - transforms both trees to JSON and displays them for comparison.

class demo definition final.
 public section.
  methods run.
 private section.

  types: tt_entries type rslgentr_tab.

* ========== 1st hierarchical type of syslog events ==========
  types: begin of t1_event,
           " part of the line type of tt_entries:
           ztime      type t,
           processid  type c length 3,
           client	    type mandt,
           repna      type program_id,
         end of t1_event,
         tt1_event type standard table of t1_event with empty key.
  types: begin of t1_sub_events,
           username   type sy-uname,
           msgid      type c length 3,
           events_1   type tt1_event,
         end of t1_sub_events.
  types: begin of t1_cat_events,
           monkat     type c length 2,
           cat_text   type string,
           cat_events type standard table of t1_sub_events
                           with empty key,
         end of t1_cat_events,
         tt1_cat_events type standard table of t1_cat_events
                             with empty key.

*   ========== 2nd hierarchical type of syslog events ==========
  types: begin of t2_event,
           time       type t,
           client	    type mandt,
           processnum type i,
           program    type program_id,
         end of t2_event,
         tt2_event type standard table of t2_event with empty key.
  types: begin of t2_sub_events,
           user     type sy-uname,
           msgid    type c length 3,
           events_2 type tt2_event,
         end of t2_sub_events.
  types: begin of t2_cat_events,
           category type c length 2,
           cat_text type string,
           events   type standard table of t2_sub_events
                         with empty key,
         end of t2_cat_events,
         tt2_cat_events type standard table of t2_cat_events
                             with empty key.

  types: begin of t_ctxt,
           cat type c length 2,
           txt type string,
         end of t_ctxt.
  data category_texts type hashed table of t_ctxt with unique key cat.

  methods group_entries
    importing       entries  type tt_entries
    returning value(events)  type tt1_cat_events.
  methods add_category_texts
    changing events type tt1_cat_events.
  methods transform_events
    importing       events1  type tt1_cat_events
    returning value(events2) type tt2_cat_events.
  methods to_json
    importing d type data returning value(s) type string.
  methods get_syslog
    returning value(list)  type tt_entries.
endclass.

class demo implementation.

method run.
* (1) Select some syslog entries (of today)
  data(entries) = get_syslog( ).

* (2) Build 1st hierarchical type from flat list by GROUPing
  data(tree1) = group_entries( entries ).

* (3) Add information from auxiliary table by CORRESPONDING
  add_category_texts( changing events = tree1 ).

* (4) Transform into 2nd hierarchical type by CORRESPONDING
  data(tree2) = transform_events( tree1 ).

* (5) Display trees in parallel (JSON in HTML table)
  cl_abap_browser=>show_html(
    size        = cl_abap_browser=>medium
    format      = cl_abap_browser=>landscape
    html_string =
     |<html><body><table style="table-layout:fixed"><tr>| &
     |<td width=50% valign=top><pre>{ to_json( tree1 ) }</pre></td>| &
     |<td width=50% valign=top><pre>{ to_json( tree2 ) }</pre></td>| &
     |</tr></table></body></html>| ).
endmethod.

method group_entries.
* Group by category, then by <user, messageid>
  events =
   value #(
    for groups of <entry> in entries
         group by <entry>-monkat
         ascending
    ( monkat = <entry>-monkat
      cat_events = value #(
        for groups <g> of <e> in group <entry>
             group by ( u = cond #( when <e>-zuser <> ''
                                    then <e>-zuser else '?' )
                        m = <e>-messageid )
             ascending
             ( username = <g>-u
               msgid    = <g>-m
               events_1 = value #(
                 for <x> in group <g>
                 ( " all components by name-matching
                   corresponding #( <x> ) )
               )
     ) ) ) ).
endmethod.

method add_category_texts.
  " CORRESPONDING in "pull" mode (lookup in another table)
  events = corresponding #( events from category_texts
                                   using cat = monkat
                                   mapping cat_text = txt ).
endmethod.


method transform_events.
  " CORRESPONDING in "push" mode (build result from scratch)
  events2 =
   corresponding #( events1
    mapping
     category = monkat
     ( events = cat_events
        mapping
         user = username
         ( events_2 = events_1
            mapping
             time       = ztime
             processnum = processid
             program    = repna
             " other components by name-matching
         )
     )
  ).
endmethod.

method to_json.
  data(wtr) = cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ).
  wtr->if_sxml_writer~set_option( if_sxml_writer=>co_opt_indent ).
  call transformation id
   "options initial_components = `SUPPRESS`
    source tree = d
    result xml wtr.
  s = cl_abap_codepage=>convert_from( wtr->get_output( ) ).
endmethod.

method get_syslog.
  try.
    data(fltr) = new cl_syslog_filter( ).
    fltr->set_filter_datetime(
      im_datetime_from = conv #( |{ sy-datum }000000| )
      im_datetime_to   = conv #( |{ sy-datum }235959| ) ).
    data(syslog) = cl_syslog=>get_instance_by_filter( fltr ).
    list = syslog->get_entries( ).
  catch cx_syslog_read_authorization into data(exc).
    write exc->get_text( ).
    leave program.
  endtry.
  select rslgnkky as cat, rslgnkva as txt from tsl4t
    into table @category_texts where rslgspra = 'E'.
endmethod.

endclass.

start-of-selection.
  new demo( )->run( ).
