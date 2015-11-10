module Test::Metrics::ComplexityTests

import lang::java::jdt::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::m3::Core;
import Set;

import Configurations;
import Metrics::Complexity;

str TEST_CLASS = "ComplexityTests";

str IF_STATEMENT_TEST = "ifStatement()";
str IF_ELSE_STATEMENT_TEST = "ifElseStatement()";
str CASE_STATEMENT_TEST = "caseStatement()";
str COND_STATEMENT_TEST = "conditional()";

// TODO: The rest.

Declaration getTestMethod(str methodName) {
    M3 model = createM3FromEclipseProject(getTestProjectLocation());
    loc classToTest = getOneFrom({cls | cls <- classes(model), cls.file == TEST_CLASS});
    classMethods = methods(model, classToTest);
    loc methodToTest = getOneFrom({method | 
                                    method <- classMethods, 
                                    method.file == methodName});
                                    
    return getMethodASTEclipse(methodToTest, model=model);
}


test bool testIfStatement() = 
    cyclomaticComplexity(getTestMethod(IF_STATEMENT_TEST)) == 2;
    
test bool testIfElseStatement() = 
    cyclomaticComplexity(getTestMethod(IF_ELSE_STATEMENT_TEST)) == 2;
    
test bool testCaseStatement() = 
    cyclomaticComplexity(getTestMethod(CASE_STATEMENT_TEST)) == 5;
    
test bool testConditionalStatement() = 
    cyclomaticComplexity(getTestMethod(COND_STATEMENT_TEST)) == 2;