module Test::CloneDetection::Utils::TestTreeProvider

import CloneDetection::Utils::ASTIdentifier;

data TestTree = TestNodeA(TestTree l, TestTree r) | TestNodeB(int number) | TestNodeC(str text);

int lastUnique = 0;

TestTree getTestTreeBig() {
    lastUnique += 100;
    return putIdentifiers(TestNodeA(
        TestNodeA(
            TestNodeB(2), TestNodeA(TestNodeC("dasdsadas"), TestNodeB(4))
        ), 
        TestNodeA(TestNodeB(2135), TestNodeB(1))
    ), lastUnique);
}

TestTree getTestTreeMedium() {
    lastUnique += 150;
    return putIdentifiers(TestNodeA(
        TestNodeB(2), TestNodeA(TestNodeC("dasdsadas"), TestNodeB(4))
    ), lastUnique);
}

TestTree getTestTreeSmall() { 
    lastUnique += 200;
    return putIdentifiers(TestNodeA(TestNodeC("dasdsadas"), TestNodeB(4)), lastUnique);
}