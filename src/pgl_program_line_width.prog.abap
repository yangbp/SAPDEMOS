* Bad example

METHOD create_asxml_table_bad.
  xml_string =
   `<?xml version="1.0" encoding="utf-8" ?><asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0"><asx:values><TABLE><item>1</item><item>2</item><item>3</item><item>4</item><item>5</item><item>6</item></TABLE></asx:values></asx:abap>`.
ENDMETHOD.

* Good example

METHOD create_asxml_table_good.
  xml_string =
   `<?xml version="1.0" encoding="utf-8" ?>`                         &
   `<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">` &
   `<asx:values>`                                                    &
   `<TABLE>`                                                         &
   `<item>1</item>`                                                  &
   `<item>2</item>`                                                  &
   `<item>3</item>`                                                  &
   `<item>4</item>`                                                  &
   `<item>5</item>`                                                  &
   `<item>6</item>`                                                  &
   `</TABLE>`                                                        &
   `</asx:values>`                                                   &
   `</asx:abap>`.
ENDMETHOD.
