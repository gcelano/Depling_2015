declare variable $p := doc("path-of-the-file");

copy $e := $p
modify(
for $i at $count in $e//FRAME
return
insert node attribute {"signature"} {concat($i/@primary/replace(., " ", "_"),"." ,$i/@semantics/replace(., " ", "_"),"." ,$i/@verb-gloss/replace(., " ", "_"), ".", $i/@verb-lemma/replace(., " ", "_"))} into $i
)
return $e
