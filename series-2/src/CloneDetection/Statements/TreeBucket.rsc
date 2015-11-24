module CloneDetection::Statements::TreeBucket

import CloneDetection::Statements::TreeMass;
import CloneDetection::Utils::Fingerprinter;

import List;
import lang::java::jdt::m3::AST;

alias Buckets = map[str, list[Statement]];

@doc{
New buckets factory
}
Buckets newBuckets() = ();

@doc{
Adds node to a bucket and returns the resulting buckets map
}
Buckets addToBucket(Statement subTree, Buckets buckets) {
    fingerPrint = getBadFingerprint(subTree);
    
    // TODO test
    list[Statement] emptyList = [];
    
    return buckets[fingerPrint] ? emptyList += subTree;
}

@doc{
Used to extract buckets from abstract syntax tree
}
Buckets extractBucketsFromAST(set[Declaration] ast, minMassThreshold) {
    buckets = newBuckets();
    
    top-down visit (ast) {
        case Statement subTree: {
            if (getTreeMass(subTree) >= minMassThreshold) {
                buckets = addToBucket(subTree, buckets);
            }
        }
    }
    
    return buckets;
}