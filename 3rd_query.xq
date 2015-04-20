declare variable $p := doc("path-of-the-file");

copy $e := $p
modify(

for $r in $e/FRAMES/FRAME
return
insert node attribute primary {$r/SYNTAX/node()/name(.)} into $r,

for $r in $e/FRAMES/FRAME
return
insert node attribute semantics {$r/SYNTAX/V/following-sibling::*/node()/@sg/replace(., "(.*)(nmn|gnt|dtv|acc|vct)","$2")} into $r,

for $r in $e/FRAMES/FRAME/@verb-gloss
return
replace value of node $r with $r/translate(., ".", "_"),

for $r in $e/FRAMES/FRAME//V/@gloss
return
replace value of node $r with $r/translate(., ".", "_")

)
return $e
