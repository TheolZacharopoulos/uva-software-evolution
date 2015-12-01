module CloneDetection::Utils::SimilarityCache

import CloneDetection::AbstractClonePairs;
import List;
import IO;

anno int node @ uniqueKey;

private map[tuple[int treeA, int treeB] cacheKey, real similarityFactor] statementsCache = ();
private map[tuple[int treeA, int treeB, int length] cacheKey, real similarityFactor] sequencesCache = ();

@doc{
Adds similarity factor to cache using treeID
}
void cacheSimilarity(node treeA, node treeB, real similarityFactor) {
    statementsCache[<treeA@uniqueKey, treeB@uniqueKey>] = similarityFactor;
    statementsCache[<treeB@uniqueKey, treeA@uniqueKey>] = similarityFactor;
}

void cacheSimilarity(Sequence sequenceA, Sequence sequenceB, real similarityFactor) {
    treeA = sequenceA[0];
    treeB = sequenceB[0];
    sequencesCache[<treeA@uniqueKey, treeB@uniqueKey, size(sequenceA)>] = similarityFactor;
    sequencesCache[<treeB@uniqueKey, treeA@uniqueKey, size(sequenceB)>] = similarityFactor;
}

@doc{
Check if similarity factor has been added to cache
}
bool isSimilarityCached(node treeA, node treeB) = statementsCache[<treeA@uniqueKey, treeB@uniqueKey>]?;

bool isSimilarityCached(Sequence sequenceA, Sequence sequenceB) {
    treeA = sequenceA[0];
    treeB = sequenceB[0];
    
    return sequencesCache[<treeA@uniqueKey, treeB@uniqueKey, size(sequenceA)>]?;
}

@doc{
Get cached similarity factor for a tree
}
real getCachedSimilarity(node treeA, node treeB) = statementsCache[<treeA@uniqueKey, treeB@uniqueKey>];

real getCachedSimilarity(Sequence sequenceA, Sequence sequenceB) {
    treeA = sequenceA[0];
    treeB = sequenceB[0];
    
    //println("Getting cached similarity...");
    
    return sequencesCache[<treeA@uniqueKey, treeB@uniqueKey, size(sequenceA)>];
}