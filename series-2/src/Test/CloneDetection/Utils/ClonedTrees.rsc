module Test::CloneDetection::Utils::ClonedTrees

import CloneDetection::Utils::ClonedTrees;
import Test::CloneDetection::Utils::TestTreeProvider;

test bool testAddClone() {
    clones = newClones();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    
    return clones == {occurance(getTestTreeBig(), getTestTreeBig())};
}

test bool testAddCloneSets() {
    clones = newClones();
    clones = addClone({getTestTreeBig(), getTestTreeSmall()}, {getTestTreeBig(), getTestTreeSmall()}, clones);
    
    return clones == {occurance({getTestTreeBig(), getTestTreeSmall()}, {getTestTreeBig(), getTestTreeSmall()})};
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
    clones = newClones();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    clones = addClone(getTestTreeMedium(), getTestTreeSmall(), clones);
    
    clones = removeClone(getTestTreeMedium(), clones);
    
    return clones == {occurance(getTestTreeBig(), getTestTreeBig())};
}

test bool testRemoveClone2() {
    clones = newClones();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    clones = addClone(getTestTreeMedium(), getTestTreeSmall(), clones);
    
    clones = removeClone(getTestTreeSmall(), clones);
    
    return clones == {occurance(getTestTreeBig(), getTestTreeBig())};
}

test bool testRemoveClone3() {
    clones = newClones();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    clones = addClone(getTestTreeMedium(), getTestTreeSmall(), clones);
    
    clones = removeClone(getTestTreeBig(), clones);
    
    return clones == {occurance(getTestTreeMedium(), getTestTreeSmall())};
}

test bool testClearSubTreesFromSet() {
    clones = newClones();
    clones = addClone(getTestTreeBig(), getTestTreeBig(), clones);
    clones = addClone(getTestTreeMedium(), getTestTreeSmall(), clones);
    
    clones = clearSubTreesFromSet(getTestTreeBig(), clones);
    
    return clones == {occurance(getTestTreeBig(), getTestTreeBig())};
}