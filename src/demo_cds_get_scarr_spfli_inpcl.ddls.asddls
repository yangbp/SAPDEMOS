@ClientHandling.type: #CLIENT_DEPENDENT
define table function DEMO_CDS_GET_SCARR_SPFLI_INPCL
  with parameters
    @Environment.systemField: #CLIENT
    clnt   :abap.clnt,
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
    CL_DEMO_AMDP_FUNCTIONS_INPCL=>GET_SCARR_SPFLI_FOR_CDS;