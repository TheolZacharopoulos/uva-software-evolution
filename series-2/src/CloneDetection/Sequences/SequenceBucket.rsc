module CloneDetection::Sequences::SequenceBucket

import CloneDetection::Utils::Fingerprinter;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::ClonePairs;

import lang::java::m3::AST;
import Set;
import List;
import util::Math;

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

SequenceBuckets constructIntersectedSequenceBuckets(
    Sequences subSequences, int minSequenceLength, int maxSequenceGap, set[str] (Sequence) seqFingerprinter, str (Sequence) fingerprinter) {
    
    SequenceBuckets sequenceBuckets = newSequenceBuckets();
    Sequences emptySequences = [];
    
    for (sequenceA <- subSequences, sequenceB <- subSequences, sequenceA != sequenceB) {
        Sequence intersection = sequenceA & sequenceB;
        gap = abs(size(sequenceA) - size(sequenceB));
        if (size(intersection) >= minSequenceLength, 
                gap <= maxSequenceGap) {
            str fingerprint = fingerprinter(intersection);
            sequenceBuckets[fingerprint] ? emptySequences += [sequenceA];
        }
    }
    
    return sequenceBuckets;
}