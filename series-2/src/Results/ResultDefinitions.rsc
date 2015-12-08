module Results::ResultDefinitions

import CloneDetection::AbstractClonePairs;

alias FilesWithClones = lrel[str dir, str file];

data ResultSummary = 
        ResultSummary(str projectName, int totalClones, int duplicatedCode);
        
data CloneResult =
         CloneResult(str file, int startLine, int endLine, str source);
         
data ClonePairsResult = 
        ClonePairsResult(str id, str cloneType, CloneResult origin, CloneResult clone);