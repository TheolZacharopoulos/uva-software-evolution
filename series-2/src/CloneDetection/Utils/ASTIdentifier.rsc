module CloneDetection::Utils::ASTIdentifier

import lang::java::m3::AST;

anno int node @ uniqueKey;

@doc{
Creates unique identifiers for each node in the AST
}
&E putIdentifiers(&E ast) = putIdentifiers(ast, 0);

&E putIdentifiers(&E ast, int \start) {
    counter = \start;
    return visit (ast) {
        case node subTree: {
            counter += 1;
            subTree = subTree[@uniqueKey = counter];
            insert subTree;
        }
    }
}