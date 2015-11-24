module CloneDetection::Statements::CloneStatementPairs

import CloneDetection::AbstractClonePairs;
import CloneDetection::Statements::TreeBucket;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::Statements::TreeSimilarity;
import CloneDetection::Utils::TreeExistanceCache;

import lang::java::jdt::m3::AST;

import Map;
import List;
import IO;

anno int Statement @ uniqueKey;

@doc{
Removes clone pair and returns the new clone set as a result
}
ClonePairs removeClone(subTree, ClonePairs clones) {
    return [pairs | pairs <- clones, occurrance(origin, clone) := pairs, clone@uniqueKey != subTree@uniqueKey];
}

@doc{
Removes all sub tree that may occur in the clone results
}
ClonePairs clearSubTrees(tree, ClonePairs clones) {
    bottom-up visit (tree) {
        case Statement subTree: {
            if (doesSubTreeExist(subTree, clones) && subTree@uniqueKey != tree@uniqueKey) {
                clones = removeClone(subTree, clones);
            }
        }
    }    
    return clones;
}

@doc{
Detect clones in buckets using similarity threshold
}
ClonePairs detectClonesInBuckets(Buckets buckets, similarityThreshold) {
    
    clones = newClonePairs();
    
    // loop over all buckets, filter out buckets with one subtree
    for (bucketKey <- buckets, size(buckets[bucketKey]) > 1) {
    
        // loop over the subtrees on the same bucket.
        for (originSubtree <- buckets[bucketKey],
            cloneSubtree <- buckets[bucketKey],
            cloneSubtree@uniqueKey != originSubtree@uniqueKey,
            getSimilarityFactor(originSubtree, cloneSubtree) >= similarityThreshold)
        {
            clones = clearSubTrees(originSubtree, clones);
            clones = clearSubTrees(cloneSubtree, clones);
            clones = addClone(originSubtree, cloneSubtree, clones);
        }
    }    
    return clones;
}

bool doesSubTreeExist(Statement subTree, ClonePairs clones) = true when isSubTreeExistanceCached(subTree@uniqueKey);

bool doesSubTreeExist(Statement subTree, ClonePairs clones) {
    for (occurrance(Statement origin, Statement clone) <- clones, origin == subTree) {
        cacheSubTreeExistance(subTree@uniqueKey);
        return true;
    }
    return false;
}