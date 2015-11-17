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
    
    println("**********METHODS**********");
    for (declaration(original, clone) <- clones) {
        println("ORIGINAL------------------------------");
        println(original@src);
        println(readFile(original@src));
        println("CLONE---------------------------------");
        println(clone@src);
        println(readFile(clone@src));
    }
}