module CloneDetection::IdenticalClones

import CloneDetection::Utils;
import Configurations;

import lang::java::m3::AST;
import List;
import Node;
import IO;

anno int node @ uniqueKey;

Clones detectExactClones(set[Declaration] ast) {
    
    print("Adding unique identifiers...");
    ast = putIdentifiers(ast);
    println("Done!");
    
    // Step 1: New bucket
    print("Building bucket from AST...");
    bucket = extractBucketFromAST(ast, TREE_MASS_THRESHOLD);
    println("Done!");    
    
    print("Detecting clones...");
    clones = detectClonesInBucket(bucket, 1);
    println("Done!");
    
    return clones;
}