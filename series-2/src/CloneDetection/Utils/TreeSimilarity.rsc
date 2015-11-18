module CloneDetection::Utils::TreeSimilarity

import CloneDetection::Utils::TreeMass;

import Set;
import Node;
import util::Math;

import IO;

// Hack to make identical detection work
real getSimilarityFactor(subTreeA, subTreeB) = 1.0 when subTreeA == subTreeB;

// TODO add types here. Use pattern matching for set[node] cases
real getSimilarityFactor(subTreeA, subTreeB) {
    
    sharedNodes = 0;
    
    traversed = [];
    
    top-down visit (subTreeA) {
        case node origin: {
            top-down visit (subTreeB) {
                case node clone: {
                    if (clone == origin && clone notin traversed) {
                        sharedNodes += 1;
                        traversed += clone;
                    }
                }
            }
        }
    }
    
    subTreeADifferentNodes = getTreeMass(subTreeA) - sharedNodes;
    subTreeBDifferentNodes = getTreeMass(subTreeB) - sharedNodes;
    
    return precision(toReal(2 * sharedNodes) / toReal((2 * sharedNodes) + subTreeADifferentNodes + subTreeBDifferentNodes), 2);
}