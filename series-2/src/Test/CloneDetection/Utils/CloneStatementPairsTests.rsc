module Test::CloneDetection::Utils::CloneStatementPairsTests

import CloneDetection::Utils::CloneStatementPairs;
import Test::CloneDetection::Utils::TestTreeProvider;
import CloneDetection::AbstractClonePairs;

test bool testAddClone() {
    clones = newClonePairs();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    
    return clones == [occurrance(getTestTreeBig(), getTestTreeBig())];
}

test bool testSubTreeExists() {
    clones = newClonePairs();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    clones = addClone(getTestTreeSmall(), getTestTreeSmall(), clones);
    
    return doesSubTreeExist(getTestTreeSmall(), clones);
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
    
    clones = removeClone(treeD, clones);
    
    return clones == [occurrance(treeA, treeC)];
}

test bool testRemoveClone2() {
    treeA = getTestTreeBig();
    treeB = getTestTreeMedium();
    treeC = getTestTreeBig();
    treeD = getTestTreeSmall();
    
    clones = newClonePairs();
    clones = addClone(treeA, treeC, clones);
    clones = addClone(treeB, treeD, clones);
    
    clones = removeClone(treeD, clones);
    
    return clones == [occurrance(treeA, treeC)];
}

test bool testRemoveClone3() {
    treeA = getTestTreeBig();
    treeB = getTestTreeMedium();
    treeC = getTestTreeBig();
    treeD = getTestTreeSmall();
    
    clones = newClonePairs();
    clones = addClone(treeA, treeC, clones);
    clones = addClone(treeB, treeD, clones);
    
    clones = removeClone(treeC, clones);
    
    return clones == [occurrance(treeB, treeD)];
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
    
    return clones == [occurrance(treeA, treeC)];
}