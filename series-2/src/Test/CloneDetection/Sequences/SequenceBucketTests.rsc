module Test::CloneDetection::Sequences::SequenceBucketTests

import Test::CloneDetection::Provider::SequencesProvider;
import Test::CloneDetection::Provider::SequenceProvider;
import CloneDetection::Utils::Fingerprinter;
import CloneDetection::Sequences::SequenceBucket;

test bool testNewSequenceBuckets() = newSequenceBuckets() == ();

test bool testConstructSequenceBuckets() {
    Sequences sequences = getTestSequencesOne();
    buckets = constructSequenceBuckets(sequences, getSeqFingerprint);
    
    return buckets == (
        getSeqFingerprint(getTestSequenceOne()): [
            getTestSequenceOne(),
            getTestSequenceOneExactClone()
        ]
    );
}