@AbapCatalog.sqlViewName: 'DEMO_CDS_ASAN1L'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view Demo_Cds_Assoc_Anno1_Loc
  as select from
    Demo_Cds_Assoc_Anno2
    association [*] to demo_join1 as _some_assoc on
      Demo_Cds_Assoc_Anno2.d = _some_assoc.d
    {
      _some_assoc,
      d
    }
