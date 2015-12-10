module Test::CloneDetection::StrategyAggregateTestss

import CloneDetection::Utils::ASTUnifier;
import CloneDetection::ClonePairs;
import CloneDetection::StrategyAggregate;
import Test::CloneDetection::Provider::SequenceParentsProvider;

test bool testDetectClones() {
    typedPairs = detectClones({getTestCompilationUnitOne(), getTestCompilationUnitTwo()}, 2);
    
    return typedPairs == (
        "type-1": ({14}: sequence([getTestSequenceParentOne()], [getTestSequenceParentOneExactClone()])),
        "type-2": ({17}: sequence([unifyAST(getTestClassOne())], [unifyAST(getTestClassTwo())]))
    );
}