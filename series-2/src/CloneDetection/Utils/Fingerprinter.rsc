@doc{
    A hash function is considered good if it minimizes the probability p 
    of hash value collision for two structurally different subtrees.
}
module CloneDetection::Utils::Fingerprinter

import lang::java::jdt::m3::AST;
import IO;
import List;
import Set;
import Node;
import String;
import CloneDetection::AbstractClonePairs;

str SIMILAR_ID = "Y";
str SIMILAR_STR = "X";
str SIMILAR_NUM = "6";
bool SIMILAR_BOOL = true;

public str getPerfectSeqFingerprint(Sequence seq) {
    return ("" | it + getPerfectFingerprint(st) | st <- seq);
}

public str getBadSeqFingerprint(Sequence seq) {
    return ("" | it + getBadFingerprint(st) | st <- seq);
}

public str getPerfectFingerprint(Statement tree) {
    // remove annotations because it makes it too perfect.
    cleanNode = delAnnotationsRec(tree);
    
    // get node as string
    return toString(cleanNode);
}

public str getBadFingerprint(Statement tree) {

    // remove literals and identifiers to make it dump
    tree = visit(tree) {
    
        // remove identifiers
        case s:\simpleName(_) => \simpleName(SIMILAR_ID)
        case cl:\class(_, a, b, c) => \class(SIMILAR_ID, a, b, c)
        case m:\method(a, _, b, c, d) => \method(a, SIMILAR_ID, b, c, d)
        case cons:\constructor(_, a, b, c) => \constructor(SIMILAR_ID, a, b, c)
        case p:\parameter(a, _, b) => \parameter(a, SIMILAR_ID, b)
        case v:\variable(_, a) => \variable(SIMILAR_ID, a)
        case va:\variable(_, a, b) => \variable(SIMILAR_ID, a, b)
        case l:\label(_, body) => \label(SIMILAR_ID, body)
        case en:\enum(_, a, b, c) => \enum(SIMILAR_ID, a, b, c)
        case im:\import(_) => \import(SIMILAR_ID)
        case pk:\package(_) => \package(SIMILAR_ID)
        case pkg:\package(a, _) => \package(a, SIMILAR_ID)
        case tp:\typeParameter(_, a) => \typeParameter(SIMILAR_ID, a)
        case ann:\annotationType(_, a) => \annotationType(SIMILAR_ID, a)
        case annT:\annotationTypeMember(a, _) => \annotationTypeMember(a, SIMILAR_ID)
        case annTM:\annotationTypeMember(a, _, b) => \annotationTypeMember(a, SIMILAR_ID, b)
        case va:\vararg(a, _) => \vararg(a, SIMILAR_ID)
        
        // calls
        case fa:\fieldAccess(a, b, _) => \fieldAccess(a, b, SIMILAR_ID)
        case fac:\fieldAccess(a, _) => \fieldAccess(a, SIMILAR_ID)
        case mc:\methodCall(a, _, b) => \methodCall(a, SIMILAR_ID, b)
        case mca:\methodCall(a, c, _, c) => \methodCall(a, b, SIMILAR_ID, c)
        
        // literals        
        case sl:\stringLiteral(_) => \stringLiteral(SIMILAR_STR)
        case cl:\characterLiteral(_) => \characterLiteral(SIMILAR_STR)
        case bl:\booleanLiteral(_) => \booleanLiteral(SIMILAR_BOOL)
        case nl:\number(_) => \number(SIMILAR_NUM)
    }
    
    // remove annotations because it makes it too perfect.
    cleanNode = delAnnotationsRec(tree);
    
    // get node as string
    return toString(cleanNode);
}