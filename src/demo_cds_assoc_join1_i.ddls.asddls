@AbapCatalog.sqlViewName: 'DEMO_CDS_ASJO1I'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view Demo_Cds_Assoc_Join1_i
  as select from demo_join1
  association to Demo_Cds_Assoc_Join2 as _demo_join2 on
    _demo_join2.d = demo_join1.d
{
  demo_join1.a                            as a_1,
  demo_join1.b                            as b_1,
  demo_join1.c                            as c_2,
  demo_join1.d                            as d_1,
  _demo_join2[inner].d                    as d_2,
  _demo_join2[inner].e                    as e_2,
  _demo_join2[inner].f                    as f_2,
  _demo_join2[inner].g                    as g_2,
  _demo_join2[inner].h                    as h_2,
  _demo_join2[inner]._demo_join3[inner].i as i_3,
  _demo_join2[inner]._demo_join3[inner].j as j_3,
  _demo_join2[inner]._demo_join3[inner].k as k_3,
  _demo_join2[inner]._demo_join3[inner].l as l_3
} 
  
 