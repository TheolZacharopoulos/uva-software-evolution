module Metrics::Complexity

import lang::java::jdt::m3::AST;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

/**
 * Unit Cyclomatic complexity:
 * The complexity follows a power law distribution, so calculating 
 * an average of the complexities of individual units will give a 
 * result that may smooth out the outliers. 
 * Summation of unit complexities provides a complexity number 
 * of the entire system. From the cyclomatic complexity of each unit, 
 * we can determine its risk level.
 */
 
import Metrics::LinesOfCode;
import IO;
  
alias CyclomaticComplexity = int;

public map[loc, CyclomaticComplexity] getComplexity(M3 model) {
    map[loc, CyclomaticComplexity] methodsComplexity = ();
    
    set[loc] methods = methods(model);
    for (method <- methods) {
        Declaration methodAst = getMethodASTEclipse(method, model=model);
        CyclomaticComplexity complexity = cyclomaticComplexity(methodAst);
        methodsComplexity += (method:complexity);     
    }
    return methodsComplexity;
}

/**
 * In Java the following statements 
 * and operators count as branch points:
 * if, case, ?, &&, ||, while, for, catch
 * (Source: Building Maintainable software, SIG) 
 */
// For the pattern matching:
// http://tutor.rascal-mpl.org/Rascal/Rascal.html#/Rascal/Libraries/lang/java/m3/AST/Declaration/Declaration.html
CyclomaticComplexity cyclomaticComplexity(Declaration methodAst) {

    // Match method with implementation
    if (\method(Type \return, str name, list[Declaration] parameters, list[Expression] exceptions, Statement impl) := methodAst) {
        int result = 1;
        visit (impl) {
            case \if(Expression condition, Statement thenBranch): result += 1; // if then
            case \if(Expression condition, Statement thenBranch, Statement elseBranch): result += 1; // if then else
            case \case(Expression expression): result += 1; // case
            case \defaultCase(): result +=1; // default case.
            case \conditional(Expression expression, Expression thenBranch, Expression elseBranch): result += 1; // ? :
            case /^&&$/: result += 1; // &&
            case /^\|\|$/: result += 1; // ||
            case \while(Expression condition, Statement body): result += 1; // while
            case \do(Statement body, Expression condition): result += 1; // do
            case \for(list[Expression] initializers, Expression condition, list[Expression] updaters, Statement body): result += 1; // for condition
            case \for(list[Expression] initializers, list[Expression] updaters, Statement body): result += 1; // for
            case \catch(Declaration exception, Statement body): result += 1; // catch
        }
        return result;
    }
    // no complexity since no implementation.
    return 0;
}
