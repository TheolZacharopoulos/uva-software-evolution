module CloneDetection::Sequences::SequenceSimilarity

import CloneDetection::Statements::TreeSimilarity;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::ClonePairs;
import CloneDetection::Utils::SimilarityCache;

import List;

anno int node @ uniqueKey;

real getSimilarityFactor(Sequence sequenceA, Sequence sequenceB) 
    = getCachedSimilarity(sequenceA, sequenceB) when isSimilarityCached(sequenceA, sequenceB);

@doc{
Finds similarity factor based on two sequences
}
real getSimilarityFactor(Sequence sequenceA, Sequence sequenceB) {

    factor = (
        0.0
      | it + getSimilarityFactor(sequenceA[currentIndex], sequenceB[currentIndex]) 
      | currentIndex <- index(sequenceA),
        statementA := sequenceA[currentIndex],
        statementB := sequenceB[currentIndex],
        statementA@uniqueKey != statementB@uniqueKey
    ) / size(sequenceA);
    
    cacheSimilarity(sequenceA, sequenceB, factor);
    
    return factor;
}
