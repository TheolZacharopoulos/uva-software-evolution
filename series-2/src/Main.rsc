module Main

import Configurations;

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import CloneDetection::Utils::ClonesGeneralize;
import CloneDetection::CloneDetector;
import CloneDetection::AbstractClonePairs;

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
    clonesSeqs = detectSequenceClones(asts);
    
    clonePairs = generalizeClones(clonesSeqs);
    
    for (cloneKey <- clonePairs) {
        if (sequence(originSeq, cloneSeq) := clonePairs[cloneKey]) {
            origin = originSeq[0];
            clone = cloneSeq[0];
            iprintln(origin@src);
            println("-----");
            iprintln(clone@src);
            println("=========================================");
        }
    }
    
    endProfiling = realTime() * 1.0;
    totalTime = (endProfiling - startProfiling) / 1000;    
    println("Clone detection total time: <totalTime> seconds");
}