module CloneDetection::Utils::TreeExistanceCache

private set[int] subTreeExistanceCache = {};

void cacheSubTreeExistance(int treeKey) {
    subTreeExistanceCache += treeKey;
}

bool isSubTreeExistanceCached(int treeKey) = treeKey in subTreeExistanceCache;