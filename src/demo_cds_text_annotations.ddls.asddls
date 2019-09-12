@EndUserText.label: 'Demo View mit Texten'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.sqlViewName: 'DEMO_VIEW_TEXTS'
define view demo_cds_text_annotations
 with parameters
 @EndUserText.label:'Eingabeparameter'
 param : abap.int4
 as select from
 demo_expressions
 {
 @EndUserText:{ label:'Ein Element', quickInfo:'Feld' }
 id
 }            
  
  
  
 