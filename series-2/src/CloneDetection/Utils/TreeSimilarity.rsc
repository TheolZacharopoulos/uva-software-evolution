module CloneDetection::Utils::TreeSimilarity

import Configurations;
import CloneDetection::Utils::TreeMass;

import Set;
import Node;
import util::Math;
import lang::java::jdt::m3::AST;

anno int node @ uniqueKey;
anno bool node @ similarityAlgorithmSkip;

// Quick check for identical trees
real getSimilarityFactor(subTreeA, subTreeB) = 1.0 when subTreeA == subTreeB;

@doc{
Get similarity factor using two statements
}
real getSimilarityFactor(Statement subTreeA, Statement subTreeB) {
    
    subTreeAMass = getTreeMass(subTreeA);
    subTreeBMass = getTreeMass(subTreeB);
    
    // Collect nodes for subTree A
    set[node] subTreeANodes = {};
    visit (subTreeA) {
        case node n: subTreeANodes += n;
    }
    // Collect nodes for subTree B
    set[node] subTreeBNodes = {};
    visit (subTreeB) {
        case node n: subTreeBNodes += n;
    }
    
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
    return precision(toReal(2 * sharedNodes) / toReal((2 * sharedNodes) + subTreeADifferentNodes + subTreeBDifferentNodes), 2);
}