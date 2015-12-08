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

loc RESULTS_FILE = |cwd:///../src/Visualization/data/results.json|; 

public void exportData(TypedPairs typedPairs) {
    ResultSummary summary = ResultSummary("Small Sql", 124, 47);
        
    FilesWithClones filesWithClones = extractFilesWithClones(typedPairs);
    
    list[ClonePairsResult] clonePairsResults = extractClonePairsResult(typedPairs);
    
    // Start:
    list [str] dirs = toList(domain(filesWithClones));
    list [str] files = toList(range(filesWithClones));    
    
    str resultJson = 
        "{ 
        '   \"summary\": {
        '       \"project_name\": \"<summary.projectName>\",
        '       \"total_clones\": \"<summary.totalClones>\",
        '       \"duplicated_code\": \"<summary.duplicatedCode>%\"
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
        '               \"source_code\": \"<escape(clonePairsResults[r].origin.source, ("\"": "\\\"", "\n": "\\n", "\t": "\\t", "\r": "\\r"))>\"
        '           },
        '
        '           \"clone\": {
        '               \"file\": \"<clonePairsResults[r].clone.file>\",
        '               \"start_line\": \"<clonePairsResults[r].clone.startLine>\",
        '               \"end_line\": \"<clonePairsResults[r].clone.endLine>\",
        '               \"source_code\": \"<escape(clonePairsResults[r].clone.source, ("\"": "\\\"", "\n": "\\n", "\t": "\\t", "\r": "\\r"))>\"
        '           }
        '
        '       }<if (r != size(clonePairsResults)-1) {>,\n<}><}>
        '   ]      
        '}";

     writeFile(RESULTS_FILE, resultJson);
}
