module Results::ResultsExporter

import IO;
import lang::json::IO;
import Relation;
import List;
import Set;
import Map;
import String;
import Results::ResultDefinitions;
import Results::ResultsExtractor;
import CloneDetection::StrategyAggregate;
import Results::ProjectNames;
import Configurations;

public void exportData(TypedPairs typedPairs, str project) {
    ResultSummary summary = ResultSummary(getProjectName(project), extractCloneQuantities(typedPairs));
        
    FilesWithClones filesWithClones = extractFilesWithClones(typedPairs, project);
    
    list[ClonePairsResult] clonePairsResults = extractClonePairsResult(typedPairs);
    
    list [str] dirs = toList(domain(filesWithClones));
    list [str] files = toList(range(filesWithClones));
    
    str resultJson = 
        "{ 
        '   \"summary\": {
        '       \"project_name\": \"<summary.projectName>\"
        '   },
        '
        '   \"directories\": [ <for (d <- [0 .. size(dirs)]) {>\t
        '       \"<dirs[d]>\"<if (d != size(dirs)-1) {>,<}>\t<}>
        '   ],
        '
        '   \"files\": [ <for (f <- [0 .. size(files)]) {>
        '       {
        '          \"name\": \"<files[f]>\", 
        '          \"dir\": \"<toList(invert(filesWithClones))[files[f]][0]>\"
        '       }<if (f != size(files)-1) {>,\n<}><}>
        '   ],
        '   
        '   \"clone_pairs\": [ <for (r <- [0 .. size(clonePairsResults)]) {>
        '       {
        '           \"id\": \"<clonePairsResults[r].id>\",
        '
        '           \"clone_type\": \"<clonePairsResults[r].cloneType>\",
        '
        '           \"origin\": {
        '               \"file\": \"<clonePairsResults[r].origin.file>\",
        '               \"start_line\": \"<clonePairsResults[r].origin.startLine>\",
        '               \"end_line\": \"<clonePairsResults[r].origin.endLine>\",
        '               \"source_code\": \"<escapeSourceCode(clonePairsResults[r].origin.source)>\"
        '           },
        '
        '           \"clone\": {
        '               \"file\": \"<clonePairsResults[r].clone.file>\",
        '               \"start_line\": \"<clonePairsResults[r].clone.startLine>\",
        '               \"end_line\": \"<clonePairsResults[r].clone.endLine>\",
        '               \"source_code\": \"<escapeSourceCode(clonePairsResults[r].clone.source)>\"
        '           }
        '
        '       }<if (r != size(clonePairsResults)-1) {>,\n<}><}>
        '   ]      
        '}";

     writeFile(RESULTS_FILE, resultJson);
}

private str escapeSourceCode(str code) {

    map[str, str] replaceMap = (
        "\"": "\\\"", 
        "\\": "\\\\", 
        "\n": "\\n", 
        "\b": "\\b", 
        "\f": "\\f", 
        "\t": "\\t", 
        "\r": "\\r",
        "\\s": "\\\\s"
    );

    return escape(code, replaceMap);
}
