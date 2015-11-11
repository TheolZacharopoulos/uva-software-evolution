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
    if (\method(_, str name, _, _, Statement impl) := methodAst ||
        \constructor(str name, _, _, Statement impl) := methodAst) 
    {
        int result = 1;
        
        visit (impl) {
            case \if(\booleanLiteral(true), _): result += 0;  // if (true) then
            case \if(\booleanLiteral(false), _): result += 0; // if (false) then
            case \if(\infix(\booleanLiteral(true), /^\|\|$/, _), _): result += 0; // if (true) then
            case \if(\infix(_, /^\|\|$/, \booleanLiteral(true)), _): result += 0; // if (true) then
            case \if(\infix(\booleanLiteral(false), /^&&$/, _), _): result += 0; // if (false) then
            case \if(\infix(_, /^&&$/, \booleanLiteral(false)), _): result += 0; // if (false) then            
            case \if(_, _): result += 1;        // if () then
            
            case \if(\booleanLiteral(true), _, _): result += 0;  // if (true) then else
            case \if(\booleanLiteral(false), _, _): result += 0; // if (false) then else
            case \if(\infix(\booleanLiteral(true), /^\|\|$/, _), _, _): result += 0; // if (true) then else
            case \if(\infix(_, /^\|\|$/, \booleanLiteral(true)), _, _): result += 0; // if (true) then else
            case \if(\infix(\booleanLiteral(false), /^&&$/, _), _, _): result += 0; // if (false) then else
            case \if(\infix(_, /^&&$/, \booleanLiteral(false)), _, _): result += 0; // if (false) then else       
            case \if(_, _, _): result += 1;     // if then else
            
            case \case(_): result += 1;         // case
            
            case \conditional(_, _, _): result += 1; // ? :
            
            case \infix(\booleanLiteral(true), /^\|\|$/, _): result += 0; // true || X
            case \infix(_, /^\|\|$/, \booleanLiteral(true)): result += 0; // X || true
            case \infix(_, /^\|\|$/, _): result += 1; // X || X
            
            case \infix(\booleanLiteral(false), /^&&$/, _): result += 0;  // false && X
            case \infix(_, /^&&$/, \booleanLiteral(false)): result += 0;  // X && false
            case \infix(_, /^&&$/, _): result += 1;  // X && X
            
            case \while(\booleanLiteral(true), _): result += 0;  // while (true)
            case \while(\booleanLiteral(false), _): result += 0; // while (false)
            case \while(\infix(\booleanLiteral(true), /^\|\|$/, _), _): result += 0; // while (true) 
            case \while(\infix(_, /^\|\|$/, \booleanLiteral(true)), _): result += 0; // while (true) 
            case \while(\infix(\booleanLiteral(false), /^&&$/, _), _): result += 0; // while (false) 
            case \while(\infix(_, /^&&$/, \booleanLiteral(false)), _): result += 0; // while (false)             
            case \while(_, _): result += 1;     // while
            
            case \do(_, \infix(\booleanLiteral(true), /^\|\|$/, _)): result += 0; // do (true) 
            case \do(_, \infix(_, /^\|\|$/, \booleanLiteral(true))): result += 0; // do (true) 
            case \do(_, \infix(\booleanLiteral(false), /^&&$/, _)): result += 0; // do (false) 
            case \do(_, \infix(_, /^&&$/, \booleanLiteral(false))): result += 0; // do (false)             
            case \do(_, \booleanLiteral(true)): result += 0;        // do (true)
            case \do(_, \booleanLiteral(false)): result += 0;        // do (false) 
            case \do(_, _): result += 1;        // do
            
            case \for(_, _, _, _): result += 1; // for condition            
            case \for(_, _, _): result += 1;    // for
            case \foreach(_, _, _): result += 1; // foreach
            case \catch(_, _): result += 1;     // catch
        }
        return result;
    }
    // no complexity since no implementation.
    return 0;
}
