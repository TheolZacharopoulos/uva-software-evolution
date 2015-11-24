module CloneDetection::Utils::Sequences::SequenceBucket

import CloneDetection::Utils::CloneStatementPairs;
import CloneDetection::Utils::Sequences::StatementSequences;

import lang::java::jdt::m3::AST;

alias SequenceBuckets = map[str, Sequences];

@doc{
Factory for creating new empty sequence buckets
}
SequenceBuckets newSequenceBuckets() = ();

SequenceBuckets addSequenceToBucket(Sequence sequence, SequenceBuckets buckets) {
    fingerPrint = getSequenceFingerprint(sequence);
    
    Sequences emptyList = [];
    
    return buckets[fingerPrint] ? emptyList += sequence;
}