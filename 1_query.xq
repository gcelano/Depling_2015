xquery version "3.0" encoding "utf-8";

(: This query has been written by Giuseppe G. A Celano and tested on BaseX 8.1.1 :)

(: This query has been written to check how many and which functional nodes (more precisely, COORD and AuxP nodes) 
   can be found in the text of Aesop: this helped me to write the query extracting argument structure, since I could avoid 
   writing a more complex algorithm :)

declare variable $p := doc("/Users/mycomputer/Documents/mywork/Depling2015/Nuovo/Polina2.xml");

let $a := for $t at $count in $p//word[@postag[matches(., "v........")]]/word[@relation="COORD"]
					return
					<coord n="{$count}" sentence="{$t/ancestor::sentence/@id}">
          {$t}
          </coord>

let $a2 := for $t at $count in $p//word[@postag[matches(., "v........")]]/word[@relation="COORD"]/word[relation="OBJ_CO"]
					return
					<coord_obj n="{$count}" sentence="{$t/ancestor::sentence/@id}">
          {$t}
          </coord_obj>          
                    
let $a3 := for $t at $count in $p//word[@postag[matches(., "v........")]]/word[@relation="COORD"]/word[relation="PNOM_CO"]
					return
					<coord_pnom n="{$count}" sentence="{$t/ancestor::sentence/@id}">
          {$t}
          </coord_pnom>  
          
let $a4 := for $t at $count in $p//word[@postag[matches(., "v........")]]/word[@relation="COORD"]/word[relation="SBJ_CO"]
					return
					<sbj_co n="{$count}" sentence="{$t/ancestor::sentence/@id}">
          {$t}
          </sbj_co>           
          
let $b := for $t at $count in $p//word[@postag[matches(., "v........")]]/word[@relation="COORD"]/word[@relation="COORD"]
					return
					<coord_coord n="{$count}" sentence="{$t/ancestor::sentence/@id}">
          {$t}
          </coord_coord>
let $c := for $t at $count in $p//word[@postag[matches(., "v........")]]/word[@relation="COORD"]/word[@relation="AuxP"]
					return
					<coord_AuxP n="{$count}" sentence="{$t/ancestor::sentence/@id}">
          {$t}
          </coord_AuxP>
                
let $d := for $t at $count in $p//word[@postag[matches(., "v........")]]/word[@relation="AuxP"]/word[@relation="COORD"]
					return
					<AuxP_coord n="{$count}" sentence="{$t/ancestor::sentence/@id}">
          {$t}
          </AuxP_coord>

let $c2 := for $t at $count in $p//word[@postag[matches(., "v........")]]/word[@relation="COORD"]/word[@relation="AuxC"]
					return
					<coord_AuxC n="{$count}" sentence="{$t/ancestor::sentence/@id}">
          {$t}
          </coord_AuxC>  

let $d2 := for $t at $count in $p//word[@postag[matches(., "v........")]]/word[@relation="AuxC"]/word[@relation="COORD"]/word[@relation="OBJ_CO"]
					return
					<AuxC_coord n="{$count}" sentence="{$t/ancestor::sentence/@id}">
          {$t}
          </AuxC_coord>

let $e := for $t at $count in $p//word[@postag[matches(., "v........")]][@relation[contains(., "_CO")]]
					return
					<verb_dep_CO n="{$count}" sentence="{$t/ancestor::sentence/@id}">
          {$t}
          </verb_dep_CO>     
          
let $f := for $t at $count in $p//word[@postag[matches(., "v........")]][@relation[contains(., "_CO")]]/parent::word[@relation="COORD"]/word[@relation[not(contains(., "_CO"))][not(contains(., "Aux"))][not(contains(., "COORD"))]]
					return
					<dep_coord n="{$count}" sentence="{$t/ancestor::sentence/@id}">
          {$t}
          </dep_coord>              
return
<r>{$a, $a2, $a3, $a4, $b, $c, $c2, $d, $d2, $e, $f}</r>
