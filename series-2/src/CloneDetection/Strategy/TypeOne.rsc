module CloneDetection::Strategy::TypeOne

import CloneDetection::Utils::ASTIdentifier;
import CloneDetection::Utils::Fingerprinter;
import CloneDetection::Utils::ClonesGeneralize;
import CloneDetection::AbstractClonePairs;
import CloneDetection::Statements::TreeSimilarity;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::Sequences::SubsequencesExtractor;
import CloneDetection::Sequences::SequenceBucket;
import CloneDetection::Sequences::SequenceSimilarity;
import Configurations;

import lang::java::m3::AST;
import List;

ClonePairs detectTypeOne(set[Declaration] asts) {
    asts = putIdentifiers(asts);
    clonesSeqs = detectSequenceClones(asts);
    return generalizeClones(clonesSeqs);    
}

private ClonePairsSeq detectSequenceClones(set[Declaration] ast) {

    Sequences allSequences = extractSequencesFromAST(ast);
    int maximumSequenceLength = getLargestSequenceSize(allSequences);
    ClonePairsSeq cloneSequencePairs = newClonePairsSeq();
    
    for (sequenceLength <- [MINIMUM_SEQUENCE_LENGTH .. (maximumSequenceLength + 1)]) {
        Sequences subSequences = getSubSequences(allSequences, sequenceLength);
        SequenceBuckets sequenceBuckets = constructSequenceBuckets(subSequences, getPerfectSeqFingerprint);
        
        for (bucketHash <- sequenceBuckets) {

            sequencesIndeces = index(sequenceBuckets[bucketHash]);

            // * For each subsequence i and j in same bucket
            for (originSeqIndex <- sequencesIndeces,
                cloneSeqIndex <- sequencesIndeces,
                originSeqIndex != cloneSeqIndex)
            {
                Sequence originSubSeq = sequenceBuckets[bucketHash][originSeqIndex];
                Sequence cloneSubSeq = sequenceBuckets[bucketHash][cloneSeqIndex];

                // * RemoveSequenceSubclonesOf(clones, i, j, k)
                cloneSequencePairs = removeSequenceSubclones(originSubSeq, cloneSubSeq, cloneSequencePairs);

                // * AddSequenceClonePair(Clones, i, j, k)
                cloneSequencePairs = addSeqClone(originSubSeq, cloneSubSeq, cloneSequencePairs);
            }
        }
    }    
    return cloneSequencePairs;
}