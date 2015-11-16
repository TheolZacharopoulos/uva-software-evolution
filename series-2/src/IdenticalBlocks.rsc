module IdenticalBlocks

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import Prelude;

alias ClonesSet = set[tuple[loc original, loc clone]];

ClonesSet findIndenticalNodes(set[Declaration] complicationUnits)
{    
    ClonesSet foundClones = {};
    
    top-down visit (complicationUnits) {
        case originalMethod:\method(_, _, _, _, _): {
            top-down-break visit (complicationUnits) {
                case cloneMethod:\method(_, _, _, _, _): {
                    if (originalMethod@src != cloneMethod@src 
                        && delAnnotationsRec(originalMethod) == delAnnotationsRec(cloneMethod)) {
                        foundClones += <originalMethod@src, cloneMethod@src>;
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