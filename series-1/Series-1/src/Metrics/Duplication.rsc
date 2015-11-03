module Metrics::Duplication

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
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

import Configurations;
import Metrics::LinesOfCode;
import Metrics::Utils::SourceCleaner;

alias NumberOfDuplicates = int;
alias LineDuplicates = map[Line lineSrc, int lineIndex];

int DUPLICATION_THRESHOLD = getDuplicationThreshold();

private list[Line] getAllLinesFromModel(M3 model) {
    //set[loc] classes = classes(model);
    
    // For testing
    set[loc] classes = {|java+class:///Clone1|, |java+class:///Clone2|};
    
    list[Line] allLines = [];
    
    for (class <- classes) {
        list [Line] classLines = getLocationLines(class);
        allLines += classLines;
    }
    
    return [trim(line) | line <- allLines];
}

alias Index = int;
private list[Index] findSameLine(list[Line] lines, Line lineToFind) {
    // TODO: binary search, return the index
    return []; // not found
}

private list[Line] getBlock(list[Line] lines, int \index, int duplicationThresehold)
{
    return lines[\index .. (\index + duplicationThresehold)];
}

public NumberOfDuplicates detectDuplicates(M3 model) {
    list[Line] lines = getAllLinesFromModel(model);
    
    //int duplicatedLines = 0;
    int duplicates = 0;
    //LineDuplicates duplicates = ();
    
    for (currentIndex <- index(lines)) {
        // current line
        line = lines[currentIndex];
        
        // initilize detection index
        //duplicates[line] = 1;
        
        // get a block of (6) lines for the original index.
        list[Line] originalBlock = getBlock(lines, currentIndex, DUPLICATION_THRESHOLD);
            
        // get the indexes for of the first same line
        list[Index] lineFoundIndexes = findSameLine(lines, line);
        
        // remove the current index from the list of duplicated indexes. 
        lineFoundIndexes = lineFoundIndexes - currentIndex;
        
        // loop over indexes
        for (index <- lineFoundIndexes) {
        
            // get a block of (6) lines after the index given.
            list[Line] block = getBlock(lines, index, DUPLICATION_THRESHOLD);
            
            if (originalBlock == block) {
                duplicates ++;                       
            }
        }
        println(" \> <line>");
    }
    
    return 0;
}

test bool getBlockTest() {
    lines = ["test1", "test2", "test3", "test4", "test5", "test6", "test7", "test8"];
    startIndex = 3; // test4
    thresehold = 4; // test8
    
    return ["test4", "test5", "test6", "test7"] == getBlock(lines, startIndex, thresehold);
}