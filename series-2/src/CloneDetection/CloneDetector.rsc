module CloneDetection::CloneDetector

import CloneDetection::Utils;
import Configurations;
import CloneDetection::Utils::CloneStatementPairs;

import lang::java::m3::AST;

Clones detectExactClones(set[Declaration] ast) {
    buckets = extractBucketsFromAST(ast, TREE_MASS_THRESHOLD);
    clones = detectClonesInBuckets(buckets, 1.0);    
    return clones;
}

Clones detectSequenceClones(set[Declaration] ast) {

    // Get all the clone statement pairs
    Clones cloneStatementPairs = detectIdenticalClones(ast);
    
    // Build the list structures describing sequences
    Sequences allSequences = extractSequencesFromAST(ast);
    
    // Get max sequence length
    int maximumSequenceLength = getLargestSequenceSize(allSequences);
    
    return for (
        sequence <- allSequences,
        sequenceLength := size(sequence),
        sequenceLength >= MINIMUM_SEQUENCE_LENGTH,
        sequenceLength <= maximumSequenceLength) 
    {
        // Get all subsequences.
        list[Sequences] subSequences = getSubSequences(sequence, sequenceLength);
        
        // Place all subsequences of length (sequenceLength) into buckets according to subsequence hash
        SequenceBuckets sequenceBuckets = constructSequenceBuckets(subSequences);
        
        // detect sequence clones
        append detectClonesSequencesInBuckets(sequenceBuckets);
    }
}