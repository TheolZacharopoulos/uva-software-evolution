module Test::CloneDetection::Utils::TreeBucketTests

import CloneDetection::Utils::TreeBucket;
import CloneDetection::Utils::Fingerprinter;
import Test::CloneDetection::Utils::TestTreeProvider;

test bool testAddToBucket() {

    treeBig = getTestTreeBig();
    treeMedium = getTestTreeMedium();
    treeSmall = getTestTreeSmall();
    
    Buckets testBucket = newBuckets();
    testBucket = addToBucket(treeBig, testBucket);
    testBucket = addToBucket(treeMedium, testBucket);
    testBucket = addToBucket(treeSmall, testBucket);
    
    return (
        getFingerprint(treeBig): [treeBig], 
        getFingerprint(treeMedium): [treeMedium], 
        getFingerprint(treeSmall): [treeSmall]
    ) == testBucket;
}