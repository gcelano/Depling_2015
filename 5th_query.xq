declare variable $p := doc("path-of-the-query");

<FRAMES>{
let $k := 
let $o := <d>{distinct-values($p//FRAME/@signature)}</d>
for $t in tokenize($o, "\s")
return
<r>{$t}</r>

for $i at $count in $k
let $o := $p//FRAME[@signature = $i]
return
<c n="{$count}">{$o[1]}</c>
}</FRAMES>
