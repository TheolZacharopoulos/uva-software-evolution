module Test::Metrics::ComplexityTests

import lang::java::jdt::m3::AST;
import lang::java::jdt::m3::Core;
import lang::java::m3::Core;
import Set;

import Configurations;
import Metrics::Complexity;

str TEST_CLASS = "ComplexityTests";

str IF_STATEMENT_TEST = "ifStatement()";
str IF_TRUE_STATEMENT_TEST = "ifTrueStatement()";
str IF_FALSE_STATEMENT_TEST = "ifFalseStatement()";
str IF_ELSE_STATEMENT_TEST = "ifElseStatement()";

str CASE_STATEMENT_TEST = "caseStatement()";
str COND_STATEMENT_TEST = "conditional()";

str AND_STATEMENT_TEST = "andStatement()";
str AND_FALSE_STATEMENT_TEST = "andFalseStatement()";

str OR_STATEMENT_TEST = "orStatement()";
str OR_TRUE_STATEMENT_TEST = "orTrueStatement()";

str FOR_STATEMENT_TEST = "forStatement()";

str FOR_COND_STATEMENT_TEST = "forCondStatement()";

str WHILE_STATEMENT_TEST = "whileStatement()";

str DO_STATEMENT_TEST = "doStatement()";

str CATCH_STATEMENT_TEST = "catchStatement()";

Declaration getTestMethod(str methodName) {
    M3 model = createM3FromEclipseProject(getTestProjectLocation());
    loc classToTest = getOneFrom({cls | cls <- classes(model), cls.file == TEST_CLASS});
    classMethods = methods(model, classToTest);
    loc methodToTest = getOneFrom({method | 
                                    method <- classMethods, 
                                    method.file == methodName});
                                    
    return getMethodASTEclipse(methodToTest, model=model);
}

// If then
test bool testIfStatement() = 
    cyclomaticComplexity(getTestMethod(IF_STATEMENT_TEST)) == 2;

// if (true) {}
test bool testIfTrueStatement() = 
    cyclomaticComplexity(getTestMethod(IF_TRUE_STATEMENT_TEST)) == 1;

// if (false) {}
test bool testIfFalseStatement() = 
    cyclomaticComplexity(getTestMethod(IF_FALSE_STATEMENT_TEST)) == 1;

// if then else            
test bool testIfElseStatement() = 
    cyclomaticComplexity(getTestMethod(IF_ELSE_STATEMENT_TEST)) == 2;

// switch case
test bool testCaseStatement() = 
    cyclomaticComplexity(getTestMethod(CASE_STATEMENT_TEST)) == 5;

// cond ? then : else    
test bool testConditionalStatement() = 
    cyclomaticComplexity(getTestMethod(COND_STATEMENT_TEST)) == 2;
    
// &&    
test bool testANDStatement() = 
    cyclomaticComplexity(getTestMethod(AND_STATEMENT_TEST)) == 3;
    
// false &&    
test bool testANDFalseStatement() = 
    cyclomaticComplexity(getTestMethod(AND_FALSE_STATEMENT_TEST)) == 1;
    
// ||    
test bool testORStatement() = 
    cyclomaticComplexity(getTestMethod(OR_STATEMENT_TEST)) == 3;

// true ||    
test bool testORTrueStatement() = 
    cyclomaticComplexity(getTestMethod(OR_TRUE_STATEMENT_TEST)) == 1;
        
// for    
test bool testForStatement() = 
    cyclomaticComplexity(getTestMethod(FOR_STATEMENT_TEST)) == 2;
    
// for conditional
test bool testForCondStatement() = 
    cyclomaticComplexity(getTestMethod(FOR_COND_STATEMENT_TEST)) == 2;    
    
// while
test bool testWhileStatement() = 
    cyclomaticComplexity(getTestMethod(WHILE_STATEMENT_TEST)) == 2;
    
// do
test bool testDoStatement() = 
    cyclomaticComplexity(getTestMethod(DO_STATEMENT_TEST)) == 2;
    
// catch
test bool testCatchStatement() = 
    cyclomaticComplexity(getTestMethod(CATCH_STATEMENT_TEST)) == 2;