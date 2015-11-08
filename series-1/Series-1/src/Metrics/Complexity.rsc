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
alias MethodLoc = loc;
alias MethodComplexityMap = map[MethodLoc, CyclomaticComplexity];

public MethodComplexityMap getComplexity(M3 model) {
    MethodComplexityMap methodsComplexity = ();
    
    set[MethodLoc] methods = methods(model);
    for (method <- methods) {
        Declaration methodAst = getMethodASTEclipse(method, model=model);
        CyclomaticComplexity complexity = cyclomaticComplexity(methodAst);
        // get only the implemented units.
        if (complexity > 0) methodsComplexity += (method:complexity);     
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

    // Match method with implementation, or contructor.
    if (\method(_, _, _, _, Statement impl) := methodAst ||
        \constructor(_, _, _, Statement impl) := methodAst) 
    {
        int result = 1;
        visit (impl) {
            case \if(_, _): result += 1;        // if then
            case \if(_, _, _): result += 1;     // if then else
            case \case(_): result += 1;         // case
            case \defaultCase(): result +=1;    // default case.
            case \conditional(_, _, _): result += 1; // ? :
            case /^&&$/: result += 1;           // &&
            case /^\|\|$/: result += 1;         // ||
            case \while(_, _): result += 1;     // while
            case \do(_, _): result += 1;        // do
            case \for(_, _, _, _): result += 1; // for condition
            case \for(_, _, _): result += 1;    // for
            case \catch(_, _): result += 1;     // catch
        }
        return result;
    }
    // no complexity since no implementation.
    return 0;
}
