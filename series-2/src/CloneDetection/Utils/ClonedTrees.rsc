module CloneDetection::Utils::ClonedTrees

anno int node @ uniqueKey;

data Clone = occurrance(node origin, node clone)
           | occurrance(set[node] setOrigin, set[node] setClone);

alias Clones = list[Clone];

@doc{
Factory for creating new empty clone sets
}
Clones newClones() = [];

@doc{
Add clone pairs. Supports both nodes and sets of nodes.
}
Clones addClone(origin, clone, Clones clones) {
    
    pair = occurrance(origin, clone);
    
    // prevent for adding the same twice
    for (existing <- clones, isMirrored(pair, existing)) {
        return clones;
    }
    
    return clones + pair;
}

@doc{
Removes clone pair and returns the new clone set as a result
}
Clones removeClone(subTree, Clones clones) {
    return [pairs | pairs <- clones, occurrance(origin, clone) := pairs, clone@uniqueKey != subTree@uniqueKey];
}

@doc{
Removes all sub tree that may occur in the clone results
}
Clones clearSubTreesFromSet(tree, Clones clones) {
    bottom-up visit (tree) {
        case node subTree: {
            if (subTreeExists(subTree, clones) && subTree@uniqueKey != tree@uniqueKey) {
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
    return (false | true | occurrance(origin, clone) <- clones, origin == subTree || clone == subTree);
}

@doc{
TODO Write test for this
Check if two occurrances are mirrored
}
bool isMirrored(occurrance(origin, clone), occurrance(newOrigin, newClone)) {
    return origin@uniqueKey == newClone@uniqueKey && clone@uniqueKey == newOrigin@uniqueKey;
}