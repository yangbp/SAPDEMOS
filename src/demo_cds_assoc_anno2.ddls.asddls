@AbapCatalog.sqlViewName: 'DEMO_CDS_ASAN2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view Demo_Cds_Assoc_Anno2
  as select from
    demo_join2
    association [*] to demo_join3 as _some_assoc on
      _some_assoc.l = demo_join2.d
    {
      @SomeAnno: 'Association to demo_join3'
      _some_assoc,
      d
    }
