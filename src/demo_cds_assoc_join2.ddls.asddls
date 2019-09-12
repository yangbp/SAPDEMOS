@AbapCatalog.sqlViewName: 'DEMO_CDS_ASJO2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view Demo_Cds_Assoc_Join2
  as select from demo_join2
  association [*] to demo_join3 as _demo_join3 on
    _demo_join3.l = demo_join2.d
{
  _demo_join3,
  demo_join2.d,
  demo_join2.e,
  demo_join2.f,
  demo_join2.g,
  demo_join2.h
} 
  
 