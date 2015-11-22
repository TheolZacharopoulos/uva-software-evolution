module Test::FingerprinterTests

import CloneDetection::Utils::Fingerprinter;

import lang::java::jdt::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::m3::Core;
import IO;
import Set;

import Configurations;

str TEST_COMPILATION_UNIT  = "Clone1.java";

Declaration getCompUnit() {
    M3 model = createM3FromEclipseProject(getTestProjectLocation());
    
    \compUnit = getOneFrom({ compLoc | 
                            <compLoc, compSrc> <- model@declarations, 
                            isCompilationUnit(compLoc), 
                            compLoc.file == TEST_COMPILATION_UNIT});
    return createAstFromFile(\compUnit, true);
}

test bool testPerfectHash1() {
    Declaration ast = getCompUnit();
    Hash treeHash = perfectHash(ast);
    // TODO: TEST
    return true;
}

//test bool testDegradedHash1() {
//    Declaration ast = getCompUnit();
//    Hash treeHash = degradedHash(ast);
//    // TODO: TEST
//    return true;
//}