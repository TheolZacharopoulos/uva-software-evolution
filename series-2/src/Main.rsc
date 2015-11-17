module Main

import Configurations;

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import CloneDetector;

import Prelude;

void main() {
    model = createAstsFromEclipseProject(getTestProjectLocation(), true);

    detectClones(model);
}