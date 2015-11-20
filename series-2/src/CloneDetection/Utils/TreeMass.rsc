module CloneDetection::Utils::TreeMass

@doc {
    Get the tree mass (number of nodes) of a given tree.
}
int getTreeMass(node tree) {
    c = 0;
    bottom-up visit (tree) {
        case node t: {
            c += 1;
        }
    }    
    return c;
}

int getTreeMass(set[node] trees) = (0 | it + getTreeMass(subTree) | subTree <- trees);