module CloneDetection::Sequences::SequenceSimilarity

import CloneDetection::Statements::TreeSimilarity;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::AbstractClonePairs;

import List;

@doc{
Finds similarity factor based on two sequences
}
real getSimilarityFactor(Sequence sequenceA, Sequence sequenceB) {    
    // TODO optimize by using cached factors as annotations
    return (
        0.0
      | it + getSimilarityFactor(sequenceA[currentIndex], sequenceB[currentIndex]) 
      | currentIndex <- index(sequenceA),
        sequenceA[currentIndex]@uniqueKey != sequenceB[currentIndex]@uniqueKey
    ) / size(sequenceA);  
}
