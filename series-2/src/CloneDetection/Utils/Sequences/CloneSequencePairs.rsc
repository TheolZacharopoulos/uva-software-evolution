module CloneDetection::Utils::Sequences::CloneSequencePairs

import CloneDetection::Utils::CloneStatementPairs;
import CloneDetection::Utils::Sequences::StatementSequences;

@doc{
Add sequence clone pairs
}
Clones addClone(Sequence origin, Sequence clone, Clones clones) = clones + occurrance(origin, clone);

Clones clearSequenceSubclones() {
    
}