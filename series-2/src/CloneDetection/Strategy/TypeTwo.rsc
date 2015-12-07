module CloneDetection::Strategy::TypeTwo

extend CloneDetection::Strategy::TypeOne;

import CloneDetection::Utils::ASTUnifier;
import CloneDetection::Utils::ClonesGeneralize;
import CloneDetection::AbstractClonePairs;
import lang::java::m3::AST;
import IO;

ClonePairs detectTypeTwo(set[Declaration] asts) = detectTypeOne(unifyAST(asts));