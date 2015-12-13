module CloneDetection::Strategy::TypeThree

extend CloneDetection::Strategy::TypeOne;

import CloneDetection::Utils::ASTUnifier;
import CloneDetection::SequenceClonesDetectorWithGaps;
import CloneDetection::ClonePairs;
import lang::java::m3::AST;
import IO;

ClonePairs detectTypeThree(set[Declaration] asts, int minSequenceLength, int maxSequenceGap) {
    clonesSeqs = detectSequenceClonesWithGaps(asts, minSequenceLength, maxSequenceGap, getSeqFingerprintAsSet);
    return clonesSeqs;
}