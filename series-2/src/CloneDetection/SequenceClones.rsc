module CloneDetection::SequenceClones

import CloneDetection::IdenticalClones;
import CloneDetection::Utils;
import lang::java::m3::AST;

import Prelude;

void detectSequenceClones(set[Declaration] ast) {
    Clones clonedStatements = detectExactClones(ast);
    Sequences sequences = getSequencesContainingClones(extractSequencesFromAST(ast), clonedStatements);
    
    sequenceBuckets = organizeSequenceBucketsByLength(sequences);
    
    iprintToFile(|project://Series-2/debug/debug-tree.txt|, sequenceBuckets[4]);
    
    return;
    Clones clonedSequences = newClones();
    for (sequenceLength <- sequenceBuckets) {
        SequenceBucket bucket = sequenceBuckets[sequenceLength];
        bucketIndexes = index(bucket);
        for (originIndex <- bucketIndexes, 
             cloneIndex <- bucketIndexes, 
             cloneIndex != originIndex) {
            Sequence originSequence = bucket[originIndex];
            Sequence cloneSequence = bucket[cloneIndex];
            
            if (getSimilarityFactor(originSequence, cloneSequence) >= SIMILARITY_THRESHOLD) {
                clones = clearSubSequences(originSequence, clones);
                clones = clearSubSequences(cloneSequence, clones);
                clonedSequences = addClone(originSequence, cloneSequence, clonedSequences);
            }
        }
    }
    
    println();
}