module CloneDetection::Utils::SequenceSimilarity

import CloneDetection::Utils::TreeSimilarity;
import CloneDetection::Utils::StatementSequences;

@doc{
Finds similarity factor based on two sequences
}
real getSimilarityFactor(Sequences sequenceA, Sequences sequenceB) {    
    return (
        0.0
      | it + getSimilarityFactor(treeA, treeB) 
      | treeA <- sequenceA, treeB <- sequenceB,
        treeA@uniqueKey != treeB@uniqueKey
    )/size(sequenceA);  
}
