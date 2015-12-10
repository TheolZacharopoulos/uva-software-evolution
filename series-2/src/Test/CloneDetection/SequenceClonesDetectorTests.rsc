module Test::CloneDetection::SequenceClonesDetectorTests

import CloneDetection::SequenceClonesDetector;
import CloneDetection::Utils::Fingerprinter;
import Test::CloneDetection::Provider::SequenceParentsProvider;
import IO;

test bool testDetectSequenceClones() {
    clones = detectSequenceClones({getTestClassOne(), getTestClassTwo()}, 2, getSeqFingerprint);
    
    return clones == ({1, 2, 3}: sequence(getTestSequenceOne(), getTestSequenceOneExactClone()));
}