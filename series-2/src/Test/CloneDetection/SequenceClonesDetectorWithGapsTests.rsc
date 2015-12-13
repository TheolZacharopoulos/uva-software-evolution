module Test::CloneDetection::SequenceClonesDetectorWithGapsTests

import CloneDetection::ClonePairs;
import CloneDetection::SequenceClonesDetectorWithGaps;
import CloneDetection::Utils::Fingerprinter;
import CloneDetection::Utils::FingerprintCache;
import Test::CloneDetection::Provider::SequenceProvider;
import Test::CloneDetection::Provider::SequenceParentsProvider;
import IO;

test bool testDetectSequenceClonesWithGaps() {
    clones = detectSequenceClonesWithGaps({getTestClassThree(), getTestClassFour()}, 2, 3, getSeqFingerprintAsSet);
    
    return clones == (
        {1, 2, 3, 42}: sequence(getTestSequenceOne(), getTestSequenceTwo()),
        {8,7,9,23}: sequence(getTestSequenceTwo(), getTestSequenceOne())
    );
}