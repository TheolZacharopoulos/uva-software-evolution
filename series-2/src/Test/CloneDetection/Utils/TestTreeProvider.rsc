module Test::CloneDetection::Utils::TestTreeProvider

data TestTree = TestNodeA(TestTree l, TestTree r) | TestNodeB(int number) | TestNodeC(str text);