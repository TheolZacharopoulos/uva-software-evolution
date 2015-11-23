module CloneDetection::Utils::ClonedTrees

import CloneDetection::Utils::TreeBucket;
import CloneDetection::Utils::StatementSequences;

import lang::java::jdt::m3::AST;

anno int Statement @ uniqueKey;

data Clone = occurrance(Statement origin, Statement clone)
           | occurrance(Sequences seqOrigin, Sequences seqClone);

alias Clones = list[Clone];

@doc{
Factory for creating new empty clone sets
}
Clones newClones() = [];

@doc{
Add clone pairs. Supports both nodes and sets of nodes.
}
Clones addClone(&E origin, &E clone, Clones clones) {
    
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
Clones removeClone(Statement subTree, Clones clones) {
    return [pairs | pairs <- clones, occurrance(origin, clone) := pairs, clone@uniqueKey != subTree@uniqueKey];
}

@doc{
Removes clone seuqnce pair and returns the new clone set as a result
}
Clones removeClone(Sequence clone, Clone clones) {
    return [
        pairs | pairs <- clones,
        occurance(Sequences origins, Sequences clones) := pairs, 
        cloneSeq <- clones,
        all(statement <- cloneSeq, cloneStatement <- clone, statement@uniqueKey != cloneStatement@uniqueKey)
    ];
}

Clones clearSubTrees(tree, Clones clones) = clearSubTrees(tree, clones, #Statement);

@doc{
Removes all sub tree that may occur in the clone results
}
Clones clearSubTrees(tree, Clones clones, \type) {
    bottom-up visit (tree) {
        case \type subTree: {
            if (subTreeExists(subTree, clones) && subTree@uniqueKey != tree@uniqueKey) {
                clones = removeClone(subTree, clones);
            }
        }
    }
    
    return clones;
}

@doc{
Removes all sub sequences that may occur in the clone results
}
Clones clearSubSequences(Sequence tree, Clones clones) {
    treeUniqueKeys = getSequenceUniqueKeys(tree);
    bottom-up visit (tree) {
        case Sequence subTree: {
            subTreeUniqueKeys = getSequenceUniqueKeys(subTree);
            if (subSequenceExists(subTree, clones) && treeUniqueKeys != subTreeUniqueKeys) {
                clones = removeClone(subTree, clones);
            }
        }
    }
    
    return clones;
}

@doc{
Detect clones in bucket using similarity threshold
}
Clones detectClonesInBucket(Bucket bucket, similarityThreshold) {
    
    clones = newClones();

    for (origin <- bucket, 
        clone <- bucket, 
        clone@uniqueKey != origin@uniqueKey, 
        getSimilarityFactor(origin, clone) >= similarityThreshold) 
    {
        clones = clearSubTrees(origin, clones);
        clones = clearSubTrees(clone, clones);
        clones = addClone(origin, clone, clones);
    }
    
    return clones;
}

@doc{
Detect if node (or node set) has already been registered in the results
}
bool subTreeExists(subTree, Clones clones) {
    return (false | true | occurrance(origin, clone) <- clones, origin == subTree || clone == subTree);
}

@doc{
Detect if node (or node set) has already been registered in the results
}
bool subSequenceExists(Sequence subSequence, Clones clones) = subTreeExists(subSequence, clones);

@doc{
TODO Write test for this
Check if two occurrances are mirrored
}
bool isMirrored(occurrance(Statement origin, Statement clone), occurrance(Statement newOrigin, Statement newClone)) {
    return origin@uniqueKey == newClone@uniqueKey && clone@uniqueKey == newOrigin@uniqueKey;
}

@doc{
TODO Write test for this
Check if two sequence occurrances are mirrored
}
bool isMirrored(occurrance(Sequence origin, Sequence clone), occurrance(Sequence newOrigin, Sequence newClone)) {
    return getSequenceUniqueKeys(origin) == getSequenceUniqueKeys(newClone)
        && getSequenceUniqueKeys(clone) == getSequenceUniqueKeys(newOrigin);
}

@doc{
Extract potentionally cloned sequences from the list of all sequences 
}
Sequences getSequencesContainingClones(Sequences sequences, Clones clones) {
    return [
        sequence | sequence <- sequences, 
        statement <- sequence,
        occurrance(origin, clone) <- clones,
        origin@uniqueKey == statement@uniqueKey || clone@uniqueKey == statement@uniqueKey
    ];
}