module Main

import Configurations;
import Strategy::Commons;
import Strategy::SimilarFragments;
import Strategy::ExactFragments;

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import Prelude;

void main()
{
    model = createAstsFromEclipseProject(getTestProjectLocation(), true);
    
    clones = findSimilarMethods(model);
    
    for (occurance <- clones) {
        println("ORIGINAL------------------------------");
        println(occurance.original@src);
        println(readFile(occurance.original@src));
        println("CLONE---------------------------------");
        println(occurance.clone@src);
        println(readFile(occurance.clone@src));
    }
}