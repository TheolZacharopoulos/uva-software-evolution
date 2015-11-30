module CloneDetection::Utils::ASTIdentifier

import CloneDetection::Utils::ParentIndex;

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
        case node subTree: {
            counter += 1;
            subTree = subTree[@uniqueKey = counter];
            
            setChildrenFromAParent(subTree);
            
            insert subTree;
        }
    }
}