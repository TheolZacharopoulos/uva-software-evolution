module CloneDetection::AbstractClonePairs

import lang::java::jdt::m3::AST;

alias Sequence = list[Statement];
alias Sequences = list[Sequence];

data ClonePair 
        = occurrance(node origin, node clone) // TODO: make this Statement
       | occurrance(Sequence originSeq, Statement cloneSeq);

alias ClonePairs = list[ClonePair];

@doc{
Factory for creating new empty clone pairs
}
ClonePairs newClonePairs() = [];