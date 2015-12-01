module CloneDetection::Statements::TreeSimilarity

import Configurations;
import CloneDetection::Statements::TreeMass;
import CloneDetection::Utils::SimilarityCache;

import Set;
import Node;
import util::Math;
import lang::java::jdt::m3::AST;

anno int node @ uniqueKey;

real getSimilarityFactor(subTreeA, subTreeB) 
    = getCachedSimilarity(subTreeA, subTreeB) when isSimilarityCached(subTreeA, subTreeB);

@doc{
Quick check for identical trees
}
real getSimilarityFactor(subTreeA, subTreeB) = 1.0 when subTreeA == subTreeB;

@doc{
Get similarity factor using two statements
}
real getSimilarityFactor(node subTreeA, node subTreeB) {
    
    subTreeAMass = getTreeMass(subTreeA);
    subTreeBMass = getTreeMass(subTreeB);
    
    set[node] subTreeANodes = collectNodes(subTreeA);
    set[node] subTreeBNodes = collectNodes(subTreeB);
    
    // Find shared nodes.
    set[node] shared = { sharedNode |                        
        origin <- subTreeANodes,
        clone <- subTreeBNodes,
        clone == origin,
        clone@uniqueKey != origin@uniqueKey,
        //abs(getTreeMass(clone) - getTreeMass(origin)) < TREE_DIFF_MASS_THRESHOLD,
        sharedNode := clone
    };
    
    sharedNodes = size(shared);
    
    subTreeADifferentNodes = subTreeAMass - sharedNodes;
    subTreeBDifferentNodes = subTreeBMass - sharedNodes;
    
    // TODO remove precision
    real similarityFactor = toReal(2 * sharedNodes) / toReal((2 * sharedNodes) + subTreeADifferentNodes + subTreeBDifferentNodes);
    
    // Cache similarity
    cacheSimilarity(subTreeA, subTreeB, similarityFactor);
    
    return similarityFactor;
}

private set[node] collectNodes(node subTree) = getSubNodesCached(subTree) when areSubNodesCached(subTree);

@doc{
Collects children nodes in depth from a tree
}
private set[node] collectNodes(node subTree) {
    set[node] subTreeNodes = {};
    
    visit (subTree) {
        case Statement n: subTreeNodes += n;
        case Declaration n: subTreeNodes += n;
    }
    
    cacheSubNodes(subTree, subTreeNodes);

    return subTreeNodes;
}