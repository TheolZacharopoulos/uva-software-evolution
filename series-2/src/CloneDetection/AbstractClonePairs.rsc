module CloneDetection::AbstractClonePairs

data ClonePair = occurrance(node origin, node clone);

alias ClonePairs = list[ClonePair];

@doc{
Factory for creating new empty clone pairs
}
ClonePairs newClonePairs() = [];

// TODO: Refactor clone statement and clone sequence pairs to import this.