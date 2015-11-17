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
    
    return { <occurance.original, occurance.clone> | 
                occurance <- clonedMethods, 
                mirrored <- clonedMethods, 
                occurance.original == mirrored.clone,
                occurance.clone == mirrored.original
    };
}

@doc{
Extracts methods only out of AST
}
private list[Declaration] getMethods(set[Declaration] complicationUnits) {
    list[Declaration] methods = [];
    top-down-break visit (complicationUnits) {
        case methodFound:\method(_, _, _, _, _): methods += methodFound;
    }
    
    return methods;
}

private Clones seekSameMethods(list[Declaration] \methods) = {
    <originalMethod, cloneMethod> | 
        originalMethod <- \methods,
        cloneMethod <- \methods,
        originalMethod@src != cloneMethod@src,
        originalMethod == cloneMethod
};

private Clones seekSameStatements(list[Declaration] \methods, Clones foundCloneMethods) {

    map[Declaration, list[Statement]] methodStatements = ();
    
    excludedMethods = [occurance.orginal, occurance.clone | occurance <- foundCloneMethods];
    
    for (\method <- \methods, \method notin excludedMethods) {
        methodStatements[\method] = [];
    
        top-down visit (\method) {
            case Statement stmt: {
                methodStatements[\method] += [stmt];
            }
        }
    }
    
    return {};
}