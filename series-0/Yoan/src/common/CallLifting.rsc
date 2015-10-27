module common::CallLifting

import Set;
import Relation;
import analysis::graphs::Graph;

alias proc = str;
alias comp = str;

rel[proc, proc] Calls = {<"main", "a">, <"main", "b">, <"a", "b">, <"a", "d">, <"a", "c">, <"b", "d">};
rel[proc, comp] PartOfs = {<"main", "Appl">, <"a", "Appl">, <"b", "DB">, <"c", "Lib">, <"d", "Lib">};

public rel[comp,comp] lift(rel[proc,proc] aCalls, rel[proc,comp] aPartOf)
{
    return { 
            <C1, C2> | 
                <proc P1, proc P2> <- aCalls, 
                <comp C1, comp C2> <- aPartOf[P1] * aPartOf[P2]};
}

test bool testLift() = {
      <"Appl","Appl">,
      <"DB","Lib">,
      <"Appl","DB">,
      <"Appl","Lib">
    } == lift(Calls, PartOfs);
    