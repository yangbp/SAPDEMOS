@AbapCatalog.sqlViewName: 'DEMOCDSASSFI1'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_assoc_filter1 
   as select from
    demo_join1
    association to Demo_Cds_Assoc_Join2 as _demo_join2 on
      _demo_join2.d = demo_join1.d
    {
      _demo_join2[ 
        inner where d = '1' ].d                         as d_2,
      _demo_join2[ 
        inner where d = '1' ].e                         as e_2,
      _demo_join2[ 
        inner where d = '1' ]._demo_join3[ 
                                inner where i = '2' ].i as i_3,
      _demo_join2[ 
        inner where d = '1' ]._demo_join3[ 
                                inner where i = '2' ].j as j_3
    }
