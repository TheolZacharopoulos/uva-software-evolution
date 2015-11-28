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

anno int node @ uniqueKey;

@doc{
Removes clone pair and returns the new clone set as a result
}
ClonePairs removeCloneFromClonePairs(node subTree, ClonePairs clones) = delete(clones, subTree@uniqueKey) when clones[subTree@uniqueKey]?;

@doc{
If the previous removesClone override does not match - return the clone pairs map as it was
}
default ClonePairs removeCloneFromClonePairs(node subTree, ClonePairs clones) = clones;

@doc{
Removes all sub tree that may occur in the clone results
}
ClonePairs clearSubTrees(tree, ClonePairs clones) {
    bottom-up visit (tree) {
        case Statement subTree: {
            if (doesSubTreeExist(subTree, clones) && subTree@uniqueKey != tree@uniqueKey) {
                clones = removeCloneFromClonePairs(subTree, clones);
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
            clones = addCloneToClonePairs(originSubtree, cloneSubtree, clones);
        }
    }    
    return clones;
}

bool doesSubTreeExist(Statement subTree, ClonePairs clones) {
    
    // TODO: Fix this
    
    return clones[subTree@uniqueKey]?;

    for (cloneKey <- clones, 
        <Statement origin, Statement clone> := clones[cloneKey], 
        origin == subTree) 
    {
        cacheSubTreeExistance(subTree@uniqueKey);
        return true;
    }
    return false;
}