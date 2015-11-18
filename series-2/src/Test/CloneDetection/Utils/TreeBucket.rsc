module Test::CloneDetection::Utils::TreeBucket

import CloneDetection::Utils::TreeBucket;
import Test::CloneDetection::Utils::TestTreeProvider;

test bool testTreeBucketSort() {

    treeBig = getTestTreeBig();
    treeMedium = getTestTreeMedium();
    treeSmall = getTestTreeSmall();
    
    Bucket testBucket = [treeBig, treeSmall, treeMedium];
    
    return [treeSmall, treeMedium, treeBig] == sortBucket(testBucket);
}

test bool testAddToBucketUnsorted() {

    treeBig = getTestTreeBig();
    treeMedium = getTestTreeMedium();
    treeSmall = getTestTreeSmall();
    
    Bucket testBucket = newBucket();
    testBucket = addToBucket(treeBig, testBucket);
    testBucket = addToBucket(treeMedium, testBucket);
    testBucket = addToBucket(treeSmall, testBucket);
    
    return [treeBig, treeMedium, treeSmall] == testBucket;
}

test bool testAddToBucketSorted() {

    treeBig = getTestTreeBig();
    treeMedium = getTestTreeMedium();
    treeSmall = getTestTreeSmall();
    
    Bucket testBucket = newBucket();
    testBucket = addToBucket(treeBig, testBucket, true);
    testBucket = addToBucket(treeMedium, testBucket, true);
    testBucket = addToBucket(treeSmall, testBucket, true);
    
    return [treeSmall, treeMedium, treeBig] == testBucket;
}