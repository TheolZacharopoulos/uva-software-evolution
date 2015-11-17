module Strategy::ExactFragments

import Strategy::Commons;

import Prelude;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

@doc{
Todo: Optimize visits. Use list of methods to prevent deep seeking on the first (top) visit. 
Furthermore, this visit can be deprecated in favour of simple loop. 
}
Clones findExactMethods(set[Declaration] complicationUnits) { 
    
    allMethods = getMethods(complicationUnits);
    
    clonedMethods = seekSameMethods(allMethods);
    
    return { occurance | 
                occurance <- clonedMethods, 
                mirrored <- clonedMethods, 
                occurance.originalDeclaration == mirrored.cloneDeclaration,
                occurance.cloneDeclaration == mirrored.originalDeclaration
    };
}

@doc{
Extracts methods only out of AST
}
list[Declaration] getMethods(set[Declaration] complicationUnits) {
    list[Declaration] methods = [];
    top-down-break visit (complicationUnits) {
        case methodFound:\method(_, _, _, _, _): methods += methodFound;
    }
    
    return methods;
}

private Clones seekSameMethods(list[Declaration] \methods) = {
    declaration(originalMethod, cloneMethod) | 
        originalMethod <- \methods,
        cloneMethod <- \methods,
        originalMethod@src != cloneMethod@src,
        originalMethod == cloneMethod
};

private Clones seekSameStatements(list[Statement] statements) = {
    statement(originalStmt, cloneStmt) | 
        originalStmt <- statements,
        cloneStmt <- statements,
        originalStmt@src != cloneStmt@src,
        originalStmt == cloneStmt
};