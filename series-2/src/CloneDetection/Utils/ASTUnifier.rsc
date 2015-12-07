module CloneDetection::Utils::ASTUnifier

import lang::java::jdt::m3::AST;
import IO;
import List;
import Set;

anno int Statement @ uniqueKey;
anno int Declaration @ uniqueKey;

str SIMILAR_ID = "Y";
str SIMILAR_STR = "X";
str SIMILAR_NUM = "6";
bool SIMILAR_BOOL = true;

public &E unifyAST(&E tree) {

    // remove literals and identifiers to make it dump
    return visit(tree) {
    
        // remove identifiers        
        case s:\simpleName(_) => replaceNode(\simpleName(SIMILAR_ID), s)
        case cl:\class(_, a, b, c) => replaceNode(\class(SIMILAR_ID, a, b, c), cl)
        case m:\method(a, _, b, c, d) => replaceNode(\method(a, SIMILAR_ID, b, c, d), m)
        case cons:\constructor(_, a, b, c) => replaceNode(\constructor(SIMILAR_ID, a, b, c), cons)
        case p:\parameter(a, _, b) => replaceNode(\parameter(a, SIMILAR_ID, b), p)
        case v:\variable(_, a) => replaceNode(\variable(SIMILAR_ID, a), v)
        case va:\variable(_, a, b) => replaceNode(\variable(SIMILAR_ID, a, b), va)
        case l:\label(_, body) => replaceNode(\label(SIMILAR_ID, body), l)
        case en:\enum(_, a, b, c) => replaceNode(\enum(SIMILAR_ID, a, b, c), en)
        case im:\import(_) => replaceNode(\import(SIMILAR_ID), im)
        case pk:\package(_) => replaceNode(\package(SIMILAR_ID), pk)
        case pkg:\package(a, _) => replaceNode(\package(a, SIMILAR_ID), pkg)
        case tp:\typeParameter(_, a) => replaceNode(\typeParameter(SIMILAR_ID, a), tp)
        case ann:\annotationType(_, a) => replaceNode(\annotationType(SIMILAR_ID, a), ann)
        case annT:\annotationTypeMember(a, _) => replaceNode(\annotationTypeMember(a, SIMILAR_ID), annT)
        case annTM:\annotationTypeMember(a, _, b) => replaceNode(\annotationTypeMember(a, SIMILAR_ID, b), annTM)
        case va:\vararg(a, _) => replaceNode(\vararg(a, SIMILAR_ID), va)
        
        // calls
        case fa:\fieldAccess(a, b, _) => replaceNode(\fieldAccess(a, b, SIMILAR_ID), fa)
        case fac:\fieldAccess(a, _) => replaceNode(\fieldAccess(a, SIMILAR_ID), fac)
        case mc:\methodCall(a, _, b) => replaceNode(\methodCall(a, SIMILAR_ID, b), mc)
        case mca:\methodCall(a, c, _, c) => replaceNode(\methodCall(a, b, SIMILAR_ID, c), mca)
        
        // literals        
        case sl:\stringLiteral(_) => replaceNode(\stringLiteral(SIMILAR_STR), sl)
        case cl:\characterLiteral(_) => replaceNode(\characterLiteral(SIMILAR_STR), cl)
        case bl:\booleanLiteral(_) => replaceNode(\booleanLiteral(SIMILAR_BOOL), bl)
        case nl:\number(_) => replaceNode(\number(SIMILAR_NUM), nl)
    }
}

private &E replaceNode(&E resultTree, &E originTree) {
    
    if (originTree@uniqueKey?) {
        resultTree@uniqueKey = originTree@uniqueKey;
    }
    
    if (originTree@src?) {
        resultTree@src = originTree@src;
    }
    
    return resultTree;
}