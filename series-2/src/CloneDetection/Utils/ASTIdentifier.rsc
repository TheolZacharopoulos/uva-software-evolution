module CloneDetection::Utils::ASTIdentifier

import lang::java::m3::AST;
import Prelude;

anno int Statement @ uniqueKey;
anno int Declaration @ uniqueKey;

@doc{
Creates unique identifiers for each node in the AST
}
&E putIdentifiers(&E ast) = putIdentifiers(ast, 0);

&E putIdentifiers(&E ast, int \start) {
    counter = \start;
    return bottom-up visit (ast) {
        case Statement subTree: {
            counter += 1;
            subTree = subTree[@uniqueKey = counter];
            
            insert subTree;
        }
        case Declaration subTree: {
            counter += 1;
            subTree = subTree[@uniqueKey = counter];
            
            insert subTree;
        }
    }
}
