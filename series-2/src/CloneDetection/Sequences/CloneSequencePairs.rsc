module CloneDetection::Sequences::CloneSequencePairs

import CloneDetection::AbstractClonePairs;
import CloneDetection::Sequences::StatementSequences;

import Map;

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
    
    for (hashKeys <- clones, originKeys > hashKeys || cloneKeys > hashKeys) {
        clones = delete(clones, hashKeys);
    }
    
    return clones;
}