module Test::CloneDetection::Sequences::SubsequencesExtractorTests

import CloneDetection::Sequences::SubsequencesExtractor;
import Test::CloneDetection::Provider::SequenceProvider;
import Test::CloneDetection::Provider::SequencesProvider;

test bool testGetSubSequencesEmpty() = getSubSequences([], 0) == [];

test bool testGetSubSequencesThrowsExceptionOnWrongLength() {
    try {
        getSubSequences(getTestSequenceOne(), 10);
    }
    catch: return true;
    
    return false;
}

test bool testGetSubSequences() = getSubSequences(getTestSequenceOne(), 2) == [
    [getTestSequenceOne()[0], getTestSequenceOne()[1]],
    [getTestSequenceOne()[1], getTestSequenceOne()[2]],
    [getTestSequenceOne()[2], getTestSequenceOne()[3]]
];

test bool testGetSubSequencesEqualLenghts() = getSubSequences(getTestSequenceOne(), 3) == [
    [getTestSequenceOne()[0], getTestSequenceOne()[1], getTestSequenceOne()[2]],
    [getTestSequenceOne()[1], getTestSequenceOne()[2], getTestSequenceOne()[3]]
];

test bool testGetSubSequencesUsingSequences() = getSubSequences(getTestSequencesOne(), 2) == [
    [getTestSequenceOne()[0], getTestSequenceOne()[1]],
    [getTestSequenceOne()[1], getTestSequenceOne()[2]],
    [getTestSequenceOne()[2], getTestSequenceOne()[3]],
    [getTestSequenceOneExactClone()[0], getTestSequenceOneExactClone()[1]],
    [getTestSequenceOneExactClone()[1], getTestSequenceOneExactClone()[2]],
    [getTestSequenceOneExactClone()[2], getTestSequenceOneExactClone()[3]]
];