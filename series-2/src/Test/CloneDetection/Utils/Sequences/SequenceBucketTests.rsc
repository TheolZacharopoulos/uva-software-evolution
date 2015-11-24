module Test::CloneDetection::Utils::Sequences::SequenceBucketTests

import CloneDetection::Sequences::SequenceBucket;
import CloneDetection::Sequences::StatementSequences;
import Test::CloneDetection::Utils::TestTreeProvider;
import Map;

test bool testNewSequenceBuckets() = newSequenceBuckets() == ();

test bool testConstructSequenceBuckets() {
    treeBig = getTestTreeBig();
    treeMedium = getTestTreeMedium();
    treeSmall = getTestTreeSmall();
    
    Sequence sequence1 = [treeSmall, treeMedium];
    Sequence sequence2 = [treeBig];
    
    Sequences sequences = [sequence1, sequence2];
    
    SequenceBuckets seqBucket = constructSequenceBuckets(sequences);
    return size(seqBucket) == 2;
}