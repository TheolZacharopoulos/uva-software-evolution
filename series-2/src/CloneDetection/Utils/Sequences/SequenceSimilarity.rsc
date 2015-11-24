module CloneDetection::Utils::Sequences::SequenceSimilarity

import CloneDetection::Utils::TreeSimilarity;
import CloneDetection::Utils::Sequences::StatementSequences;

@doc{
Finds similarity factor based on two sequences
}
real getSimilarityFactor(Sequences sequenceA, Sequences sequenceB) {    
    // TODO optimize by using cached factors as annotations
    return (
        0.0
      | it + getSimilarityFactor(treeA, treeB) 
      | treeA <- sequenceA, treeB <- sequenceB,
        treeA@uniqueKey != treeB@uniqueKey
    )/size(sequenceA);  
}
