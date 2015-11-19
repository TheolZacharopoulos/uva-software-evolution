module CloneDetection::Utils::ASTIdentifier

import lang::java::m3::AST;

anno int node @ uniqueKey;

@doc{
Creates unique identifiers for each node in the AST
}
set[Declaration] putIndetifiers(set[Declaration] ast) {
    counter = 0;
    return visit (ast) {
        case node subTree: {
            counter += 1;
            subTree = subTree[@uniqueKey = counter];
            insert subTree;
        }
    }
}