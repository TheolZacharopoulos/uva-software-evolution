module Main

import Configurations;
import CloneDetection::StrategyAggregate;
import CloneDetection::AbstractClonePairs;
import Results::ResultsExporter;
import CloneDetection::Utils;

import Prelude;
import util::Benchmark;
import lang::java::m3::AST;

private real startProfiling;
private real endProfiling;

int main(list[str] args) {
    
    startProfiling = realTime() * 1.0;
    
    // load asts
    profileStart("Loading AST..");
    asts = createAstsFromDirectory(getProjectLocation(args[0]), false, javaVersion="1.8");
    astsTime = profileEnd("Asts loaded in :time: seconds");
    
    // detect clones
    profileStart("Detecting clones. Grab a coffee, can take a while...");
    clonePairs = detectClones(asts);
    clonesTime = profileEnd("Clones detected in :time: seconds");
    
    // data export
    profileStart("Exporting data into json...");
    exportData(clonePairs, args[0]);
    dataExportTime = profileEnd("Export to json finished in :time: seconds");
    
    println("Everything done in <astsTime + clonesTime + dataExportTime> seconds.");
    
    return 0;
}

private void profileStart(str message) {
    startProfiling = realTime() * 1.0;
    println(message);
}

private real profileEnd(str message) {
    endProfiling = realTime() * 1.0;
    totalTime = (endProfiling - startProfiling) / 1000;

    println(replaceAll(message, ":time:", "<totalTime>"));
    
    return totalTime;
}