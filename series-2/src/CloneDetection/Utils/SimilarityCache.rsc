module CloneDetection::Utils::SimilarityCache

private map[tuple[int treeAKey, int treeBKey] cacheKey, real similarityFactor] cache = ();

@doc{
Adds similarity factor to cache using treeID
}
void cacheSimilarity(int treeAKey, int treeBKey, real similarityFactor) {
    cache[<treeAKey, treeBKey>] = similarityFactor;
    cache[<treeBKey, treeAKey>] = similarityFactor;
}

@doc{
Check if similarity factor has been added to cache
}
bool isSimilarityCached(int treeAKey, int treeBKey) = cache[<treeAKey, treeBKey>]?;

@doc{
Get cached similarity factor for a tree
}
real getCachedSimilarity(int treeAKey, int treeBKey) = cache[<treeAKey, treeBKey>];