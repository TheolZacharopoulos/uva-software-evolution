module Test::CloneDetection::Utils::TestTreeProvider

data TestTree = TestNodeA(TestTree l, TestTree r) | TestNodeB(int number) | TestNodeC(str text);

TestTree getTestTreeBig() = TestNodeA(
    TestNodeA(
        TestNodeB(2), TestNodeA(TestNodeC("dasdsadas"), TestNodeB(4))
    ), 
    TestNodeA(TestNodeB(2135), TestNodeB(1))
);

TestTree getTestTreeMedium() = TestNodeA(
    TestNodeB(2), TestNodeA(TestNodeC("dasdsadas"), TestNodeB(4))
);

TestTree getTestTreeSmall() = TestNodeA(TestNodeC("dasdsadas"), TestNodeB(4));