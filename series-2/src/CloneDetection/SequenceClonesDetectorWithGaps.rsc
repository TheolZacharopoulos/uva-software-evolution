module CloneDetection::SequenceClonesDetectorWithGaps

import CloneDetection::ClonePairs;
import CloneDetection::Sequences::SequenceBucket;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::Sequences::SubsequencesExtractor;
import CloneDetection::Utils::ProgressTracker;
import CloneDetection::Utils::Fingerprinter;
import lang::java::m3::AST;
import Prelude;

ClonePairs detectSequenceClonesWithGaps(set[Declaration] ast, int minSequenceLength, int maxSequenceGap, set[str] (Sequence) fingerprinter) {

    cloneSequencePairs = newClonePairs();
    Sequences allSequences = extractSequencesFromAST(ast, minSequenceLength);
    SequenceBuckets sequenceBuckets = constructIntersectedSequenceBuckets(
        allSequences, minSequenceLength, maxSequenceGap, fingerprinter, getSeqFingerprint);
    
    startProgress("sequence-clones-gaps", size(sequenceBuckets));
    
    for (bucketHash <- sequenceBuckets) {
        
        advanceProgress("sequence-clones-gaps", 1);
        
        sequencesIndeces = index(sequenceBuckets[bucketHash]);

        // * For each subsequence i and j in same bucket
        for (originSeqIndex <- sequencesIndeces,
            cloneSeqIndex <- sequencesIndeces,
            originSeqIndex != cloneSeqIndex)
        {
            Sequence originSubSeq = sequenceBuckets[bucketHash][originSeqIndex];
            Sequence cloneSubSeq = sequenceBuckets[bucketHash][cloneSeqIndex];
            
            if (originSubSeq != cloneSubSeq) {
                // * AddSequenceClonePair(Clones, i, j, k)
                cloneSequencePairs = addClonePair(originSubSeq, cloneSubSeq, cloneSequencePairs);
            }
        }
    }
    
    endProgress("sequence-clones-gaps");
    
    return cloneSequencePairs;
}