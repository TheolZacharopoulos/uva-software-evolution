module CloneDetection::CloneDetector

import CloneDetection::Utils;
import Configurations;

import lang::java::m3::AST;

Clones detectExactClones(set[Declaration] ast) {
    
    buckets = extractBucketsFromAST(ast, TREE_MASS_THRESHOLD);
    clones = detectClonesInBuckets(buckets, 1.0);
    
    return clones;
}