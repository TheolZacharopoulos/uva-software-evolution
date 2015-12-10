module CloneDetection::Utils::UniqueSequenceKeysCache

import CloneDetection::ClonePairs;
import List;

anno int node @ uniqueKey;

private map[tuple[int, int], set[int]] cache = ();

void cacheSequenceKeys(Sequence sequence, set[int] keys) {
    firstStatement = sequence[0];
    cache[<firstStatement@uniqueKey, size(sequence)>] = keys;
}

bool isSequenceKeysCached(Sequence sequence) {
    firstStatement = sequence[0];
    
    return cache[<firstStatement@uniqueKey, size(sequence)>]?;
}

set[int] getCachedSequenceKeys(Sequence sequence) {
    firstStatement = sequence[0];
    
    return cache[<firstStatement@uniqueKey, size(sequence)>];
}

void clearSequenceKeysCache() {
    cache = ();
}