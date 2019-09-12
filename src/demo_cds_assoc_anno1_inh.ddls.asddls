@AbapCatalog.sqlViewName: 'DEMO_CDS_ASAN1I'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view Demo_Cds_Assoc_Anno1_Inh
  as select from
    Demo_Cds_Assoc_Anno2
    {
      _some_assoc,
      d
    }
