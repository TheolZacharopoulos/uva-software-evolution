module CloneDetection::Utils::Sequences::SequenceBucket

import CloneDetection::Utils::Fingerprinter;
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

@doc{
Place all subsequences of length (sequenceLength) into buckets according to subsequence hash
}
SequenceBuckets constructSequenceBuckets(list[Sequences] subSequences) {

    SequenceBuckets sequenceBuckets = newSequenceBuckets();
    Sequences emptySequences = [];
    for (subSequence <- subSequences) {
        str figerprint = getBadSeqFingerprint(subSequence);
        sequenceBuckets[figerprint] ? emptySequences += subSequence;
    }
    return sequenceBuckets;
}