module CloneDetection::IdenticalClones

import CloneDetection::Utils;
import Configurations;

import lang::java::m3::AST;
import List;
import Node;
import IO;

Clones detectExactClones(set[Declaration] ast) {
    
    // Step 1: New bucket
    bucket = newBucket();
    
    // Step 2: fill the bucket (Two girls one bucket)
    top-down visit (ast) {
        case node subTree: {
            if (getTreeMass(subTree) >= TREE_MASS_THRESHOLD) {
                bucket = addToBucket(subTree, bucket);
            }
        }
        case set[node] subTreeSet: {
            if (getTreeMass(subTreeSet) >= TREE_MASS_THRESHOLD) {
                bucket = addToBucket(subTreeSet, bucket);
            }
        }
    }
    
    // sort the bucket (extra step, not mentioned in the paper :shame:)
    bucket = sortBucket(bucket);
    
    clones = newClones();
    
    // Step 3: Detect clones
    for (origin <- bucket, clone <- bucket, getSimilarityFactor(origin, clone) == 1.0) {
        clones = clearSubTreesFromSet(origin, clones);
        clones = clearSubTreesFromSet(clone, clones);
        clones = addClone(origin, clone, clones);
    }
    
    return clones;
}