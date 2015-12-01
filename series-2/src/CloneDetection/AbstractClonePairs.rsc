module CloneDetection::AbstractClonePairs

import CloneDetection::Sequences::StatementSequences;

import lang::java::jdt::m3::AST;
import Map;

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

@doc{
Removes clone pair and returns the new clone set as a result
}
ClonePairs removeCloneFromClonePairs(node subTree, ClonePairs clones) = delete(clones, subTree@uniqueKey) when clones[subTree@uniqueKey]?;

ClonePairs removeCloneFromClonePairs(Sequence subTree, ClonePairs clones) {
    firstStatement = subTree[0];
    
    if (clones[firstStatement@uniqueKey]?) {
        return delete(clones, firstStatement@uniqueKey);
    }
    
    return clones;
}

@doc{
If the previous removesClone override does not match - return the clone pairs map as it was
}
default ClonePairs removeCloneFromClonePairs(subTree, ClonePairs clones) = clones;

@doc{
Factory for creating new empty clone sequence pairs
}
ClonePairsSeq newClonePairsSeq() = ();

@doc{
Adds sequence clone pair
}
ClonePairsSeq addSeqClone(Sequence origin, Sequence clone, ClonePairsSeq clones) {
    clones[getSequenceUniqueKeys(origin)] = sequence(origin, clone);
    
    return clones;
}

@doc{
    Removes sequence subclones of a given sequence
}
ClonePairsSeq removeSequenceSubclones(Sequence origin, Sequence clone, ClonePairsSeq clones) {
    originKeys = getSequenceUniqueKeys(origin);
    cloneKeys  = getSequenceUniqueKeys(clone);
    
    allKeys = originKeys + cloneKeys;
    
    for (hashKeys <- clones, allKeys > hashKeys) {
        clones = delete(clones, hashKeys);
    }
    
    return clones;
}