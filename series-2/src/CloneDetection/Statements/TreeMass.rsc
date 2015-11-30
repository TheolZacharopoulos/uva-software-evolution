module CloneDetection::Statements::TreeMass

import Node;
import List;
import lang::java::jdt::m3::AST;

@doc {
    Get the tree mass (number of nodes) of a given tree.
}
int getTreeMass(tree) {
    mass = 0;
    bottom-up visit (tree) {
        case Statement t: {
            mass += 1;
        }
        
        case Expression t: {
            mass += 1;
        }
    }
    
    return mass;
}