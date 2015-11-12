module Test::Metrics::LinesOfCodeTests

import lang::java::jdt::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::m3::Core;
import Set;

import Metrics::LinesOfCode;
import Configurations;

str TEST_COMPILATION_UNIT = "VolumeTests.java";
str TEST_VOLUME_UNIT_NAME  = "commentsEverywhere()";

loc getCompUnitLoc(str file) {
    M3 model = createM3FromEclipseProject(getTestProjectLocation());
    
    return getOneFrom({ compLoc | 
                            <compLoc, compSrc> <- model@declarations, 
                            isCompilationUnit(compLoc), 
                            compLoc.file == file});
}

loc getUnitLoc(str file) {
    M3 model = createM3FromEclipseProject(getTestProjectLocation());    
    return getOneFrom({ methodLoc | 
                            <methodLoc, methodSrc> <- model@declarations, 
                            isMethod(methodLoc), 
                            methodLoc.file == file});
}

// Compilation Unit
test bool testCompUnitVolume() = 
            countLinesOfCode(getCompUnitLoc(TEST_COMPILATION_UNIT)) == 10;

// Unit (method)
test bool testUnitVolume() = 
            countLinesOfCode(getUnitLoc(TEST_VOLUME_UNIT_NAME)) == 5;