module CloneDetection::Utils::TreeBucket

import CloneDetection::Utils::TreeMass;
import List;

alias Bucket = list[value];

@doc{
Sorts bucket by placing buckets with smaller mass in the begining
}
Bucket sortBucket(Bucket bucket) {
    return sort(bucket, bool (a, b) {
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
Bucket addToBucket(subTree, Bucket bucket) {
    return bucket + subTree;
}

@doc{
Adds ability to automatically reorder the bucket
}
Bucket addToBucket(subTree, Bucket bucket, bool \sort) = \sort ?  sortBucket(addToBucket(subTree, bucket)) : addToBucket(subTree, bucket);