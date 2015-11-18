module Test::CloneDetection::Utils::TreeMass

import CloneDetection::Utils::TreeMass;
import Test::CloneDetection::Utils::TestTreeProvider;

test bool testGetMassForATree() = getTreeMass(TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeC("Test"))) == 5;

test bool testGetMassForATreeSet() {
    treeSet = {TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeC("Test"))}
            + {TestNodeA(TestNodeA(TestNodeA(TestNodeC("Test"), TestNodeC("Test")), TestNodeC("Test 2")), TestNodeC("Test"))};
            
    return getTreeMass(treeSet) == 12;
}