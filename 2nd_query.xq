xquery version "3.0" encoding "utf-8";

declare variable $p := doc("path-of-the-file");

<FRAMES>{
for $r at $count in $p//word[@postag[matches(., "v....a...")]]
(: [@postag[not(matches(., "v3s......"))]] :)

let $s := $r/word[@relation="SBJ"]
[@postag[matches(., "n........")] or (@postag[matches(., "a........")] and @sg[matches(., "sbs")]) or (@postag[matches(., "p........")] and @sg[matches(., "sbs")])   or (@postag[matches(., "v.p......")] and @sg[matches(., "sbs")]) or (@postag[matches(., "v........")] and @sg[matches(., "art")])]

let $s2 := $r/word[@relation="SBJ"]
[(@postag[matches(., "v........")] and @sg[matches(., "vrb")])  or (@postag[matches(., "v........")] and (@sg[matches(., "spl")] or    @sg[matches(., "prp")]))]

let $o := $r/word[@relation="OBJ"]
[@postag[matches(., "n........")] or (@postag[matches(., "a........")] and @sg[matches(., "sbs")]) or (@postag[matches(., "p........")] and @sg[matches(., "sbs")])   or (@postag[matches(., "v.p......")] and @sg[matches(., "sbs")]) or (@postag[matches(., "v........")] and @sg[matches(., "art")])]

let $l := $r/word[@relation="OBJ"][(@postag[matches(., "v........")] and @sg[matches(., "vrb")])  or (@postag[matches(., "v........")] and (@sg[matches(., "spl")] or    @sg[matches(., "prp")]))]

let $m := $r/word[@relation="PNOM"][@postag[matches(., "n........")] or (@postag[matches(., "a........")] and @sg[matches(., "sbs")]) or (@postag[matches(., "p........")] and @sg[matches(., "sbs")])   or (@postag[matches(., "v.p......")] and @sg[matches(., "sbs")]) or (@postag[matches(., "v........")] and @sg[matches(., "art")])]

let $p := $r/word[@relation="PNOM"][@postag[matches(., "a........")]][@sg[matches(., "prp")]]

let $k := $r/word[@relation="PNOM"][(@postag[matches(., "v........")] and @sg[matches(., "vrb")])  or (@postag[matches(., "v........")] and (@sg[matches(., "spl")] or    @sg[matches(., "prp")]))]

let $n := $r/word[@relation="AuxP"]/word[@relation="OBJ"]

let $w := $r/word[@relation="AuxC"]/word[@relation="OBJ"]

let $y := $r/word[@relation="AuxC"]/word[@relation="COORD"]/word[@relation="OBJ_CO"]

return

<FRAME id="{$count}" verb-lemma="{$r/@lemma}" verb-gloss="{$r/@gloss}" sentence="{$r/ancestor::sentence/@id}">
<sentence>{for $g in $r/ancestor::sentence/descendant::word order by number($g/@id) return $g/data(@form)}</sentence>
<SYNTAX>

{
if ($s) then
for $t in $s
return
<NP gr="SBJ">
{$s}
</NP>
else 
if ($s2) then
for $t in $s2
return
<S gr="SBJ">
{$s2}
</S>
else 

<NP gr="SBJ"> 
</NP>
}

<V>{$r}</V>

{
if ($p) then  
for $t in $p
return

<ADJ gr="PNOM">
{$t}
</ADJ>

else ""
}

{
if ($m) then
for $t in $m
return
<NP gr="PNOM">
{$t}
</NP>
else ""
}

{
if ($k) then  
for $t in $k
return

<S gr="PNOM">
{$t}
</S>

else ""
}

{
if ($o) then
for $t in $o
return
<NP gr="OBJ">
{$t}
</NP>
else ""
}

{
if ($l) then
for $t in $l
return
<S gr="OBJ">
{$t}
</S>
else ""
}

{
if ($n) then
for $k in $n 
return
<PP gr="AuxP_OBJ" prep="{$m/parent::word/@lemma}">
{$k}
</PP>
else ""
}

{
if ($w) then
for $k in $w 
return
<S gr="AuxC_SBJ" cnj="{$w/parent::word/@lemma}">
{$k}
</S>
else ""
}

{
if ($y) then
for $k in $y 
return
<S gr="AuxC_COORD_SBJ" cnj="{$w/parent::word/parent::word/@lemma}">
{$k}
</S>
else ""
}

</SYNTAX>
</FRAME>
}</FRAMES>
