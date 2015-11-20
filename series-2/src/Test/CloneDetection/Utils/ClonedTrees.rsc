module Test::CloneDetection::Utils::ClonedTrees

import CloneDetection::Utils::ClonedTrees;
import Test::CloneDetection::Utils::TestTreeProvider;

test bool testAddClone() {
    clones = newClones();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    
    return clones == [occurrance(getTestTreeBig(), getTestTreeBig())];
}

test bool testAddCloneSets() {
    clones = newClones();
    clones = addClone({getTestTreeBig(), getTestTreeSmall()}, {getTestTreeBig(), getTestTreeSmall()}, clones);
    
    return clones == [occurrance({getTestTreeBig(), getTestTreeSmall()}, {getTestTreeBig(), getTestTreeSmall()})];
}

test bool testSubTreeExists() {
    clones = newClones();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    clones = addClone(getTestTreeSmall(), getTestTreeSmall(), clones);
    
    return subTreeExists(getTestTreeSmall(), clones);
}

test bool testSubTreeDoesNotExists() {
    clones = newClones();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    clones = addClone(getTestTreeSmall(), getTestTreeSmall(), clones);
    
    return subTreeExists(getTestTreeMedium(), clones) == false;
}

test bool testRemoveClone() {
    treeA = getTestTreeBig();
    treeB = getTestTreeMedium();
    treeC = getTestTreeBig();
    treeD = getTestTreeSmall();
    
    clones = newClones();
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
    
    clones = newClones();
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
    
    clones = newClones();
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
    
    clones = newClones();
    clones = addClone(treeA, treeC, clones);
    clones = addClone(treeA.l, treeC.l, clones);
    
    clones = clearSubTreesFromSet(treeA, clones);
    clones = clearSubTreesFromSet(treeC, clones);
    
    return clones == [occurrance(treeA, treeC)];
}