module Results::ResultDefinitions

import CloneDetection::AbstractClonePairs;

alias FilesWithClones = rel[str dir, str file];

data ResultSummary = 
        ResultSummary(str projectName, map[str cloneType, int quantity] cloneQuantities);

data CloneResult =
         CloneResult(str file, int startLine, int endLine, str source);

data ClonePairsResult = 
        ClonePairsResult(str id, str cloneType, CloneResult origin, CloneResult clone);