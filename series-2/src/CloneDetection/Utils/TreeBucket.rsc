module CloneDetection::Utils::TreeBucket

import CloneDetection::Utils::TreeMass;

import List;
import lang::java::jdt::m3::AST;

alias Bucket = list[Statement];

@doc{
Sorts bucket by placing buckets with smaller mass in the begining
}
Bucket sortBucket(Bucket bucket) {
    return sort(bucket, bool (Statement a, Statement b) {
        return getTreeMass(a) < getTreeMass(b);
    });
}

@doc{
New buckets factory
}
Bucket newBucket() = [];

@doc{
Adds node to a existing bucket and returns the resulting bucket
}
Bucket addToBucket(Statement subTree, Bucket bucket) {
    return bucket + subTree;
}

@doc{
Adds ability to automatically reorder the bucket
}
Bucket addToBucket(Statement subTree, Bucket bucket, bool \sort) = 
        \sort ? sortBucket(addToBucket(subTree, bucket)) : addToBucket(subTree, bucket);

@doc{
Used to extract bucket from abstract syntax tree
}
Bucket extractBucketFromAST(set[Declaration] ast, minMassThreshold) {
    bucket = newBucket();
    
    top-down visit (ast) {
        case Statement subTree: {
            if (getTreeMass(subTree) >= minMassThreshold) {
                bucket = addToBucket(subTree, bucket);
            }
        }
    }
    
    return sortBucket(bucket);
}