module CloneDetection::SequenceClonesDetector

import CloneDetection::ClonePairs;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::Sequences::SubsequencesExtractor;
import CloneDetection::Sequences::SequenceBucket;
import CloneDetection::Utils::ProgressTracker;
import lang::java::m3::AST;
import Prelude;

ClonePairs detectSequenceClones(set[Declaration] ast, int minSequenceLength, str (Sequence) fingerprinter) {

    Sequences allSequences = extractSequencesFromAST(ast);
    int maximumSequenceLength = getLargestSequenceSize(allSequences);
    ClonePairs cloneSequencePairs = newClonePairs();
    
    sequenceLengths = [minSequenceLength .. (maximumSequenceLength + 1)];
    
    startProgress("sequence-clones", size(sequenceLengths));
    
    for (sequenceLength <- sequenceLengths) {
        Sequences subSequences = getSubSequences(allSequences, sequenceLength);
        SequenceBuckets sequenceBuckets = constructSequenceBuckets(subSequences, fingerprinter);
        
        advanceProgress("sequence-clones", 1);
        
        for (bucketHash <- sequenceBuckets) {
            
            indicateProgressWork("sequence-clones");
            
            sequencesIndeces = index(sequenceBuckets[bucketHash]);

            // * For each subsequence i and j in same bucket
            for (originSeqIndex <- sequencesIndeces,
                cloneSeqIndex <- sequencesIndeces,
                originSeqIndex != cloneSeqIndex)
            {
                Sequence originSubSeq = sequenceBuckets[bucketHash][originSeqIndex];
                Sequence cloneSubSeq = sequenceBuckets[bucketHash][cloneSeqIndex];

                if (!isOverlap(originSubSeq, cloneSubSeq)) {
                    
                    // * RemoveSequenceSubclonesOf(clones, i, j, k)
                    cloneSequencePairs = removeSequenceSubclones(originSubSeq, cloneSubSeq, cloneSequencePairs);
    
                    // * AddSequenceClonePair(Clones, i, j, k)
                    cloneSequencePairs = addClonePair(originSubSeq, cloneSubSeq, cloneSequencePairs);
                }
            }
        }
    }
    
    endProgress("sequence-clones");
    
    return cloneSequencePairs;
}

private bool isOverlap(Sequence origin, Sequence clone) = getSequenceUniqueKeys(origin) & getSequenceUniqueKeys(clone) != {};