module CloneDetection::Sequences::CloneSequencePairs

import CloneDetection::AbstractClonePairs;
import CloneDetection::Sequences::StatementSequences;

import Map;

@doc{
Adds sequence clone pair
}
ClonePairsSeq addSeqClone(Sequence origin, Sequence clone, ClonePairsSeq clones) {
    clones[getSequenceUniqueKeys(origin)] = <origin, clone>;
    
    return clones;
}

ClonePairsSeq removeSequenceSubclones(Sequence origin, Sequence clone, ClonePairsSeq clones) {
    originKeys = getSequenceUniqueKeys(origin);
    cloneKeys  = getSequenceUniqueKeys(clone);
    
    for (hashKeys <- clones, originKeys > hashKeys || cloneKeys > hashKeys) {
        clones = delete(clones, hashKeys);
    }
    
    return clones;
}

ClonePairsSeq clearSequenceSubclones() {
    // TODO:
    return newClonePairsSeq();
}