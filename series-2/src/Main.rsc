module Main

import Configurations;

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import CloneDetection::Strategy::TypeOne;
import CloneDetection::CloneDetector;
import CloneDetection::AbstractClonePairs;

import CloneDetection::Utils;

import Prelude;
import util::Benchmark;

anno loc Statement @ src;
anno loc node @ src;

private loc getCombinedSequenceLocation(Sequence sequence) {
    firstStmt = sequence[0];
    lastStmt = last(sequence);
    
    length = lastStmt@src.offset + lastStmt@src.length - firstStmt@src.offset;
    
    uri = toLocation(firstStmt@src.uri);
    
    return uri(firstStmt@src.offset, length, <firstStmt@src.begin.line, firstStmt@src.begin.column>, <lastStmt@src.end.line, lastStmt@src.end.column>);
}

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
    
    clonePairs = detectTypeOne(asts);
    
    for (cloneKey <- clonePairs) {
        if (sequence(originSeq, cloneSeq) := clonePairs[cloneKey]) {
            if (size(originSeq) == 1) {
                origin = originSeq[0];
                clone = cloneSeq[0];
                iprintln(origin@src);
                println("-----");
                iprintln(clone@src);
                println("=========================================");
            } else {
                originSeqPath = getCombinedSequenceLocation(originSeq);
                cloneSeqPath = getCombinedSequenceLocation(cloneSeq);
                iprintln(originSeqPath);
                println("-----");
                iprintln(cloneSeqPath);
                println("=========================================");
            }
        }
    }
    
    endProfiling = realTime() * 1.0;
    totalTime = (endProfiling - startProfiling) / 1000;    
    println("Clone detection total time: <totalTime> seconds");
}