module CloneDetection::AbstractClonePairs

import lang::java::jdt::m3::AST;

alias Sequence = list[Statement];
alias Sequences = list[Sequence];

data ClonePair = occurrance(Statement origin, Statement clone)
               | occurrance(Sequence originSeq, Sequence cloneSeq);

alias ClonePairs = list[ClonePair];

@doc{
Adds clone pair to the list
}
ClonePairs addClone(origin, clone, ClonePairs clones) = clones + occurrance(origin, clone);

@doc{
Factory for creating new empty clone pairs
}
ClonePairs newClonePairs() = [];