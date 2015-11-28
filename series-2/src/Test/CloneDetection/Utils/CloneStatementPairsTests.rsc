module Test::CloneDetection::Utils::CloneStatementPairsTests

import CloneDetection::Statements::CloneStatementPairs;
import Test::CloneDetection::Utils::TestTreeProvider;
import CloneDetection::AbstractClonePairs;
import IO;
import Map;
import Set;

test bool testAddClone() {
    clones = newClonePairs();
    clones = addCloneToClonePairs(getTestTreeBig(), getTestTreeBig(), clones);
    
    return range(clones) == {<getTestTreeBig(), getTestTreeBig()>};
}

test bool testSubTreeExists() {
    clones = newClonePairs();
    
    treeBig = getTestTreeBig();
    treeBigClone = getTestTreeBig();
    
    treeSmall = getTestTreeSmall();
    treeSmallClone = getTestTreeSmall();
    
    clones = addCloneToClonePairs(treeBig, treeBigClone, clones);
    clones = addCloneToClonePairs(treeSmall, treeSmallClone, clones);
    
    return doesSubTreeExist(treeSmall, clones);
}

test bool testSubTreeDoesNotExists() {
    clones = newClonePairs();
    clones = addCloneToClonePairs(getTestTreeBig(), getTestTreeBig(), clones);
    clones = addCloneToClonePairs(getTestTreeSmall(), getTestTreeSmall(), clones);
    
    return doesSubTreeExist(getTestTreeMedium(), clones) == false;
}

test bool testRemoveClone() {
    treeA = getTestTreeBig();
    treeB = getTestTreeMedium();
    treeC = getTestTreeBig();
    treeD = getTestTreeSmall();
    
    clones = newClonePairs();
    clones = addCloneToClonePairs(treeA, treeC, clones);
    clones = addCloneToClonePairs(treeB, treeD, clones);
    
    clones = removeCloneFromClonePairs(treeB, clones);
    
    return range(clones) == {<treeA, treeC>};
}

test bool testRemoveClone2() {
    treeA = getTestTreeBig();
    treeB = getTestTreeMedium();
    treeC = getTestTreeBig();
    treeD = getTestTreeSmall();
    
    clones = newClonePairs();
    clones = addCloneToClonePairs(treeA, treeC, clones);
    clones = addCloneToClonePairs(treeB, treeD, clones);
    
    clones = removeCloneFromClonePairs(treeA, clones);
    
    return range(clones) == {<treeB, treeD>};
}

test bool testClearSubTreesFromSet() {
    treeA = getTestTreeBig();
    treeC = getTestTreeBig();
    treeB = getTestTreeMedium();
    treeD = getTestTreeSmall();
    
    clones = newClonePairs();
    clones = addCloneToClonePairs(treeA, treeC, clones);
    
    clones = clearSubTrees(treeA, clones);
    clones = clearSubTrees(treeC, clones);
    
    return range(clones) == {<treeA, treeC>};
}