module CloneDetection::StrategyAggregate

import CloneDetection::Strategy::TypeOne;
import CloneDetection::Strategy::TypeTwo;
import CloneDetection::AbstractClonePairs;
import CloneDetection::Utils::ParentIndex;
import CloneDetection::Utils::ASTIdentifier;
import CloneDetection::Utils::FingerprintCache;
import CloneDetection::Utils::UniqueSequenceKeysCache;

import lang::java::m3::AST;
import IO;
import Set;
import Map;

alias CloneResults = map[str, ClonePairs];

str TYPE_ONE = "type-1";
str TYPE_TWO = "type-2";
str TYPE_THREE = "type-3";

CloneResults detectClones(set[Declaration] asts) {
    
    asts = putIdentifiers(asts);

    CloneResults results = ();
    results = addCloneResults(TYPE_ONE, detectTypeOne(asts), results);
    
    clearCache();
    
    results = addCloneResults(TYPE_TWO, detectTypeTwo(asts), results);
    
    return results;
}

private void clearCache() {
    clearParentIndex();
    clearFingerprintCache();
    clearSequenceKeysCache();
}

private CloneResults addCloneResults(TYPE_ONE, ClonePairs pairs, CloneResults results) {
    return results[TYPE_ONE] = pairs;
}

private CloneResults addCloneResults(TYPE_TWO, ClonePairs pairs, CloneResults results) {

    results[TYPE_TWO] = pairs;

    return prioritizeCloneType(TYPE_ONE, TYPE_TWO, results);
}

private CloneResults addCloneResults(TYPE_THREE, ClonePairs pairs, CloneResults results) {
    return results[TYPE_THREE] = pairs;
}

private CloneResults prioritizeCloneType(str highPriorityType, str lowPriorityType, CloneResults results) {
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