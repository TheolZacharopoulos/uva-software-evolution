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
    
    model = createAstsFromEclipseProject(getTestProjectLocation(), true);
    model = putIdentifiers(model);
    
    clones = detectSequenceClones(model);
    
    for (clone <- clones) {
        if (occurrance(Statement a, Statement b) := clone) {
            iprintln(a@src);
            println("-----");
            iprintln(b@src);
            println("=========================================");
        }
    }
    
    endProfiling = realTime() * 1.0;
    totalTime = (endProfiling - startProfiling) / 1000;    
    println("Total time: <totalTime> seconds");
}