module Results::ResultsExtractor

import CloneDetection::AbstractClonePairs;
import Results::ResultDefinitions;
import CloneDetection::StrategyAggregate;
import Configurations;
import Prelude;

anno loc node @ src;

FilesWithClones extractFilesWithClones(TypedPairs typedPairs) {

    FilesWithClones filesWithClones = {};
    
    for (cloneType <- typedPairs, pairs <- typedPairs[cloneType]) {
        pair = typedPairs[cloneType][pairs];
        originLoc = getCombinedSequenceLocation(pair.origin);
        cloneLoc = getCombinedSequenceLocation(pair.clone);
        filesWithClones += <removeBasePath(originLoc.parent.path), originLoc.file>;
        filesWithClones += <removeBasePath(cloneLoc.parent.path), cloneLoc.file>;
    }
    
    return filesWithClones;
}

private str removeBasePath(str fullPath) {
    return substring(fullPath, size(getProjectLocation().path));
}

list[ClonePairsResult] extractClonePairsResult(TypedPairs typedPairs) {
    list[ClonePairsResult] results = [];
    set[loc] alreadyInUse = {};
    
    counter = 0;
    for (cloneType <- typedPairs, pairs <- typedPairs[cloneType]) {
        pair = typedPairs[cloneType][pairs];
        originLoc = getCombinedSequenceLocation(pair.origin);
        cloneLoc = getCombinedSequenceLocation(pair.clone);
        
        if (originLoc in alreadyInUse) continue;
        
        results += ClonePairsResult("clone_<counter>", cloneType, 
            CloneResult(originLoc.file, originLoc.begin.line, originLoc.end.line, readFile(originLoc)), 
            CloneResult(cloneLoc.file, cloneLoc.begin.line, cloneLoc.end.line, readFile(cloneLoc)));
        
        alreadyInUse += cloneLoc;
        counter += 1;
    }
    
    return results;
}

map[str, int] extractCloneQuantities(TypedPairs typedPairs) = (cloneType: size(typedPairs[cloneType]) | cloneType <- typedPairs);

private loc getCombinedSequenceLocation(Sequence sequence) {
    firstStmt = sequence[0];
    
    lastStmt = last(sequence);
    
    length = lastStmt@src.offset + lastStmt@src.length - firstStmt@src.offset + firstStmt@src.begin.column;
    
    uri = toLocation(firstStmt@src.uri);
    
    return uri(firstStmt@src.offset - firstStmt@src.begin.column, length, <firstStmt@src.begin.line, 0>, <lastStmt@src.end.line, lastStmt@src.end.column>);
}