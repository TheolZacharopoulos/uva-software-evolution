module CloneDetection::StrategyAggregate

import CloneDetection::Strategy::TypeOne;
import CloneDetection::Strategy::TypeTwo;
import CloneDetection::Strategy::TypeThree;
import CloneDetection::ClonePairs;
import CloneDetection::Utils::ParentIndex;
import CloneDetection::Utils::FingerprintCache;
import CloneDetection::Utils::UniqueSequenceKeysCache;
import Results::ResultDefinitions;

import lang::java::m3::AST;
import IO;
import Set;
import Map;

alias TypedPairs = map[str, ClonePairs];

str TYPE_ONE = "type-1";
str TYPE_TWO = "type-2";
str TYPE_THREE = "type-3";

TypedPairs detectClones(set[Declaration] asts, int minSequenceLength, int maxSequenceGap) {

    clearCache();
    
    TypedPairs results = ();
    results = addCloneResults(TYPE_ONE, detectTypeOne(asts, minSequenceLength), results);
    
    clearCache();
    
    results = addCloneResults(TYPE_TWO, detectTypeTwo(asts, minSequenceLength), results);
    
    clearCache();
    
    results = addCloneResults(TYPE_THREE, detectTypeThree(asts, minSequenceLength, maxSequenceGap), results);
    
    clearCache();
    
    return results;
}

private void clearCache() {
    clearParentIndex();
    clearFingerprintCache();
}

private TypedPairs addCloneResults(TYPE_ONE, ClonePairs pairs, TypedPairs results) {
    return results[TYPE_ONE] = pairs;
}

private TypedPairs addCloneResults(TYPE_TWO, ClonePairs pairs, TypedPairs results) {

    results[TYPE_TWO] = pairs;

    return prioritizeCloneType(TYPE_ONE, TYPE_TWO, results);
}

private TypedPairs addCloneResults(TYPE_THREE, ClonePairs pairs, TypedPairs results) {
    return results[TYPE_THREE] = pairs;
}

private TypedPairs prioritizeCloneType(str highPriorityType, str lowPriorityType, TypedPairs results) {
    if (!results[highPriorityType]? || !results[lowPriorityType]?) {
        return results;
    }
    
    highPriority = domain(results[highPriorityType]);
    lowPriority = domain(results[lowPriorityType]);
    
    for (toDelete <- highPriority & lowPriority) {
        results[lowPriorityType] = delete(results[lowPriorityType], toDelete);
    }
    
    return results;
}