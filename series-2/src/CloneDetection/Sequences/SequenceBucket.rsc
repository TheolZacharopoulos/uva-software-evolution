module CloneDetection::Sequences::SequenceBucket

import CloneDetection::Utils::Fingerprinter;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::AbstractClonePairs;

import lang::java::jdt::m3::AST;

alias SequenceBuckets = map[str, Sequences];

@doc{
Factory for creating new empty sequence buckets
}
SequenceBuckets newSequenceBuckets() = ();

@doc{
Place all subsequences of length (sequenceLength) into buckets according to subsequence hash
}
SequenceBuckets constructSequenceBuckets(Sequences subSequences, str (Sequence) fingerprinter) {

    SequenceBuckets sequenceBuckets = newSequenceBuckets();
    Sequences emptySequences = [];
    
    for (subSequence <- subSequences) {
        str fingerprint = fingerprinter(subSequence);
        sequenceBuckets[fingerprint] ? emptySequences += [subSequence];
    }
    return sequenceBuckets;
}