@AbapCatalog.sqlViewName: 'DEMO_CDS_SEMANNO'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_semantics_annotation
 as select from
 scustom
 {
 id,
 @Semantics.name.fullName
 name,
 @Semantics.name.prefix
 form,
 @Semantics.address.street
 street,
 @Semantics.address.postBox
 postbox,
 @Semantics.address.zipCode
 postcode,
 @Semantics.address.city
 city,
 @Semantics.address.country
 country,
 @Semantics.address.subRegion
 region,
 @Semantics.contact.type
 custtype,
 @Semantics.language
 langu,
 @Semantics.eMail.address
 email
 }            
  
  
  
 