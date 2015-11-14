module Test::Metrics::DuplicationTests

import Metrics::Duplication2;

import lang::java::jdt::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::m3::Core;
import Set;
import String;

import Configurations;
import Metrics::Complexity;
import Metrics::LinesOfCode;

str TEST_CLASS = "DuplicationTests";

list[Line] getTestClassLines(str className) {
    M3 model = createM3FromEclipseProject(getTestProjectLocation());
    loc classToTest = getOneFrom({cls | cls <- classes(model), cls.file == className});
    return [trim(line) | line <- getLocationLines(classToTest)];
}

list[Line] getTestLines() {
    return [
        "a",

        "1", "2", "3", "4", "5", "6",       // 6
        "1", "2", "3", "4", "5", "6",       // 6
        "1", "2", "3", "4", "5", "6", "7",  // 6

        "a", "b", "c", "d", "e", "f", "g", "h",      // 8
        "a", "b", "c", "d", "e", "f", "g", "h",      // 8
        "a", "b", "c", "d", "e", "f", "g", "h", "i", // 8

        "b", "c"
    ]; // 42 duplicated.
}

test bool testDuplicationFromList() = 
    detectDuplicatesInLines(getTestLines()) == 42;

test bool testDuplicationFromFile() = 
    detectDuplicatesInLines(getTestClassLines(TEST_CLASS)) == 38;