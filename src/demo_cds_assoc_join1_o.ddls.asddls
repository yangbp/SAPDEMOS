@AbapCatalog.sqlViewName: 'DEMO_CDS_ASJO1O'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view Demo_Cds_Assoc_Join1_o
  as select from demo_join1
  association to Demo_Cds_Assoc_Join2 as _demo_join2 on
    _demo_join2.d = demo_join1.d
{
  demo_join1.a                                      as a_1,
  demo_join1.b                                      as b_1,
  demo_join1.c                                      as c_1,
  demo_join1.d                                      as d_1,
  _demo_join2[left outer].d                         as d_2,
  _demo_join2[left outer].e                         as e_2,
  _demo_join2[left outer].f                         as f_2,
  _demo_join2[left outer].g                         as g_2,
  _demo_join2[left outer].h                         as h_2,
  _demo_join2[left outer]._demo_join3[left outer].i as i_3,
  _demo_join2[left outer]._demo_join3[left outer].j as j_3,
  _demo_join2[left outer]._demo_join3[left outer].k as k_3,
  _demo_join2[left outer]._demo_join3[left outer].l as l_3
} 
  
 