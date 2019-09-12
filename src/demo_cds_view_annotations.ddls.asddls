@EndUserText.label: 'Demo View with Annotations'
@AbapCatalog.sqlViewName: 'DEMO_VIEW_ANNOT'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.type: #CLIENT_DEPENDENT

@DemoAnno.vAnnot0
@DemoAnno.vAnnot1:'abc'
@DemoAnno.vAnnot2:123
@DemoAnno.vAnnot3:[ 123, 456, 789 ]
@DemoAnno.vAnnot4:{ annot0, annot1:'abc', annot2:123 }
@DemoAnno.vAnnot5.annot0
@DemoAnno.vAnnot5.annot1:'abc'
@DemoAnno.vAnnot5.annot2:123
@DemoAnno.vAnnot6:[ { annot0,       annot1:'abc', annot2:123 }, 
                    { annot0:false, annot1:'def', annot2:456 } ]
@DemoAnno.vAnnot7:{ annot0,
                    annot1:[ 123, 456, 789 ],
                    annot2:{ annot0, annot1:'abc', annot2:123 } }
define view demo_cds_view_annotations
  with parameters
    @DemoAnno.pAnnot1:'abc'
    @DemoAnno.pAnnot2:123
    @EndUserText.label:'Input Parameter'
    param : syst_uname 
    @<Environment.systemField:#USER
  as select from
    demo_expressions
    {
          @DemoAnno.fAnnot0
      key id   as key_field 
          @<DemoAnno.fAnnot1:'abc'
          @<DemoAnno.fAnnot2:123,
          @EndUserText:{ label:'Some field', quickInfo:'Some info' }
          @DemoAnno.fAnnot3:[ 123, 456, 789 ]
          num1 as some_field 
          @<DemoAnno.fAnnot4:{ annot0, annot1:'abc', annot2:123 }
    }
