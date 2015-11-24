module CloneDetection::Utils::Sequences::CloneSequencePairs

import CloneDetection::AbstractClonePairs;
import CloneDetection::Utils::Sequences::StatementSequences;

@doc{
Add sequence clone pairs
}
ClonePairs addClone(Sequence origin, Sequence clone, ClonePairs clones) = clones + occurrance(origin, clone);

ClonePairs clearSequenceSubclones() {
    // TODO:
    return newClonePairs();
}