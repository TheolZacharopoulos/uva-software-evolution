module CloneDetection::Utils::TreeSimilarity

import CloneDetection::Utils::TreeMass;

import Set;
import Node;
import util::Math;

anno bool node @ similarityAlgorithmSkip;

// Quick check for identical trees
real getSimilarityFactor(subTreeA, subTreeB) = 1.0 when subTreeA == subTreeB;

// TODO add types here. Use pattern matching for set[node] cases
real getSimilarityFactor(subTreeA, subTreeB) {
    
    subTreeB = bottom-up visit (subTreeB) {
        case node clone: {
            clone = clone@similarityAlgorithmSkip = false;
            insert clone;
        }
    }
    
    sharedNodes = 0;
    
    bottom-up visit (subTreeA) {
        case node origin: {
            subTreeB = bottom-up-break visit (subTreeB) {
                case node clone: {
                    if (clone == origin && clone@similarityAlgorithmSkip == false) {
                        sharedNodes += 1;
                        clone = clone@similarityAlgorithmSkip = true;
                        insert clone;
                    } else fail;
                }
            }
        }
    }
    
    subTreeADifferentNodes = getTreeMass(subTreeA) - sharedNodes;
    subTreeBDifferentNodes = getTreeMass(subTreeB) - sharedNodes;
    
    return precision(toReal(2 * sharedNodes) / toReal((2 * sharedNodes) + subTreeADifferentNodes + subTreeBDifferentNodes), 2);
}