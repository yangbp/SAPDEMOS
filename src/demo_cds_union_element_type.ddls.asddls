@AbapCatalog.sqlViewName: 'DEMOCDSUNIONTYPE'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view Demo_Cds_Union_Element_Type(
    id,
    col1,
    col2
  )
  as select from
    demo_expressions
    {
      id,
      num1                      as col1,
      cast( num1 as abap.int8 ) as col2
    }
union all select from
  demo_expressions
    {
      id,
      numlong1 as col1,
      numlong1 as col2
    }
