module Test::CloneDetection::SequenceClonesDetectorTests

import CloneDetection::ClonePairs;
import CloneDetection::SequenceClonesDetector;
import CloneDetection::Utils::Fingerprinter;
import CloneDetection::Utils::FingerprintCache;
import Test::CloneDetection::Provider::SequenceProvider;
import Test::CloneDetection::Provider::SequenceParentsProvider;
import IO;

test bool testDetectSequenceClones() {
    clearFingerprintCache();
    clones = detectSequenceClones({getTestClassOne(), getTestClassTwo()}, 2, getSeqFingerprint);
    
    return clones == ({1, 2, 3, 42}: sequence(getTestSequenceOne(), getTestSequenceOneExactClone()));
}