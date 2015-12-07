@doc{
    A hash function is considered good if it minimizes the probability p 
    of hash value collision for two structurally different subtrees.
}
module CloneDetection::Utils::Fingerprinter

import Node;
import String;
import lang::java::jdt::m3::AST;
import CloneDetection::AbstractClonePairs;
import CloneDetection::Utils::FingerprintCache;
import CloneDetection::Utils::ASTUnifier;

anno int node @ uniqueKey;

str SIMILAR_ID = "Y";
str SIMILAR_STR = "X";
str SIMILAR_NUM = "6";
bool SIMILAR_BOOL = true;

public str getSeqFingerprint(Sequence seq) {
    return ("" | it + getFingerprint(st) | st <- seq);
}

public str getFingerprint(node tree) = getCachedFingerprint(tree) when isFingerprintCached(tree);

public str getFingerprint(node tree) {

    // remove annotations because it makes it too perfect.
    cleanNode = delAnnotationsRec(tree);
    
    fingerprint = toString(cleanNode);
    
    addFingerprintCache(tree, fingerprint);
    
    // get node as string
    return fingerprint;
}