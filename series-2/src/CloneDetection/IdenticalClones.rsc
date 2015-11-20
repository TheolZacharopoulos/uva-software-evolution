module CloneDetection::IdenticalClones

import CloneDetection::Utils;
import Configurations;

import lang::java::m3::AST;
import List;
import Node;
import IO;

anno int node @ uniqueKey;

Clones detectExactClones(set[Declaration] ast) {
    
    ast = putIdentifiers(ast);
    
    // Step 1: New bucket
    bucket = newBucket();

    top-down visit (ast) {
        case node subTree: {
            if (getTreeMass(subTree) >= TREE_MASS_THRESHOLD) {
                bucket = addToBucket(subTree, bucket);
            }
        }
    }
    
    // sort the bucket (extra step, not mentioned in the paper :shame:)
    bucket = sortBucket(bucket);
    
    clones = newClones();
    
    // Step 3: Detect clones
    for (origin <- bucket, clone <- bucket, clone@uniqueKey != origin@uniqueKey, getSimilarityFactor(origin, clone) == 1) {
        clones = clearSubTreesFromSet(origin, clones);
        clones = clearSubTreesFromSet(clone, clones);
        clones = addClone(origin, clone, clones);
    }
    
    return clones;
}