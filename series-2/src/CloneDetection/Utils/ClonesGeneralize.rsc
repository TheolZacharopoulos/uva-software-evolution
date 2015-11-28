module CloneDetection::Utils::ClonesGeneralize

import CloneDetection::Statements::CloneStatementPairs;
import CloneDetection::AbstractClonePairs;
import CloneDetection::Statements::TreeSimilarity;
import Configurations;

import IO;
import Map;

@doc{
    Convert Clone pair sequence to Clone pair.
}
ClonePairs clonePairsSeqToClonePairs(ClonePairsSeq clonePairsSeq) {
    ClonePairs clonePairs = newClonePairs();

    for (cloneKey <- clonePairsSeq) {
        if (<Sequence originSeq, Sequence cloneSeq> := clonePairsSeq[cloneKey]) {
            clonePairs = addCloneToClonePairs(originSeq[0], cloneSeq[0], clonePairs);    
        }
    }
    return clonePairs;
}

ClonePairs generalizeClones(ClonePairsSeq clonePairsSeq) {

    // Bacause: C L A R I T Y 
    ClonePairs clones = clonePairsSeqToClonePairs(clonePairsSeq);
    
    // * 1. ClonesToGeneralize = Clones
    ClonePairs clonesToGeneralize = clones;
    
    // * 2. While ClonesToGeneralize≠∅
    for (clone <- clones, size(clonesToGeneralize) > 0) {
        
        // * 3. Remove clone(i,j) from ClonesToGeneralize
        clonesToGeneralize = removeCloneFromClonePairs(clones[clone].origin, clonesToGeneralize);
        
        // * 4. If CompareClones(ParentOf(i), ParentOf(j)) > SimilarityThreshold
        parentOfOrigin = getParentOf(clones[clone].origin);
        parentOfClone = getParentOf(clones[clone].clone);
        if (getSimilarityFactor(parentOfOrigin, parentOfClone) >= SIMILARITY_THRESHOLD) {
        
            // * 5. RemoveClonePair(Clones,i,j)
            clones = removeCloneFromClonePairs(clones[clone].origin, clones);
            
            // * 6. AddClonePair(Clones, ParentOf(i), ParentOf(j))
            clones = addCloneToClonePairs(parentOfOrigin, parentOfClone, clones); 
            
            // * 7. AddClonePair(ClonesToGeneralize, ParentOf(i),ParentOf(j))
            clonesToGeneralize = addCloneToClonePairs(parentOfOrigin, parentOfClone, clonesToGeneralize);
        }
    }
    return clones;
}