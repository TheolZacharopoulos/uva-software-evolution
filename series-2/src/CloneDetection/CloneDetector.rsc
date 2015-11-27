module CloneDetection::CloneDetector

import CloneDetection::AbstractClonePairs;

import CloneDetection::Statements::TreeBucket;
import CloneDetection::Statements::CloneStatementPairs;
import CloneDetection::Statements::TreeSimilarity;

import CloneDetection::Sequences::StatementSequences;
import CloneDetection::Sequences::SubsequencesExtractor;
import CloneDetection::Sequences::SequenceBucket;
import CloneDetection::Sequences::SequenceSimilarity;

import Configurations;

import List;
import IO;
import lang::java::m3::AST;

ClonePairs detectExactClones(set[Declaration] ast) {
    buckets = extractBucketsFromAST(ast, TREE_MASS_THRESHOLD);
    clones = detectClonesInBuckets(buckets, 1.0);    
    return clones;
}

ClonePairsSeq detectSequenceClones(set[Declaration] ast) {

    // Get all the clone statement pairs
    ClonePairs cloneStatementPairs = detectExactClones(ast);
    
    // Build the list structures describing sequences
    Sequences allSequences = extractSequencesFromAST(ast);
    
    // Get max sequence length
    int maximumSequenceLength = getLargestSequenceSize(allSequences);
    
    // Cloned sequences results
    ClonePairsSeq cloneSequencePairs = newClonePairsSeq();
    
    for (sequenceLength <- [MINIMUM_SEQUENCE_LENGTH .. maximumSequenceLength]) {
    
        // Get all subsequences of length sequenceLength
        Sequences subSequences = getSubSequences(allSequences, sequenceLength);
        
        // Place all subsequences of length (sequenceLength) into buckets according to subsequence hash
        SequenceBuckets sequenceBuckets = constructSequenceBuckets(subSequences);
        
        for (bucketHash <- sequenceBuckets) {
        
            sequencesIndeces = index(sequenceBuckets[bucketHash]);
            
            for (originSeqIndex <- sequencesIndeces, 
                cloneSeqIndex <- sequencesIndeces, 
                originSeqIndex != cloneSeqIndex) 
            {
                Sequence originSeq = sequenceBuckets[bucketHash][originSeqIndex];
                Sequence cloneSeq = sequenceBuckets[bucketHash][cloneSeqIndex];
                        
                if (getSimilarityFactor(originSeq, cloneSeq) >= SIMILARITY_THRESHOLD) {
                    // TODO clear subclones here
                    // TODO add clone sequences here
                    // cloneSequencePairs = addClone(originSeq, cloneSeq, cloneSequencePairs);
                    ;
                }
            }
        }
    }
    
    return cloneSequencePairs;
}