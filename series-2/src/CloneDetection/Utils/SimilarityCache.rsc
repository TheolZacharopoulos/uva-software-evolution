module CloneDetection::Utils::SimilarityCache

import CloneDetection::ClonePairs;
import List;
import IO;

anno int node @ uniqueKey;

@doc{
Cache database for statements (nodes)
}
private map[tuple[int treeA, int treeB] cacheKey, real similarityFactor] statementsCache = ();

@doc{
Cache database for squences
}
private map[tuple[int treeA, int treeB, int length] cacheKey, real similarityFactor] sequencesCache = ();

@doc{
Cache database for flattened nodes
}
private map[int, set[node]] subNodesCache = ();

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
    
    return sequencesCache[<treeA@uniqueKey, treeB@uniqueKey, size(sequenceA)>];
}

@doc{
Check if flattened tree has been cached
}
bool areSubNodesCached(node subTree) = subNodesCache[subTree@uniqueKey]?;

@doc{
Retrieves flattened tree from the cache
}
set[node] getSubNodesCached(node subTree) = subNodesCache[subTree@uniqueKey];

@doc{
Put flattened tree into cache
}
void cacheSubNodes(node subTree, set[node] subNodes) {
    subNodesCache[subTree@uniqueKey] = subNodes;
}