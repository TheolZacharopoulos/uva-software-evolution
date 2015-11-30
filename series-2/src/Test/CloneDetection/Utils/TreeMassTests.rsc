module Test::CloneDetection::Utils::TreeMassTests

import CloneDetection::Statements::TreeMass;
import Test::CloneDetection::Utils::TestTreeProvider;
import IO;

test bool testGetMassForATree() {
    return getTreeMass(getTestTreeBig()) == 46;
}