@ClientHandling.type: #CLIENT_DEPENDENT
@AccessControl.authorizationCheck:#NOT_ALLOWED 
define table function DEMO_CDS_GET_CLIENT_VARIABLES
  with parameters
    @Environment.systemField : #CLIENT
    clnt : syst_mandt
  returns
  {
    mandt      :mandt;
    client     :mandt;
    cds_client :mandt;
  }
  implemented by method
    CL_DEMO_AMDP_CLIENT_VARIABLES=>GET;