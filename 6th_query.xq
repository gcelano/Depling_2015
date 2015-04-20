declare variable $p := doc("path-of-the-file");
declare variable $b := collection("path-of-VerbNet");

for $h in $p/FRAMES/c/FRAME
let $p := $b//MEMBER[@name = $h/@verb-gloss]
where $p
return
$h
