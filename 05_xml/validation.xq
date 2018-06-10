let $doc := doc('count_query.xml')
let $schema := 'count_query.dtd'
return validate:dtd($doc, $schema)