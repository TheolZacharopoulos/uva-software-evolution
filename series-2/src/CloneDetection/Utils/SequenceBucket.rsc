module CloneDetection::Utils::SequenceBucket

import CloneDetection::Utils::StatementSequences;
import IO;

alias SequenceBuckets = map[int, Sequences];

@doc{
Factory for creating new empty sequence buckets
}
Sequences newSequenceBucket() = [];

@doc{
Build seuqnce bucket maps which contain all sequences devided by length
}
SequenceBuckets organizeSequenceBucketsByLength(Sequences sequences) {
    SequenceBuckets buckets = ();
    emptyBucket = newSequenceBucket();
    
    for (sequence <- sequences) {
        buckets[size(sequence)] ? emptyBucket += [sequence];
    }
    
    return buckets;
}