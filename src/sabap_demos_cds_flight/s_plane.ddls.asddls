@AbapCatalog.sqlViewName: 'S_PlanesV'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Planes'
define view S_Planes as select from spplane 
{
 key planetype, 
 anz_notaus, 
 anz_pers, 
 anz_sber
}           
  
  
  
 