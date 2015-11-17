module Test::TreeSimilarity

import IO;
import TreeSimilarity;

data TestTree = TestNodeA(TestTree l, TestTree r) | TestNodeB(int number) | TestNodeC(str text);

test bool testCompareTreesWhichAreEqual()
{
    // same
    // sharedNodes = 5
    treeA = TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeC("Test")); // mass = 5
    treeB = TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeC("Test"));
    
    return 1 == getSimilarityFactor(treeA, treeB);
}

test bool testCompareTreesWhichAreDifferent1()
{
     // sharedNodes = 3, mass is equal
    treeA = TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeB(3)); // mass = 5
    treeB = TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeC("Test"));
    
    return 0.6 == getSimilarityFactor(treeA, treeB);
}

test bool testCompareTreesWhichAreDifferent2()
{
    // sharedNodes = 5
    treeA = {TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeB(3)), TestNodeB(4)}; // mass = 6
    treeB = TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeB(3)); // mass = 5
    
    return 0.91 == getSimilarityFactor(treeA, treeB);
}