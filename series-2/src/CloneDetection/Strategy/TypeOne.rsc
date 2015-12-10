module CloneDetection::Strategy::TypeOne

import CloneDetection::Utils::Fingerprinter;
import CloneDetection::Utils::ParentIndex;
import CloneDetection::Utils::ClonesGeneralize;
import CloneDetection::ClonePairs;
import CloneDetection::Statements::TreeSimilarity;
import CloneDetection::Sequences::StatementSequences;
import CloneDetection::Sequences::SubsequencesExtractor;
import CloneDetection::Sequences::SequenceBucket;
import CloneDetection::Utils::ProgressTracker;
import CloneDetection::SequenceClonesDetector;
import Configurations;

import lang::java::m3::AST;
import List;
import IO;
import Set;

ClonePairs detectTypeOne(set[Declaration] asts, int minSequenceLength) {
    collectChildrenToParentIndexFromAST(asts);
    clonesSeqs = detectSequenceClones(asts, minSequenceLength, getSeqFingerprint);
    return generalizeClones(clonesSeqs, areParentsEqual);    
}

private bool areParentsEqual(node treeA, node treeB) = treeA == treeB;