(: XQuery that extracts, for each act, the number of scenes, speeches, and lines:)

for $act in //ACT
return <act>
         {$act/TITLE}
         <nscenes>{count($act/SCENE)}</nscenes>
         <nspeeches>{count($act/SCENE/SPEECH)}</nspeeches>
         <nlines>{count($act/SCENE/SPEECH/LINE)}</nlines>
       </act>
       
