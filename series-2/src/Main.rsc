module Main

import Configurations;

import lang::java::m3::AST;

import CloneDetection::StrategyAggregate;
import CloneDetection::AbstractClonePairs;
import Results::ResultsExporter;

import CloneDetection::Utils;

import Prelude;
import util::Benchmark;

anno loc node @ src;

int main(list[str] args) {

    //unregisterLocations("java", "");

    startProfiling = realTime() * 1.0;
    
    // load asts
    asts = createAstsFromDirectory(getProjectLocation(args[0]), false, javaVersion="1.8");
    
    endProfiling = realTime() * 1.0;
    totalTime = (endProfiling - startProfiling) / 1000;    
    println("Asts loaded in <totalTime> seconds");
    
    // -------------------------------------------------
    startProfiling = realTime() * 1.0;
    
    clonePairs = detectClones(asts);
    
    exportData(clonePairs, args[0]);
    
    endProfiling = realTime() * 1.0;
    totalTime = (endProfiling - startProfiling) / 1000;    
    println("Clone detection total time: <totalTime> seconds");
    
    return 0;
}