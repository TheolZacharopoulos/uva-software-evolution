module CloneDetection::Strategy::TypeTwo

extend CloneDetection::Strategy::TypeOne;

import CloneDetection::Utils::ASTUnifier;
import CloneDetection::Utils::ClonesGeneralize;
import CloneDetection::ClonePairs;
import lang::java::m3::AST;
import IO;

ClonePairs detectTypeTwo(set[Declaration] asts, int minSequenceLength) = detectTypeOne(unifyAST(asts), minSequenceLength);