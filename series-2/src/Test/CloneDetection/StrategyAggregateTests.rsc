module Test::CloneDetection::StrategyAggregateTests

import CloneDetection::Utils::ASTUnifier;
import CloneDetection::ClonePairs;
import CloneDetection::StrategyAggregate;
import Test::CloneDetection::Provider::SequenceParentsProvider;
import IO;

test bool testDetectClones() {
    typedPairs = detectClones({
        getTestCompilationUnitThree(), getTestCompilationUnitFour()
    }, 2, 3);
    
    return typedPairs == (
        "type-1": ({1, 2, 3}: sequence(
                [getTestSequenceOne()[0], getTestSequenceOne()[1], getTestSequenceOne()[2]], 
                [getTestSequenceTwo()[0], getTestSequenceTwo()[1], getTestSequenceTwo()[2]]
            )
        ),
        "type-2": ({8, 7, 9}: sequence(
                unifyAST([getTestSequenceTwo()[0], getTestSequenceTwo()[1], getTestSequenceTwo()[2]]),
                unifyAST([getTestSequenceTwoExactClone()[0], getTestSequenceTwoExactClone()[1], getTestSequenceTwoExactClone()[2]])
            )
        ),
        "type-3": (
            {1, 2, 3, 42}: sequence(getTestSequenceOne(), getTestSequenceTwo()),
            {8,7,9,23}: sequence(getTestSequenceTwo(), getTestSequenceOne())
        )
    );
}