module CloneDetection::Strategy::TypeOne

import CloneDetection::Utils::Fingerprinter;
import CloneDetection::Utils::ParentIndex;
import CloneDetection::Utils::ClonesGeneralize;
import CloneDetection::AbstractClonePairs;
import CloneDetection::Statements::TreeSimilarity;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::Sequences::SubsequencesExtractor;
import CloneDetection::Sequences::SequenceBucket;
import CloneDetection::Utils::ProgressTracker;
import Configurations;

import lang::java::m3::AST;
import List;
import IO;
import Set;

ClonePairs detectTypeOne(set[Declaration] asts) {
    collectChildrenToParentIndexFromAST(asts);
    clonesSeqs = detectSequenceClones(asts, getSeqFingerprint);
    return generalizeClones(clonesSeqs, areParentsEqual);    
}

private bool areParentsEqual(node treeA, node treeB) = treeA == treeB;

private ClonePairs detectSequenceClones(set[Declaration] ast, str (Sequence) fingerprinter) {

    Sequences allSequences = extractSequencesFromAST(ast);
    int maximumSequenceLength = getLargestSequenceSize(allSequences);
    ClonePairs cloneSequencePairs = newClonePairs();
    
    sequenceLengths = [MINIMUM_SEQUENCE_LENGTH .. (maximumSequenceLength + 1)];
    
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