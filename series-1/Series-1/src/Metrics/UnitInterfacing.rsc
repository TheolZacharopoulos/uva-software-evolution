module Metrics::UnitInterfacing

/**
 * Describes the number of the parameters of a unit (method)
 */
 
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

import List;
import IO;

alias ParametersNumber = int;
alias UnitLoc = loc;
alias UnitInterfacingMap = map[UnitLoc, ParametersNumber];

public UnitInterfacingMap getUnitInterfacing(M3 model) {
    UnitInterfacingMap unitsInterfacing = ();
    
    for (method <- methods(model)) {
        Declaration methodAst = getMethodASTEclipse(method, model=model);
        ParametersNumber paramersNum = findUnitInterfacing(methodAst);
        unitsInterfacing += (method:paramersNum);     
    }
    return unitsInterfacing;
}

private ParametersNumber findUnitInterfacing(Declaration methodAst) {
    return top-down-break visit(methodAst) {
        case \method(_, _, list[Declaration] parameters, _): return size(parameters);
        case \method(_, _, list[Declaration] parameters, _, _): return size(parameters);
        case \constructor(_, list[Declaration] parameters, _, _): return size(parameters);
        default: return 0;
    };    
}