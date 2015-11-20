module CloneDetection::Utils::TreeSimilarity

import Configurations;
import CloneDetection::Utils::TreeMass;

import Set;
import Node;
import util::Math;
import IO;

anno int node @ uniqueKey;
anno bool node @ similarityAlgorithmSkip;

// Quick check for identical trees
real getSimilarityFactor(subTreeA, subTreeB) = 1.0 when subTreeA == subTreeB;

// TODO add types here. Use pattern matching for set[node] cases
real getSimilarityFactor(subTreeA, subTreeB) {
    
    subTreeAMass = getTreeMass(subTreeA);
    subTreeBMass = getTreeMass(subTreeB);
    
    subTreeB = bottom-up visit (subTreeB) {
        case node clone: {
            clone = clone@similarityAlgorithmSkip = false;
            insert clone;
        }
    }
    
    set[node] shared = {};
    
    bottom-up visit (subTreeA) {
        case node origin: {
            originMass = getTreeMass(origin);
            bottom-up-break visit (subTreeB) {
                case node clone: {
                    if (clone == origin 
                        && clone@uniqueKey != origin@uniqueKey
                        && abs(getTreeMass(clone) - originMass) < TREE_DIFF_MASS_THRESHOLD) {
                        shared += clone;
                    } else fail;
                }
            }
        }
    }
    
    sharedNodes = size(shared);
    
    subTreeADifferentNodes = subTreeAMass - sharedNodes;
    subTreeBDifferentNodes = subTreeBMass - sharedNodes;
    
    //println("<subTreeADifferentNodes> to <subTreeBDifferentNodes>/<sharedNodes> = <precision(toReal(2 * sharedNodes) / toReal((2 * sharedNodes) + subTreeADifferentNodes + subTreeBDifferentNodes), 2)>");
    
    if (subTreeADifferentNodes < 0 || subTreeBDifferentNodes < 0) {
        iprintToFile(|project://Series-2/debug/| + "debug-tree-<subTreeA@uniqueKey>.txt", subTreeA);
        iprintToFile(|project://Series-2/debug/| + "debug-tree-<subTreeB@uniqueKey>.txt", subTreeB);
    }
    
    return precision(toReal(2 * sharedNodes) / toReal((2 * sharedNodes) + subTreeADifferentNodes + subTreeBDifferentNodes), 2);
}