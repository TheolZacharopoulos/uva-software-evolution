module Test::CloneDetection::Utils::ClonesGeneralizeTests

import CloneDetection::ClonePairs;
import CloneDetection::Utils::ParentIndex;
import Test::CloneDetection::Provider::SequenceParentsProvider;
import Test::CloneDetection::Provider::SequenceProvider;
import CloneDetection::Utils::ClonesGeneralize;
import IO;

test bool testGeneralizeClones() {

    clearParentIndex();

    collectChildrenToParentIndexFromAST({getTestSequenceParentOne()});
    collectChildrenToParentIndexFromAST({getTestSequenceParentOneExactClone()});
    
    clones = newClonePairs();
    clones = addClonePair(getTestSequenceOne(), getTestSequenceOneExactClone(), clones);
    
    clones = generalizeClones(clones, bool (node a, node b) { return a == b; });
    
    return clones == ({14}: sequence([getTestSequenceParentOne()], [getTestSequenceParentOneExactClone()]));
}