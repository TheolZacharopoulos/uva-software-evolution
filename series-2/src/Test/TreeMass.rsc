module Test::TreeMass

import CloneDetection::Utils::TreeMass;

data TestTree = TestNodeA(TestTree l, TestTree r) | TestNodeB(int number) | TestNodeC(str text);

test bool testGetMassForATree() = getTreeMass(TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeC("Test"))) == 5;

test bool testGetMassForATreeSet() {
    treeSet = {TestNodeA(TestNodeA(TestNodeB(4), TestNodeC("Test 2")), TestNodeC("Test"))}
            + {TestNodeA(TestNodeA(TestNodeA(TestNodeC("Test"), TestNodeC("Test")), TestNodeC("Test 2")), TestNodeC("Test"))};
            
    return getTreeMass(treeSet) == 12;
}