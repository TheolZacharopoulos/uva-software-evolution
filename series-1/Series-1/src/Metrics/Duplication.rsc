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
import List;
import Map;
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

private NumberOfDuplicates detectDuplicatesInLines(list[Line] lines) {
    NumberOfDuplicates duplicatesNum = 0;
    map[int startIndex, list[Line] block] duplicatedLines = ();
    
    map[int startIndex, list[Line] block] blocksRepository = ();
    
    int currentIndex = 0;
    
    while (currentIndex <= size(lines)) {
    
        // Construct a pattern of size DUPLICATION_THRESHOLD, to check fir duplication.
        list[Line] blockToCheck = getBlock(lines, currentIndex, DUPLICATION_THRESHOLD);
        
        // Search if the pattern exists in the lines.
        if (blockToCheck in range(duplicatedLines)) {
            // Increase the duplicates                
            duplicatesNum += 1;
            // Jump to the next block.
            blocksRepository[currentIndex] = blockToCheck;
            currentIndex += DUPLICATION_THRESHOLD-1;
            
        }        
        // append the pattern to the lines
        duplicatedLines[currentIndex] = blockToCheck;
        currentIndex += 1; // next index
    }   
    
    
    map[int, map[int startIndex, list[Line] block]] duplicatingBlocksMap = ();
    list[int] blacklist = [];
    
    for (startIndex <- blocksRepository) {
        block = blocksRepository[startIndex];
        for (duplicateIndex <- duplicatedLines) {
            if (block == duplicatedLines[duplicateIndex] && duplicateIndex != startIndex && duplicateIndex notin blacklist) {
                blacklist += duplicateIndex;
                duplicatingBlocksMap[startIndex] ? (duplicateIndex:block) += (duplicateIndex:block);
            }
        }
    }    
    
    map[int, int] originalIndexMargin = ();
    
    
    
    for (originalStartIndex <- duplicatingBlocksMap) {
        margin = 1;
        
        // originalBlock = blocksRepository[originalStartIndex] + extraLine;
        originalBlock = expandBlock(lines, originalStartIndex, margin);
            
        duplicates = duplicatingBlocksMap[originalStartIndex];
        
        for (duplicateStartIndex <- duplicates) {
        
            expandedDuplicate = expandBlock(lines, duplicateStartIndex, margin);
            
            if (expandedDuplicate == originalBlock) {
                margin += 1;
            } else {
                break;
            }
        }
        
        originalIndexMargin[originalStartIndex] = margin;
    }
    
    println("=============HERE============");
    iprintln(originalIndexMargin);
    println("=============ENDHERE============");
    
    return duplicatesNum;
}

public list[Line] expandBlock(list[Line] overallLines, int startIndex, int margin)
{
    end = startIndex + DUPLICATION_THRESHOLD + margin;
    return overallLines[startIndex..end];
}

// TODO: Tests

public NumberOfDuplicates detectDuplicates(M3 model) {
    list[Line] lines = getAllLinesFromModel(model);    
    return detectDuplicatesInLines(lines);
}