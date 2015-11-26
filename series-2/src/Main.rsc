module Main

import Configurations;

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import CloneDetection::CloneDetector;
import CloneDetection::Utils;

import Prelude;
import util::Benchmark;

anno loc Statement @ src;

void main() {
    startProfiling = realTime() * 1.0;
    
    // load asts
    asts = createAstsFromEclipseProject(getTestProjectLocation(), true);
    
    endProfiling = realTime() * 1.0;
    totalTime = (endProfiling - startProfiling) / 1000;    
    println("Asts loaded in <totalTime> seconds");
    
    // -------------------------------------------------
    startProfiling = realTime() * 1.0;
    
    asts = putIdentifiers(asts);    
    clones = detectExactClones(asts);
    
    for (cloneKey <- clones) {
        if (<Statement a, Statement b> := clones[cloneKey]) {
            iprintln(a@src);
            println("-----");
            iprintln(b@src);
            println("=========================================");
        }
    }
    
    endProfiling = realTime() * 1.0;
    totalTime = (endProfiling - startProfiling) / 1000;    
    println("Clone detection total time: <totalTime> seconds");
}