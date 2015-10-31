module Metrics::LinesOfCode

/**
 * Lines of code: Many different metrics have been pro-posed for measuring volume. 
 * We could use a simple line of code metric (LOC), which counts all lines of source code that
 * are not comment or blank lines.
 */

import IO;
import String;
import List;

alias Line = str;

list[str] getLocationSrc(loc location) {
    // @TODO: something is wring with the lines here.
    list[Line] lines = readFileLines(location);
     
    return lines;
}

/**
 * Checks if a line is valid (not comment or blank lines).
 */
bool isValidLine(Line line) {
    
    // @TODO: False for multi comments.
    switch(line) {
        case /^[ \t\n]*$/: return false; // empty line
        case /^[ \t\n]+\/\/.*$/: return false; // line comment        
        default : return true;
    }
}

// avoid empty lines.
test bool isValidLine_empty()   = isValidLine("")   == false;
test bool isValidLine_space()   = isValidLine(" ")  == false;
test bool isValidLine_newLine() = isValidLine("\n") == false;
test bool isValidLine_tab()     = isValidLine("\t") == false;

// avoid comments.
test bool isValidLine_lineComment()     = isValidLine("// A line comment")              == false;
test bool isValidLine_mlCommentStart()  = isValidLine("/** A multi-line comment start") == false;
test bool isValidLine_mlCommentEnd()    = isValidLine("*/")                             == false;

// count statements, statements before and after multiline comments. 
test bool isValidLine_openBracket()             = isValidLine("{")              == true;
test bool isValidLine_closedBracket()           = isValidLine("}")              == true;
test bool isValidLine_statement()               = isValidLine("class X {")      == true;
test bool isValidLine_mlCommentStartStatement() = isValidLine("class X { /**")  == true;
test bool isValidLine_mlCommentEndStatement()   = isValidLine("*/class X {")    == true;


/**
 * Returns the number of (valid) lines in the specific location.
 */
public int countLinesOfCode(loc location) {
    return size([line | line <- getLocationSrc(location), isValidLine(line)]);
}

// TODO: Tests