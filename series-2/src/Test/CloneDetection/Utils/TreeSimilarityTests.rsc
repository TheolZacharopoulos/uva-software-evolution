module Test::CloneDetection::Utils::TreeSimilarityTests

import CloneDetection::Statements::TreeSimilarity;
import CloneDetection::Utils::ASTIdentifier;
import Test::CloneDetection::Utils::TestTreeProvider;
import Prelude;

test bool testCompareTreesWhichAreEqual() {
    // same
    // sharedNodes = 5
    treeA = putIdentifiers(getTestTreeMedium()); // mass = 5
    treeB = putIdentifiers(getTestTreeMedium(), 50);
    
    return 1.0 == getSimilarityFactor(treeA, treeB);
}

test bool testCompareTreesWhichAreDifferent1() {
     // sharedNodes = 3, mass is equal
    treeA = putIdentifiers(getTestTreeMedium()); // mass = 5                            
    treeB = putIdentifiers(getTestTreeBig(), 50);
         
     println( getSimilarityFactor(treeA, treeB));
         
    return 0.1194029851 == getSimilarityFactor(treeA, treeB);
}