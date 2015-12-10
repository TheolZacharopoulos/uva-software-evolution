module Test::CloneDetection::Strategy::TypeOneTests

import CloneDetection::ClonePairs;
import CloneDetection::Strategy::TypeOne;
import Test::CloneDetection::Provider::SequenceParentsProvider;

test bool testDetectTypeOne() {
    clones = detectTypeOne({getTestClassOne(), getTestClassTwo()}, 2);
    
    return clones == ({14}: sequence([getTestSequenceParentOne()], [getTestSequenceParentOneExactClone()]));
}