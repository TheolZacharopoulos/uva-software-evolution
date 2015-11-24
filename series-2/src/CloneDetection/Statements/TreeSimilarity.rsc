module CloneDetection::Statements::TreeSimilarity

import Configurations;
import CloneDetection::Statements::TreeMass;

import Set;
import Node;
import util::Math;
import lang::java::jdt::m3::AST;

anno int Statement @ uniqueKey;

// Quick check for identical trees
real getSimilarityFactor(subTreeA, subTreeB) = 1.0 when subTreeA == subTreeB;

@doc{
Get similarity factor using two statements
}
real getSimilarityFactor(Statement subTreeA, Statement subTreeB) {
    
    subTreeAMass = getTreeMass(subTreeA);
    subTreeBMass = getTreeMass(subTreeB);
    
    // Collect nodes for subTree A
    set[Statement] subTreeANodes = {};
    visit (subTreeA) {
        case Statement n: subTreeANodes += n;
    }
    // Collect nodes for subTree B
    set[Statement] subTreeBNodes = {};
    visit (subTreeB) {
        case Statement n: subTreeBNodes += n;
    }
    
    // Find shared nodes.
    set[Statement] shared = { sharedNode |                        
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