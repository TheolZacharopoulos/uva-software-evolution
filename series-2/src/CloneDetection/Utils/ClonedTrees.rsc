module CloneDetection::Utils::ClonedTrees

data Clone = occurance(node origin, node clone)
           | occurance(set[node] setOrigin, set[node] setClone);

alias Clones = set[Clone];

@doc{
Factory for creating new empty clone sets
}
Clones newClones() = {};

@doc{
Add clone pairs. Supports both nodes and sets of nodes.
}
Clones addClone(node origin, node clone, Clones clones) = clones + occurance(origin, clone);
Clones addClone(set[node] origin, set[node] clone, Clones clones) = clones + occurance(origin, clone);

@doc{
Removes clone pair and returns the new clone set as a result
}
Clones removeClone(subTree, Clones clones) {
    return {pairs | pairs <- clones, occurance(origin, clone) := pairs, origin != subTree, clone != subTree};
}

@doc{
Removes all sub tree that may occur in the clone results
}
Clones clearSubTreesFromSet(tree, Clones clones) {
    bottom-up visit (tree) {
        case node subTree: {
            if (subTreeExists(subTree, clones) && subTree != tree) {
                clones = removeClone(subTree, clones);
            }
        }
    }
    
    return clones;
}

@doc{
Detect if node (or node set) has already been registered in the results
}
bool subTreeExists(subTree, Clones clones) {
    return (false | true | occurance(origin, clone) <- clones, origin == subTree || clone == subTree);
}