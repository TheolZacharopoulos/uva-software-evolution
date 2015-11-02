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

test bool testRmvSngLnCmnt_1() = removeSingleLineComments("") == "";
test bool testRmvSngLnCmnt_2() = removeSingleLineComments("String x;") == "String x;";
test bool testRmvSngLnCmnt_3() = removeSingleLineComments("// comment") == "";
test bool testRmvSngLnCmnt_4() = removeSingleLineComments("String name; // name") == "String name;";

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

test bool testRmvMltLnCmnt_1() = removeMultiLineComments("") == "";
test bool testRmvMltLnCmnt_2() = removeMultiLineComments("String x;") == "String x;";
test bool testRmvMltLnCmnt_3() = removeMultiLineComments("/* comment */") == "";
test bool testRmvMltLnCmnt_5() = removeMultiLineComments("String name; /** name */") == "String name; ";
test bool testRmvMltLnCmnt_6() = removeMultiLineComments("String name; /** name\n */") == "String name; ";

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

test bool testRmvEmptLnCmnt_1() = removeEmptyLines("") == "";
test bool testRmvEmptLnCmnt_2() = removeEmptyLines("String x;") == "String x;";
test bool testRmvEmptLnCmnt_3() = removeEmptyLines("\n\n") == "\n";
test bool testRmvEmptLnCmnt_4() = removeEmptyLines("String name; \n\n int age;") ==  "String name; \n int age;";

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

test bool testcleanSource_1() = cleanSource("") == "";
test bool testcleanSource_2() = cleanSource("String x;") == "String x;";
test bool testcleanSource_3() = 
    cleanSource("// this is a name \n String name; /** name\n Yay */") == "\n String name; "; 