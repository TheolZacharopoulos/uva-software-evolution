module Main

import Configurations;

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import CloneDetection::IdenticalClones;

import Prelude;

anno loc node @ src;

void main() {
    model = createAstsFromEclipseProject(getTestProjectLocation(), true);
    
    clones = detectExactClones(model);
    
    for (clone <- clones) {
        if (occurrance(node a, node b) := clone) {
            iprintln(a@src);
            println("-----");
            iprintln(b@src);
            println("=========================================");
        }
    }
}