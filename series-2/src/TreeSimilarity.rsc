module TreeSimilarity

import TreeMass;

import IO;
import util::Math;

real getSimilarityFactor(subTreeA, subTreeB)
{
    traversed = [];
    sharedNodes = 0;
    bottom-up visit (subTreeA) {
        case node origin: {
            visit (subTreeB) {
                case node clone: {
                    if (origin == clone && clone notin traversed) {
                        sharedNodes += 1;
                        traversed += origin;
                    }
                }
            }
        }
    }
    
    subTreeADifferentNodes = getTreeMass(subTreeA) - sharedNodes;
    subTreeBDifferentNodes = getTreeMass(subTreeB) - sharedNodes;
    
    return precision(toReal(2 * sharedNodes) / toReal((2 * sharedNodes) + subTreeADifferentNodes + subTreeBDifferentNodes), 2);
}