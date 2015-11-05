module Test::Metrics::Utils::SourceCleanerTests

import Metrics::Utils::SourceCleaner;

import IO;
import String;

// removeSingleLineComments
test bool testRmvSngLnCmnt_1() = removeSingleLineComments("") == "";
test bool testRmvSngLnCmnt_2() = removeSingleLineComments("String x;") == "String x;";
test bool testRmvSngLnCmnt_3() = removeSingleLineComments("// comment") == "";
test bool testRmvSngLnCmnt_4() = removeSingleLineComments("String name; // name") == "String name;";

// removeMultiLineComments
test bool testRmvMltLnCmnt_1() = removeMultiLineComments("") == "";
test bool testRmvMltLnCmnt_2() = removeMultiLineComments("String x;") == "String x;";
test bool testRmvMltLnCmnt_3() = removeMultiLineComments("/* comment */") == "";
test bool testRmvMltLnCmnt_5() = removeMultiLineComments("String name; /** name */") == "String name; ";
test bool testRmvMltLnCmnt_6() = removeMultiLineComments("String name; /** name\n */") == "String name; ";

// removeEmptyLines
test bool testRmvEmptLnCmnt_1() = removeEmptyLines("") == "";
test bool testRmvEmptLnCmnt_2() = removeEmptyLines("String x;") == "String x;";
test bool testRmvEmptLnCmnt_3() = removeEmptyLines("\n\n") == "\n";
test bool testRmvEmptLnCmnt_4() = removeEmptyLines("String name; \n\n int age;") ==  "String name; \n int age;";

// cleanSource
test bool testcleanSource_1() = cleanSource("") == "";
test bool testcleanSource_2() = cleanSource("String x;") == "String x;";
test bool testcleanSource_3() = 
    cleanSource("// this is a name \n String name; /** name\n Yay */") == "\n String name; "; 