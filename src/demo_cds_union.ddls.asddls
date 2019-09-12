@AbapCatalog.sqlViewName: 'DEMO_CDS_UIO'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST,#UNION]
define view demo_cds_union
 as select from
 demo_join1
 {
 a as c1,
 b as c2
 }
union select from
 demo_join2
 {
 d as c1,
 e as c2
 }
union all select from
 demo_join3
 {
 i as c1,
 j as c2
 };            
  
  
  
 