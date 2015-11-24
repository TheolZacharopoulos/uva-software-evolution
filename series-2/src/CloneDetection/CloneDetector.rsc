module CloneDetection::CloneDetector

import CloneDetection::AbstractClonePairs;
import CloneDetection::Utils;
import CloneDetection::Utils::CloneStatementPairs;
import CloneDetection::Utils::TreeSimilarity;

import Configurations;

import lang::java::m3::AST;

ClonePairs detectExactClones(set[Declaration] ast) {
    buckets = extractBucketsFromAST(ast, TREE_MASS_THRESHOLD);
    clones = detectClonesInBuckets(buckets, 1.0);    
    return clones;
}

ClonePairs detectSequenceClones(set[Declaration] ast) {

    // Get all the clone statement pairs
    ClonePairs cloneStatementPairs = detectIdenticalClones(ast);
    
    // Build the list structures describing sequences
    Sequences allSequences = extractSequencesFromAST(ast);
    
    // Get max sequence length
    int maximumSequenceLength = getLargestSequenceSize(allSequences);
    
    // Cloned sequences results
    ClonePairs cloneSequencePairs = newClonePairs();
    
    for (sequenceLength <- [MINIMUM_SEQUENCE_LENGTH .. maximumSequenceLength]) {
    
        // Get all subsequences of length sequenceLength
        subSequences = getSubSequences(allSequences, sequenceLength);
        
        // Place all subsequences of length (sequenceLength) into buckets according to subsequence hash
        SequenceBuckets sequenceBuckets = constructSequenceBuckets(subSequences);
        
        for (bucketHash <- sequenceBuckets) {
            sequencesIndeces = index(sequenceBuckets[bucketHash]);
            for (originSeqIndex <- sequencesIndeces, 
                cloneSeqIndex <- sequencesIndeces, 
                originSeqIndex != cloneSeqIndex) 
            {
                Sequence originSeq = sequenceBuckets[originSeqIndex];
                Sequence cloneSeq = sequenceBuckets[cloneSeqIndex];
                
                if (getSimilarityFactor(originSeq, cloneSeq) >= SIMILARITY_THRESHOLD) {
                    // TODO clear subclones here
                    cloneSequencePairs = addClone(originSeq, cloneSeq, cloneSequencePairs);
                }
            }
        }
    }
    
    return cloneSequencePairs;
}