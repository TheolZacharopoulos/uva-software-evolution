module Main

import Configurations;

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import CloneDetection::IdenticalClones;

import Prelude;

void main() {
    model = createAstsFromEclipseProject(getTestProjectLocation(), true);
    
    iprintln(delAnnotationsRec(detectExactClones(model)));
}