module Main

import Configurations;

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import CloneDetection::StrategyAggregate;
import CloneDetection::AbstractClonePairs;
import Results::ResultsExporter;

import CloneDetection::Utils;

import Prelude;
import util::Benchmark;

anno loc Statement @ src;
anno loc node @ src;

/**
 * TODO Divide type 1, type 2 into separate strategies
 */
void main() {
    startProfiling = realTime() * 1.0;
    
    // load asts
    asts = createAstsFromEclipseProject(getTestProjectLocation(), true);
    
    endProfiling = realTime() * 1.0;
    totalTime = (endProfiling - startProfiling) / 1000;    
    println("Asts loaded in <totalTime> seconds");
    
    // -------------------------------------------------
    startProfiling = realTime() * 1.0;
    
    clonePairs = detectClones(asts);
    
    exportData(clonePairs);
    
    endProfiling = realTime() * 1.0;
    totalTime = (endProfiling - startProfiling) / 1000;    
    println("Clone detection total time: <totalTime> seconds");
}