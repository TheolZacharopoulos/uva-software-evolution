module CloneDetection::IdenticalClones

import CloneDetection::Utils;
import Configurations;

import lang::java::m3::AST;
import List;
import Node;
import IO;

anno int Statement @ uniqueKey;

Clones detectExactClones(set[Declaration] ast) {
    
    bucket = extractBucketFromAST(ast, TREE_MASS_THRESHOLD);
    clones = detectClonesInBucket(bucket, 1.0);
    
    return clones;
}