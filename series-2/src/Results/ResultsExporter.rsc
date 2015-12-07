module Results::ResultsExporter

import IO;
import lang::json::IO;
import ListRelation;
import List;
import Map;
import String;
import Results::ResultDefinitions;

loc RESULTS_FILE = |project://Series-2/src/Visualization/data/results.json|; 

public void exportData() {
    ResultSummary summary = ResultSummary("Small Sql", 124, 47);
        
    FilesWithClones filesWithClones = [
        <"dir_1", "file_1.java">,
        <"dir_1", "file_2.java">,
        <"dir_2", "file_3.java">,
        <"dir_2", "file_4.java">,
        <"dir_2", "file_5.java">,
        <"dir_2", "file_6.java">,
        <"dir_2", "file_7.java">,
        <"dir_2", "file_8.java">,
        <"dir_2", "file_9.java">
    ];
    
    list[ClonePairsResult] clonePairsResults = [
        ClonePairsResult("clone_1", "type-1", 
            CloneResult("file1.java", "Class {\n \t private String name;\n}"),
            CloneResult("file1.java", "Class {\n \t private String name;\n}")),
        ClonePairsResult("clone_2", "type-1", 
            CloneResult("file1.java", "Class {\n \t private String name;\n}"),
            CloneResult("file2.java", "if (a \> 0) {\n System.out.println(\"Hello\");\n}")),
        ClonePairsResult("clone_3", "type-2", 
            CloneResult("file3.java", "if (s \> 21) {\n return 5;\n}"),
            CloneResult("file5.java", "if (xxx \> 3) {\n return 4;\n}"))
    ];
    
    // Start:
    list [str] dirs = domain(filesWithClones);
    list [str] files = range(filesWithClones);    
    
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
        '   \"files\": [ <for (f <- [0 .. size(files)]) {>\n\t\t{
        '          \"name\": \"<files[f]>\", 
        '          \"dir\": \"<invert(filesWithClones)[files[f]][0]>\"
        '        }<if (f != size(files)-1) {>,\n<}><}>
        '   ],
        '   
        '   \"clone_pairs\": [ <for (r <- [0 .. size(clonePairsResults)]) {>\n\t\t{
        '           \"id\": \"<clonePairsResults[r].id>\",
        '
        '           \"clone_type\": \"<clonePairsResults[r].cloneType>\",
        '
        '           \"origin\": {
        '               \"file\": \"<clonePairsResults[r].origin.file>\",
        '               \"source\": \"<escape(clonePairsResults[r].origin.source, ("\"": "\\\""))>\"
        '           },
        '
        '           \"clone\": {
        '               \"file\": \"<clonePairsResults[r].clone.file>\",
        '               \"source\": \"<escape(clonePairsResults[r].clone.source, ("\"": "\\\""))>\"
        '           }
        '
        '        }<if (r != size(clonePairsResults)-1) {>,\n<}><}>
        '   ]      
        '}";

     writeFile(RESULTS_FILE, resultJson);
}
