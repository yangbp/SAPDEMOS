@AbapCatalog.sqlViewName: 'DEMO_CDS_ANNOARR'
define view demo_cds_annotation_array
  as select from
    demo_expressions
    {
      @Consumption.filter.hierarchyBinding:
         [ { type: '...', value: '...', variableSequence: 1 },
           { type: '...', value: '...', variableSequence: 2 } ]
      id
    }
