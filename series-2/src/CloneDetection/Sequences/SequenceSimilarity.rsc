module CloneDetection::Sequences::SequenceSimilarity

import CloneDetection::Statements::TreeSimilarity;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::AbstractClonePairs;

import List;

anno int node @ uniqueKey;

private map[tuple[int, int, int], real] sequenceSimilarityCache = ();

@doc{
Finds similarity factor based on two sequences
}
real getSimilarityFactor(Sequence sequenceA, Sequence sequenceB) {
    
    sequenceAFirstStmt = sequenceA[0];
    sequenceBFirstStmt = sequenceB[0];
    
    cacheKey = <sequenceAFirstStmt@uniqueKey, sequenceBFirstStmt@uniqueKey, size(sequenceA)>;

    if (sequenceSimilarityCache[cacheKey]?) return sequenceSimilarityCache[cacheKey];

    factor = (
        0.0
      | it + getSimilarityFactor(sequenceA[currentIndex], sequenceB[currentIndex]) 
      | currentIndex <- index(sequenceA),
        statementA := sequenceA[currentIndex],
        statementB := sequenceB[currentIndex],
        statementA@uniqueKey != statementB@uniqueKey
    ) / size(sequenceA);
    
    
    cacheKeyMirrored = <sequenceBFirstStmt@uniqueKey, sequenceAFirstStmt@uniqueKey, size(sequenceA)>;
    
    sequenceSimilarityCache[cacheKey] = factor;
    sequenceSimilarityCache[cacheKeyMirrored] = factor;
    
    return factor;
}
