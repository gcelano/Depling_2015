xquery version "3.0" encoding "utf-8";

declare variable $p := doc("path-of-the-file");
declare variable $b := collection("path-of-VerbNet");

<r>{
let $t := 

for $h in $p/FRAMES/c/FRAME
let $o := 
if ($h[.//S]) then

$b//MEMBER/@name[. = $h/@verb-gloss]/ancestor::VNCLASS//FRAME/DESCRIPTION[@primary/normalize-space(replace(., "(that)|(_INF)|(_ING)", "")) = $h/@primary]

else 

$b//MEMBER/@name[. = $h/@verb-gloss]/ancestor::VNCLASS//FRAME/DESCRIPTION[@primary/replace(., "(\p{L})(\.)(\p{L}*)", "$1") = $h/@primary]

where $o

return

<same_argument_structure >
<AG>{$h}</AG>
<E><VNCLASS ID="{$o/ancestor::VNCLASS/attribute::ID}"><MEMBERS>{
  
  $o/ancestor::VNCLASS//MEMBER/data(@name)}</MEMBERS>
  {$o/parent::FRAME/child::*[name(.) = "DESCRIPTION" or name(.) = "EXAMPLES" or name(.) = "SYNTAX"] 
  }</VNCLASS></E>
</same_argument_structure>

for $y at $count in $t
return
<r n="{$count}">{$y}</r>
}</r>

