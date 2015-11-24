module CloneDetection::AbstractClonePairs

import CloneDetection::Utils::Sequences::StatementSequences;

import lang::java::jdt::m3::AST;

data ClonePair = occurrance(Statement origin, Statement clone)
               | occurrance(Sequence originSeq, Statement cloneSeq);

alias ClonePairs = list[ClonePair];

@doc{
Factory for creating new empty clone pairs
}
ClonePairs newClonePairs() = [];

// TODO: Refactor clone statement and clone sequence pairs to import this.