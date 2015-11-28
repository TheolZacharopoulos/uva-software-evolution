module CloneDetection::AbstractClonePairs

import lang::java::jdt::m3::AST;

anno int node @ uniqueKey;

alias Sequence  = list[node];
alias Sequences = list[Sequence];

alias ClonePair  = tuple[node origin, node clone];  
alias ClonePairs = map[int, ClonePair];

alias ClonePairSeq  = tuple[Sequence origin, Sequence clone];  
alias ClonePairsSeq = map[set[int], ClonePairSeq];

@doc{
Adds clone pair to the list
}
ClonePairs addCloneToClonePairs(origin, clone, ClonePairs clones) {
    clones[origin@uniqueKey] = <origin, clone>;
    return clones;
}

@doc{
Factory for creating new empty clone pairs
}
ClonePairs newClonePairs() = ();

ClonePairsSeq newClonePairsSeq() = ();