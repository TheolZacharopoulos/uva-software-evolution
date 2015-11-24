module CloneDetection::Utils::CloneStatementPairs

import CloneDetection::Utils::TreeBucket;
import CloneDetection::Utils::Sequences::StatementSequences;
import Map;
import List;

// TODO change to Statement
anno int node @ uniqueKey;

// TODO change node to Statement
data Clone = occurrance(node origin, node clone) 
           | occurrance(Sequence originSeq, Sequence cloneSeq);

alias Clones = list[Clone];

@doc{
Factory for creating new empty clone sets
}
Clones newClones() = [];

@doc{
Add clone pairs. Supports both nodes and sets of nodes.
}
Clones addClone(node origin, node clone, Clones clones) {
    
    pair = occurrance(origin, clone);
    
    // prevent for adding the same twice
    for (existing <- clones, isMirrored(pair, existing)) {
        return clones;
    }
    
    return clones + pair;
}

@doc{
Removes clone pair and returns the new clone set as a result
}
Clones removeClone(subTree, Clones clones) {
    return [pairs | pairs <- clones, occurrance(origin, clone) := pairs, clone@uniqueKey != subTree@uniqueKey];
}

@doc{
Removes all sub tree that may occur in the clone results
}
Clones clearSubTrees(tree, Clones clones) {
    bottom-up visit (tree) {
        case node subTree: {
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
Clones detectClonesInBuckets(Buckets buckets, similarityThreshold) {
    
    clones = newClones();
    
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

@doc{
Detect if node (or node set) has already been registered in the results
}
bool doesSubTreeExist(subTree, Clones clones) {
    return (false | true | occurrance(origin, clone) <- clones, origin == subTree || clone == subTree);
}

@doc{
TODO Write test for this
Check if two occurrances are mirrored
}
bool isMirrored(occurrance(origin, clone), occurrance(newOrigin, newClone)) {
    return origin@uniqueKey == newClone@uniqueKey && clone@uniqueKey == newOrigin@uniqueKey;
}