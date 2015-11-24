module CloneDetection::Utils::Sequences::SequenceSimilarity

import CloneDetection::Utils::TreeSimilarity;
import CloneDetection::Utils::Sequences::StatementSequences;
import CloneDetection::AbstractClonePairs;

@doc{
Finds similarity factor based on two sequences
}
real getSimilarityFactor(Sequences sequenceA, Sequences sequenceB) {    
    // TODO optimize by using cached factors as annotations
    return (
        0.0
      | it + getSimilarityFactor(sequenceA[currentIndex], sequenceB[currentIndex]) 
      | currentIndex <- index(sequenceA),
        sequenceA[currentIndex]@uniqueKey != sequenceB[currentIndex]@uniqueKey
    ) / size(sequenceA);  
}
