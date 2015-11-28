module CloneDetection::CloneDetector

import CloneDetection::AbstractClonePairs;

import CloneDetection::Statements::TreeBucket;
import CloneDetection::Statements::CloneStatementPairs;
import CloneDetection::Statements::TreeSimilarity;

import CloneDetection::Sequences::StatementSequences;
import CloneDetection::Sequences::SubsequencesExtractor;
import CloneDetection::Sequences::SequenceBucket;
import CloneDetection::Sequences::SequenceSimilarity;
import CloneDetection::Sequences::CloneSequencePairs;

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

    // * Build the list structures describing sequences
    Sequences allSequences = extractSequencesFromAST(ast);
    
    // Get max sequence length
    int maximumSequenceLength = getLargestSequenceSize(allSequences);
    
    // Cloned sequences results
    ClonePairsSeq cloneSequencePairs = newClonePairsSeq();    
    
    // * For k = MinimumSequenceLengthThreshold to MaximumSequenceLength
    for (sequenceLength <- [MINIMUM_SEQUENCE_LENGTH .. maximumSequenceLength]) {
    
        // Get all subsequences of length sequenceLength
        Sequences subSequences = getSubSequences(allSequences, sequenceLength);
        
        // * Place all subsequences of length (sequenceLength) into buckets according to subsequence hash
        SequenceBuckets sequenceBuckets = constructSequenceBuckets(subSequences);
        
        for (bucketHash <- sequenceBuckets) {
        
            sequencesIndeces = index(sequenceBuckets[bucketHash]);
            
            // * For each subsequence i and j in same bucket
            for (originSeqIndex <- sequencesIndeces, 
                cloneSeqIndex <- sequencesIndeces, 
                originSeqIndex != cloneSeqIndex) 
            {
                Sequence originSubSeq = sequenceBuckets[bucketHash][originSeqIndex];
                Sequence cloneSubSeq = sequenceBuckets[bucketHash][cloneSeqIndex];
                
                // * If CompareSequences (i,j,k) > SimilarityThreshold
                if (getSimilarityFactor(originSubSeq, cloneSubSeq) >= SIMILARITY_THRESHOLD) {
                    // * RemoveSequenceSubclonesOf(clones,i,j,k)
                    
                    // * AddSequenceClonePair(Clones,i,j,k)
                    cloneSequencePairs = addSeqClone(originSubSeq, cloneSubSeq, cloneSequencePairs);
                }
            }
        }
    }
    
    return cloneSequencePairs;
}