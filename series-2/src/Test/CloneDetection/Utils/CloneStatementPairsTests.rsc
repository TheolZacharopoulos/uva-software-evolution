module Test::CloneDetection::Utils::CloneStatementPairsTests

import CloneDetection::Statements::CloneStatementPairs;
import Test::CloneDetection::Utils::TestTreeProvider;
import CloneDetection::AbstractClonePairs;
import IO;
import Map;
import Set;

test bool testAddClone() {
    clones = newClonePairs();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    
    return range(clones) == {<getTestTreeBig(), getTestTreeBig()>};
}

test bool testSubTreeExists() {
    clones = newClonePairs();
    
    treeBig = getTestTreeBig();
    treeBigClone = getTestTreeBig();
    
    treeSmall = getTestTreeSmall();
    treeSmallClone = getTestTreeSmall();
    
    clones = addClone(treeBig, treeBigClone, clones);
    clones = addClone(treeSmall, treeSmallClone, clones);
    
    return doesSubTreeExist(treeSmall, clones);
}

test bool testSubTreeDoesNotExists() {
    clones = newClonePairs();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    clones = addClone(getTestTreeSmall(), getTestTreeSmall(), clones);
    
    return doesSubTreeExist(getTestTreeMedium(), clones) == false;
}

test bool testRemoveClone() {
    treeA = getTestTreeBig();
    treeB = getTestTreeMedium();
    treeC = getTestTreeBig();
    treeD = getTestTreeSmall();
    
    clones = newClonePairs();
    clones = addClone(treeA, treeC, clones);
    clones = addClone(treeB, treeD, clones);
    
    clones = removeClone(treeB, clones);
    
    return range(clones) == {<treeA, treeC>};
}

test bool testRemoveClone2() {
    treeA = getTestTreeBig();
    treeB = getTestTreeMedium();
    treeC = getTestTreeBig();
    treeD = getTestTreeSmall();
    
    clones = newClonePairs();
    clones = addClone(treeA, treeC, clones);
    clones = addClone(treeB, treeD, clones);
    
    clones = removeClone(treeA, clones);
    
    return range(clones) == {<treeB, treeD>};
}

test bool testClearSubTreesFromSet() {
    treeA = getTestTreeBig();
    treeC = getTestTreeBig();
    treeB = getTestTreeMedium();
    treeD = getTestTreeSmall();
    
    clones = newClonePairs();
    clones = addClone(treeA, treeC, clones);
    
    clones = clearSubTrees(treeA, clones);
    clones = clearSubTrees(treeC, clones);
    
    return range(clones) == {<treeA, treeC>};
}