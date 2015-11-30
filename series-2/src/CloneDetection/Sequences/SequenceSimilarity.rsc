module CloneDetection::Sequences::SequenceSimilarity

import CloneDetection::Statements::TreeSimilarity;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::AbstractClonePairs;

import List;

anno int Statement @ uniqueKey;
anno int Declaration @ uniqueKey;

@doc{
Finds similarity factor based on two sequences
}
real getSimilarityFactor(Sequence sequenceA, Sequence sequenceB) {
    return (
        0.0
      | it + getSimilarityFactor(sequenceA[currentIndex], sequenceB[currentIndex]) 
      | currentIndex <- index(sequenceA),
        statementA := sequenceA[currentIndex],
        statementB := sequenceB[currentIndex],
        statementA@uniqueKey != statementB@uniqueKey
    ) / size(sequenceA);  
}
