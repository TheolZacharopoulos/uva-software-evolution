module Strategy::ExactFragments

import Strategy::Commons;

import Prelude;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

@doc{
Todo: Find out how to do this only with attaching annotations. 
Function needed for checking annotation existance.
}
private bool isAlreadyFound(CloneOccurance occurance, ClonesSet foundSoFar) {
    return (false | true | duplicate <- foundSoFar, duplicate.clone == occurance.original && duplicate.original == occurance.clone);
}

ClonesSet findExactFragments(set[Declaration] complicationUnits) {    
    ClonesSet foundClones = {};
    
    top-down visit (complicationUnits) {
        case originalMethod:\method(_, _, _, _, _): {
            top-down-break visit (complicationUnits) {
                case cloneMethod:\method(_, _, _, _, _): {
                    occurance = <originalMethod@src, cloneMethod@src>;
                    if (originalMethod@src != cloneMethod@src 
                        && delAnnotationsRec(originalMethod) == delAnnotationsRec(cloneMethod)
                        && !isAlreadyFound(occurance, foundClones)) {
                        foundClones += occurance;
                    }
                }
            }
        }
        /*
        TODO Find out how to skip records (statements found identical in methods comparision)
        case Statement stmt: {
            top-down-break visit (complicationUnits) {
                case Statement cloneStmt: {
                    if (stmt@src != cloneStmt@src && delAnnotationsRec(cloneStmt) == delAnnotationsRec(stmt)) {
                        foundClones += <stmt@src, cloneStmt@src>;
                    }
                }
            }
        }*/
    }
    
    return foundClones;
}