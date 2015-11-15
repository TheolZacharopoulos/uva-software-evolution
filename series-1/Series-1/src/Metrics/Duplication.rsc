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
import Set;
import util::Math;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

import Configurations;
import Metrics::LinesOfCode;
import Metrics::Utils::SourceCleaner;

alias Index = int;
alias LineIndexes = map[Line lineSrc, int lineIndex];


int DUPLICATION_THRESHOLD = getDuplicationThreshold();

list[Line] getAllLinesFromModel(M3 model) {
    set[loc] classes = classes(model);
    list[Line] allLines = [];
    
    for (class <- classes) {
        list [Line] classLines = getLocationLines(class);
        allLines += classLines;
    }
    
    return [trim(line) | line <- allLines];
}

public int detectDuplicates(M3 model) {
    lines = getAllLinesFromModel(model);
    return detectDuplicatesInLines(lines);
}

int detectDuplicatesInLines(list[Line] lines) {
    
    // count the number of duplicated indexes, including the original.
    return size({ originalIndex, duplIndex |
                    
                    // get indexes for every line.
                    lineSrcToLineIndexes := toMap(zip(lines, index(lines))),
                    
                    // get the lines, which have more than 1 indexes (potential duplicates).
                    line <- lineSrcToLineIndexes, size(lineSrcToLineIndexes[line]) > 1,

                    // get the indexes, on a list so we can refer to them.
                    lineIndexes := toList(lineSrcToLineIndexes[line]),
                    
                    // loop over the original and duplicate blocks of the line indexes.
                    originalBlock <- upTill(size(lineIndexes)),                    
                                    (lineIndexes[originalBlock] + DUPLICATION_THRESHOLD) <= size(lines),                    
                    duplBlock <- [(originalBlock + 1) .. size(lineIndexes)], 
                                    (lineIndexes[duplBlock] + DUPLICATION_THRESHOLD) <= size(lines),
                                
                    // check if these blocks consist a duplicate.
                    duplicateSize := (0 | it + 1 | duplSize <- [0 .. DUPLICATION_THRESHOLD],
                        lines[lineIndexes[originalBlock] + duplSize] == lines[lineIndexes[duplBlock] + duplSize]), 
                    duplicateSize == DUPLICATION_THRESHOLD,
                    
                    // expand the blocks.
                    // since it's a set, it will not keep the indexes of smaller duplicate blocks. 
                    extraIndex <- [0 .. DUPLICATION_THRESHOLD],
                    originalIndex := lineIndexes[originalBlock] + extraIndex,
                    duplIndex     := lineIndexes[duplBlock] + extraIndex});    
}