module Metrics::Utils::SourceCleaner

import IO;
import String;

alias Source = str;

/**
 * Removes the C-Style Single line comments from the source
 * @param source, the input source.
 * @return the source without the single line comments.
 */ 
private Source removeSingleLineComments(Source source) {
    return visit(source) {
        case /^[ \t\n]*\/\/.*/ => ""   
    };
}

/**
 * Removes the C-Style Multi line comments from the source
 * @param source, the input source.
 * @return the source without the multi line comments.
 */ 
private Source removeMultiLineComments(Source source) {
    return visit(source) {
        case /\/\*[\s\S]*?\*\// => ""  
    };
}

/**
 * Removes the empty lines from the source
 * @param source, the input source.
 * @return the source without the empty lines.
 */ 
private Source removeEmptyLines(Source source) {
    return visit(source) {
        case /^\n[ \t\n]*\n/ => "\n"  
    };
}

/**
 * Clean the source from comments and empty lines.
 * @param source, the input source.
 * @return the source without the single line comments.
 */ 
public Source cleanSource(Source source) {
    return removeEmptyLines(
               removeMultiLineComments(
                   removeSingleLineComments(source)));
}