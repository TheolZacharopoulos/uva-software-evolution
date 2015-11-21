module Test::CloneDetection::Utils::TreeSimilarity

import CloneDetection::Utils::TreeSimilarity;
import CloneDetection::Utils::ASTIdentifier;
import Test::CloneDetection::Utils::TestTreeProvider;
import Prelude;

test bool testCompareTreesWhichAreEqual() {
    // same
    // sharedNodes = 5
    treeA = putIdentifiers(TestNodeA(
                                TestNodeA(
                                    TestNodeB(4), TestNodeC("Test 2")), 
                            TestNodeC("Test"))); // mass = 5
                
    treeB = putIdentifiers(TestNodeA(
                                TestNodeA(
                                    TestNodeB(4), TestNodeC("Test 2")), 
                            TestNodeC("Test")), 
                            50);
    
    return 1 == getSimilarityFactor(treeA, treeB);
}

test bool testCompareTreesWhichAreDifferent1() {
     // sharedNodes = 3, mass is equal
    treeA = putIdentifiers(TestNodeA(
                                TestNodeA(TestNodeB(4), TestNodeC("Test 2")), 
                            TestNodeB(3))); // mass = 5
                            
    treeB = putIdentifiers(TestNodeA(
                                TestNodeA(TestNodeB(4), TestNodeC("Test 2")), 
                            TestNodeC("Test")), 
                            50);
                            
    return 0.6 == getSimilarityFactor(treeA, treeB);
}

test bool testCompareTreesWhichAreDifferent2() {
    // sharedNodes = 5
    treeA = putIdentifiers({ TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeB(3)), TestNodeB(4) }); // mass = 6
    treeB = putIdentifiers(TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeB(3)), 50); // mass = 5
    return 0.91 == getSimilarityFactor(treeA, treeB);
}