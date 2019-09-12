@ClientHandling.type: #CLIENT_INDEPENDENT 
define table function DEMO_CDS_GET_SCARR_SPFLI_NOCL
  with parameters
    clnt   :abap.clnt,
    carrid :s_carr_id
  returns
  {
    carrname :s_carrname;
    connid   :s_conn_id;
    cityfrom :s_from_cit;
    cityto   :s_to_city;
  }
  implemented by method
    CL_DEMO_AMDP_FUNCTIONS_NOCL=>GET_SCARR_SPFLI_FOR_CDS;