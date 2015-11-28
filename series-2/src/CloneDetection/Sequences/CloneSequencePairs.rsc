module CloneDetection::Sequences::CloneSequencePairs

import CloneDetection::AbstractClonePairs;
import CloneDetection::Sequences::StatementSequences;

@doc{
Adds sequence clone pair
}
ClonePairsSeq addSeqClone(Sequence origin, Sequence clone, ClonePairsSeq clones) {
    clones[getSequenceUniqueKeys(origin)] = <origin, clone>;
    return clones;
}

ClonePairsSeq clearSequenceSubclones() {
    // TODO:
    return newClonePairsSeq();
}