module Test::CloneDetection::Utils::TreeSimilarityTests

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