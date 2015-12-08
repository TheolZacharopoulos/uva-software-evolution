module CloneDetection::AbstractClonePairs

import CloneDetection::Sequences::StatementSequences;

import lang::java::m3::AST;
import Map;

anno int node @ uniqueKey;

alias Sequence  = list[node];
alias Sequences = list[Sequence];

data ClonePair  = sequence(Sequence origin, Sequence clone);

alias ClonePairs = map[set[int], ClonePair];


@doc{
Factory for creating new empty clone pairs
}
ClonePairs newClonePairs() = ();

@doc{
Adds clone pair to the list
}
ClonePairs addClonePair(Sequence origin, Sequence clone, ClonePairs clones) {
    clones[getSequenceUniqueKeys(origin)] = sequence(origin, clone);
    return clones;
}

ClonePairs addClonePair(node origin, node clone, ClonePairs clones) {
    clones[{origin@uniqueKey}] = sequence([origin], [clone]);
    return clones;
}

@doc{
Removes clone pair and returns the new clone set as a result
}
ClonePairs removeCloneFromClonePairs(node subTree, ClonePairs clones) = delete(clones, {subTree@uniqueKey}) when clones[{subTree@uniqueKey}]?;

ClonePairs removeCloneFromClonePairs(Sequence subTree, ClonePairs clones) {
    set[int] uniqueKeys = getSequenceUniqueKeys(subTree);
    
    if (clones[uniqueKeys]?) {
        return delete(clones, uniqueKeys);
    }
    
    return clones;
}

@doc{
If the previous removesClone override does not match - return the clone pairs map as it was
}
default ClonePairs removeCloneFromClonePairs(subTree, ClonePairs clones) = clones;

@doc{
    Removes sequence subclones of a given sequence
}
ClonePairs removeSequenceSubclones(Sequence origin, Sequence clone, ClonePairs clones) {
    originKeys = getSequenceUniqueKeys(origin);
    cloneKeys  = getSequenceUniqueKeys(clone);
    
    allKeys = originKeys + cloneKeys;
    
    for (hashKeys <- clones, allKeys > hashKeys) {
        clones = delete(clones, hashKeys);
    }
    
    return clones;
}

@doc{
Extracts all unique keys from a sequence
}
set[int] getSequenceUniqueKeys(Sequence sequence) {
    uniqueKeys = {statement@uniqueKey | statement <- sequence};
    
    return uniqueKeys;
}