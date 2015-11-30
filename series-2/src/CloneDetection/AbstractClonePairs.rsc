module CloneDetection::AbstractClonePairs

import lang::java::jdt::m3::AST;

anno int node @ uniqueKey;

alias Sequence  = list[node];
alias Sequences = list[Sequence];

data ClonePair  = sequence(Sequence origin, Sequence clone);

alias ClonePairs = map[int, ClonePair];

alias ClonePairsSeq = map[set[int], ClonePair];

@doc{
Adds clone pair to the list
}
ClonePairs addCloneToClonePairs(Sequence origin, Sequence clone, ClonePairs clones) {
    firstStatement = origin[0];
    clones[firstStatement@uniqueKey] = sequence(origin, clone);
    return clones;
}

ClonePairs addCloneToClonePairs(node origin, node clone, ClonePairs clones) {
    clones[origin@uniqueKey] = sequence([origin], [clone]);
    return clones;
}

@doc{
Factory for creating new empty clone pairs
}
ClonePairs newClonePairs() = ();

ClonePairsSeq newClonePairsSeq() = ();