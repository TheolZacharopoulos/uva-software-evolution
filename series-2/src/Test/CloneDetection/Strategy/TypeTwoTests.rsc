module Test::CloneDetection::Strategy::TypeTwoTests

import CloneDetection::Utils::ASTUnifier;
import CloneDetection::ClonePairs;
import CloneDetection::Strategy::TypeTwo;
import Test::CloneDetection::Provider::SequenceParentsProvider;
import IO;

test bool testDetectTypeTwo() {
    clearParentIndex();
    clones = detectTypeTwo({getTestCompilationUnitOne(), getTestCompilationUnitTwo()}, 2);
    return clones == ({17}: sequence([unifyAST(getTestClassOne())], [unifyAST(getTestClassTwo())]));
}