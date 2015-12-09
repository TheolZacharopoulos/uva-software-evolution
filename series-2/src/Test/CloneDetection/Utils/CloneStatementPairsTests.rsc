module Test::CloneDetection::Utils::CloneStatementPairsTests

import Test::CloneDetection::Utils::TestTreeProvider;
import CloneDetection::ClonePairs;
import IO;
import Map;
import Set;

test bool testAddClone() {
    clones = newClonePairs();
    clones = addClonePair(getTestTreeBig(), getTestTreeBig(), clones);
    
    return range(clones) == {sequence([getTestTreeBig()], [getTestTreeBig()])};
}

test bool testRemoveClone() {
    treeA = getTestTreeBig();
    treeB = getTestTreeMedium();
    treeC = getTestTreeBig();
    treeD = getTestTreeSmall();
    
    clones = newClonePairs();
    clones = addClonePair(treeA, treeC, clones);
    clones = addClonePair(treeB, treeD, clones);
    
    clones = removeCloneFromClonePairs(treeB, clones);
    
    return range(clones) == {sequence([treeA], [treeC])};
}

test bool testRemoveClone2() {
    treeA = getTestTreeBig();
    treeB = getTestTreeMedium();
    treeC = getTestTreeBig();
    treeD = getTestTreeSmall();
    
    clones = newClonePairs();
    clones = addClonePair(treeA, treeC, clones);
    clones = addClonePair(treeB, treeD, clones);
    
    clones = removeCloneFromClonePairs(treeA, clones);
    
    return range(clones) == {sequence([treeB], [treeD])};
}