module CloneDetection::Statements::TreeMass

import CloneDetection::Utils::TreeMassIndex;

import Exception;
import Node;
import List;
import IO;
import lang::java::m3::AST;

int getTreeMass(tree) = getTreeWeight(tree);

@doc {
Get the tree mass (number of nodes) of a given tree.
}
int calculateTreeMass(tree) {
    
    mass = 0;
    
    bottom-up visit (tree) {
        case Statement t: {
            mass += 1;
        }
        case Declaration t: {
            mass += 1;
        }
    }

    return mass;
}