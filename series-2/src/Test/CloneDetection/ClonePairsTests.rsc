module Test::CloneDetection::ClonePairsTests

import CloneDetection::ClonePairs;
import Test::CloneDetection::Provider::SequenceProvider;
import IO;

test bool testNewClonePairs() = newClonePairs() == ();

test bool testAddClonePairUsingSequences() {
    clones = newClonePairs();
    sequenceOrigin = getTestSequenceOne();
    sequenceClone = getTestSequenceOneExactClone();
    
    clones = addClonePair(sequenceOrigin, sequenceClone, clones);
    
    return clones == ({1, 2, 3}: sequence(sequenceOrigin, sequenceClone));
}

test bool testAddClonePairUsingNodes() {
    clones = newClonePairs();
    sequenceOrigin = getTestSequenceOne()[0];
    sequenceClone = getTestSequenceOneExactClone()[0];
    
    clones = addClonePair(sequenceOrigin, sequenceClone, clones);
    
    return clones == ({1}: sequence([sequenceOrigin], [sequenceClone]));
}

test bool testRemoveCloneFromClonePairsUsingNode() {
    clones = newClonePairs();
    
    clones = addClonePair(getTestSequenceOne()[0], getTestSequenceOneExactClone()[0], clones);
    clones = addClonePair(getTestSequenceOne()[1], getTestSequenceOneExactClone()[1], clones);
    clones = addClonePair(getTestSequenceOne()[2], getTestSequenceOneExactClone()[2], clones);

    clones = removeCloneFromClonePairs(getTestSequenceOne()[1], clones);
    
    return clones == (
        {1}: sequence([getTestSequenceOne()[0]], [getTestSequenceOneExactClone()[0]]),
        {3}: sequence([getTestSequenceOne()[2]], [getTestSequenceOneExactClone()[2]])
    );
}

test bool testRemoveCloneFromClonePairsUsingSequences() {
    clones = newClonePairs();
    
    clones = addClonePair(getTestSequenceOne(), getTestSequenceOneExactClone(), clones);
    clones = addClonePair(getTestSequenceOneExactClone(), getTestSequenceOne(), clones);

    clones = removeCloneFromClonePairs(getTestSequenceOne(), clones);
    
    return clones == (
        {4, 5, 6}: sequence(getTestSequenceOneExactClone(), getTestSequenceOne())
    );
}

test bool testRemoveCloneFromClonePairsReturnSame() {
    clones = newClonePairs();
    
    clones = addClonePair(getTestSequenceOneExactClone(), getTestSequenceOne(), clones);

    clones = removeCloneFromClonePairs(getTestSequenceOne(), clones);
    
    return clones == (
        {4, 5, 6}: sequence(getTestSequenceOneExactClone(), getTestSequenceOne())
    );
}

test bool testRemoveSequenceSubclones() {
    clones = newClonePairs();
    
    clones = addClonePair(
        [getTestSequenceOne()[0], getTestSequenceOne()[1]], 
        [getTestSequenceOneExactClone()[0], getTestSequenceOneExactClone()[1]], clones);
    
    clones = addClonePair(getTestSequenceTwo(), getTestSequenceTwoExactClone(), clones);

    clones = removeSequenceSubclones(getTestSequenceOne(), getTestSequenceOneExactClone(), clones);
    
    return clones == (
        {7, 8, 9}: sequence(getTestSequenceOneExactClone(), getTestSequenceOne())
    );
}

test bool testGetSequenceUniqueKeys() = getSequenceUniqueKeys(getTestSequenceOne()) == {1, 2, 3};