module Metrics::Duplication2

/**
 * We calculate code duplication as the percentage of all code that 
 * occurs more than once in equal code blocks of at least 6 lines. 
 * When comparing code lines, we ignore leading spaces. 
 * So, if a single line is repeated many times, but the lines before
 * and after differ every time, we do not count it as duplicated. 
 * If however, a group of 6 lines appears unchanged in more than one 
 * place, we count it as duplicated. 
 * Apart from removing leading spaces, the duplication we measure is 
 * an exact string matching duplication.
 */

import IO;
import String;
import List;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

import Configurations;
import Metrics::LinesOfCode;
import Metrics::Utils::SourceCleaner;

alias NumberOfDuplicates = int;
alias LineDuplicates = map[Line lineSrc, int lineIndex];

int DUPLICATION_THRESHOLD = getDuplicationThreshold();

private list[Line] getAllLinesFromModel(M3 model) {
    set[loc] classes = classes(model);
    list[Line] allLines = [];
    
    for (class <- classes) {
        list [Line] classLines = getLocationLines(class);
        allLines += classLines;
    }
    
    return [trim(line) | line <- allLines];
}

private list[Line] getBlock(list[Line] lines, int \index, int duplicationThresehold) {
    return lines[\index .. (\index + duplicationThresehold)];
}

public NumberOfDuplicates detectDuplicates(M3 model) {
    list[Line] lines = getAllLinesFromModel(model);    
    NumberOfDuplicates duplicatesNum = 0;
    list[Line] duplicatedLines = [];
    
    for (currentIndex <- [0..size(lines)]) {        
        // Construct duplication pattern
        list[Line] blockToCheck = getBlock(lines, currentIndex, DUPLICATION_THRESHOLD);            
        duplPattern = ("" | it + blockLine | blockLine <- blockToCheck);
        
        // Search if the pattern exists in the lines.
        if (duplPattern in duplicatedLines) {
            println(" <duplicatesNum> : <duplPattern>");                
            duplicatesNum += 1;
        }        
        // append the duplication pattern
        duplicatedLines += duplPattern;
    }
    return duplicatesNum;
}