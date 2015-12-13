module Test::CloneDetection::Sequences::SequenceBucketTests

import CloneDetection::ClonePairs;
import Test::CloneDetection::Provider::SequencesProvider;
import Test::CloneDetection::Provider::SequenceProvider;
import CloneDetection::Utils::Fingerprinter;
import CloneDetection::Sequences::SequenceBucket;
import IO;

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

test bool testConstructIntersectedSequenceBuckets() {
    Sequences sequences = getTestSequencesTwo();
    buckets = constructIntersectedSequenceBuckets(sequences, 2, 8, getSeqFingerprintAsSet, getSeqFingerprint);
    
    return buckets == (
        "expressionStatement(methodCall(false,qualifiedName(simpleName(\"System\"),simpleName(\"out\")),\"print\",[stringLiteral(\"\\\"1\\\"\")]))expressionStatement(methodCall(false,qualifiedName(simpleName(\"System\"),simpleName(\"out\")),\"print\",[stringLiteral(\"\\\"2\\\"\")]))expressionStatement(methodCall(false,qualifiedName(simpleName(\"System\"),simpleName(\"out\")),\"print\",[stringLiteral(\"\\\"5\\\"\")]))": [
            getTestSequenceOne(),
            getTestSequenceTwo()
        ]
    );
}