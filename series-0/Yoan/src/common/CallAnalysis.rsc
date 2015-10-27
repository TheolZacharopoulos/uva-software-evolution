module common::CallAnalysis

import Set;
import Relation;
import analysis::graphs::Graph;

alias Proc = str;

rel[Proc, Proc] Calls = {<"a", "b">, <"b", "c">, <"b", "d">, <"d", "c">, <"d", "e">, <"f", "e">, <"f", "g">, <"g", "e">};
