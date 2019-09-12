@ClientHandling.type: #CLIENT_DEPENDENT
@AccessControl.authorizationCheck:#NOT_ALLOWED
define table function DEMO_CDS_GET_SCARR_SPFLI
  with parameters
    carrid :s_carr_id
  returns
  {
    client   :s_mandt;
    carrname :s_carrname;
    connid   :s_conn_id;
    cityfrom :s_from_cit;
    cityto   :s_to_city;
  }
  implemented by method
    CL_DEMO_AMDP_FUNCTIONS=>GET_SCARR_SPFLI_FOR_CDS;